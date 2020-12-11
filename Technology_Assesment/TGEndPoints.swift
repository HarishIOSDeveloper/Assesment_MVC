//
//  TGEndPoints.swift
//  Technology_Assesment
//
//  Created by Haritej on 11/12/20.
//  Copyright © 2020 com.ipac.iOS. All rights reserved.
//

import Foundation
import Alamofire

enum TGEndPoints : APIRouteConfiguration {    
    case getList
    var method: HTTPMethod {
        switch self {
        case .getList:
            return .get
        }
    }
    var path: String {
        switch self {
        case .getList:
            return "v2/viewed/7.json"
            //Static Key
        }
    }
    var parameters: Parameters? {
        switch self {
        case .getList:
            return nil
        }
    }
    func asURLRequest() throws -> URLRequest {
        var url: URL
        url = try BaseUrl.ProductionServer.baseURL_PHP.asURL()
        var urlComponents = URLComponents(string: BaseUrl.ProductionServer.baseURL_PHP)!
        urlComponents.queryItems = [
            URLQueryItem(name: "api-key", value: "Kl1usjsy5ytdAHuxxBwIsO8v651nuEet"),
        ]
        url = urlComponents.url!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}
struct BaseUrl {
    struct ProductionServer {
        public static let baseURL_PHP = "http://api.nytimes.com/svc/mostpopular/"
    }
}
enum HTTPHeaderField: String {
    case authentication     = "Authorization"
    case contentType        = "Content-Type"
    case acceptType         = "Accept"
    case acceptEncoding     = "Accept-Encoding"
}
enum ContentType: String {
    case json               = "application/json"
}
