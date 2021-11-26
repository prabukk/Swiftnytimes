//
//  APIRequest.swift
//  Swiftnytimes
//
//  Created by prabu.karuppaiah on 26/11/21.
//

import Foundation
import Alamofire
import SwiftyJSON
  
enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"
}

struct HTTPHeader {
    let field: String
    let value: String
}

class APIRequest {
    let method: HTTPMethod
    let path: String
    var queryItems: [URLQueryItem]?
    var headers: [HTTPHeader]?
    var body: Data?

    init(method: HTTPMethod, path: String) {
        self.method = method
        self.path = path
    }
}

enum APIError: Error {
    case invalidURL
    case requestFailed
}

struct APIClient {

    typealias APIClientCompletion = (HTTPURLResponse?, Data?, APIError?) -> Void

    private let session = URLSession.shared

    func request(method: String, path: String, _ completion: @escaping APIClientCompletion) {
        
         let baseURL = URL(string: path)

        guard let url = baseURL?.appendingPathComponent(path) else {
            completion(nil, nil, .invalidURL); return
        }

        var request = URLRequest(url: (baseURL as? URL)!)
        request.httpMethod = method
        request.setValue(Constants.kBasic, forHTTPHeaderField: Constants.kAuthorization)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, nil, .requestFailed); return
            }
            completion(httpResponse, data, nil)
        }
        task.resume()
    }
 
}

