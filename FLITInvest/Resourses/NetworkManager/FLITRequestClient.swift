//
//  FLITRequestClient.swift
//  FLITInvest
//
//  Created by 董静 on 8/17/21.
//

import Foundation
import Alamofire

class FLITRequestClient {
    
    static let shared = FLITRequestClient()

    enum HTTPMethod {
        case GET
        case POST
    }
    
    enum  HTTPError: Error{
        case NetWorkError
        case ServerError
        case requestError
    }
    
    var baseUrl:URL {
        return API.baseURL
    }
    
    var defaultHeaders : HTTPHeaders{
        // redefine headers
        var headers : HTTPHeaders = ["client-id" : "FLITInvest",
                                   "User-Agent" : "iOS",
                                   "device-info":"FLITInvest"]
        
        // Have login token, store into the header
        if !TokenManager.shared.getToken().isEmpty {
            headers.add(name: "Authorization", value: "token_valuue")
        }
        return headers
    }
    
    /// Basic get request interface
    /// - Parameters:
    ///   - url: URL Type
    ///   - method: Request Method GET
    ///   - completion: Completion callback
    func basicGetRequest(path: String,
                         parameters: [String: Any?],
                         success: @escaping (_ result: AnyObject) -> Void,
                         falure: @escaping (_ error: Error) -> Void){
        
        // login -> server responds with token -> save token -> send with token ->
        // valid -> server process your rquest -> return a reuslt
        // invalid -> return an erorr 401
        // refresh token: call an api from server _-> server return a new token -> save token 
        //
    // cover error: invalid token, expired -> response AuthoizationError
        // Combining url
        let url: URL
        if path.starts(with: "http") == false {
            url = baseUrl.appendingPathComponent(path)
        } else {
            url = URL(string: path)!
        }
        
        //  Open to add new header parameter
        //et allHeaders = HTTPHeaders(defaultHeaders.dictionary.merging((headers ?? []).dictionary) { $1 })

        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: defaultHeaders).responseJSON { response in
            switch response.result {
            case.success(let result):
                if let dic = result as? AnyObject {
                    DispatchQueue.main.async {
                        success(dic)
                    }
                }
//                if let dic = result as? [String:Any] {
//                    DispatchQueue.main.async {
//                        success(dic)
//                    }
//                }
            case.failure(let error):

                DispatchQueue.main.async {
                    falure(error)
                }
            }
        }
    }
    
    func get(path: String,
                         parameters: [String: Any?],
                         success: @escaping (_ result: AnyObject) -> Void,
                         falure: @escaping (_ error: Error) -> Void){
        
        // Combining url
        let url: URL
        if path.starts(with: "http") == false {
            url = baseUrl.appendingPathComponent(path)
        } else {
            url = URL(string: path)!
        }
        
        //  Open to add new header parameter
        //et allHeaders = HTTPHeaders(defaultHeaders.dictionary.merging((headers ?? []).dictionary) { $1 })

        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: defaultHeaders)
            .responseData { (data) in
                guard let rawData = data.data else { return }
                do {
                    let countries = try JSONDecoder().decode([Country].self, from: rawData)
                    print(countries)
                } catch(let error) {
                    print(error)
                }
            }
    }
    
    
    /// Basic get request interface
    /// - Parameters:
    ///   - url: URL Type
    ///   - method: Request Method POST
    ///   - completion: Completion callback
    func basicPostRequest(path: String,
                          parameters: [String: Any?],
                          success: @escaping (_ result: [String: Any]?) -> Void,
                          falure: @escaping (_ error: Error) -> Void) {
        
        // Combining url
        let url = baseUrl.appendingPathComponent(path)

        //  Open to add new header parameter
        //  let allHeaders = HTTPHeaders(defaultHeaders.dictionary.merging((headers ?? []).dictionary) { $1 })
        
        // Post request
        AF.request(url, method: .post, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case.success(let result):
            if let dic = result as? [String:Any]     {
                    DispatchQueue.main.async {
                        success(dic)
                    }
                }
            case.failure(let error):
                DispatchQueue.main.async {
                    falure(error)
                }
            }
        }
    }
}
