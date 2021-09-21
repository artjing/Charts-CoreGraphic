//
//  FLITRequest.swift
//  FLITInvest
//
//  Created by 董静 on 7/25/21.
//

import Foundation

class FLITRequestManager {
    

static let shared = FLITRequestManager()
    
enum HTTPMethod: String {
    case GET
    case POST
}

enum HTTPError: Error {
    case failedGetRequestData
}

struct FLITErrorInfo {
    var code = 0
    var message = ""
    var error = NSError()
}

func createBaseRequest(with url: URL?,
                   type: HTTPMethod,
                   completion: @escaping(Result<AnyObject, Error>) -> Void) {
    
    guard let url = url else {
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = type.rawValue
    request.timeoutInterval = 30.0
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard let data = data, error == nil else{
            completion(.failure(HTTPError.failedGetRequestData))
            return
        }
        do {
            let result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print(result)
        }
        catch{
            completion(.failure(error))
        }
        
    }
    task.resume()
    
}

}
