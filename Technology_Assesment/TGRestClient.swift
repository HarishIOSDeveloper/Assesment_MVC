//
//  TGRestClient.swift
//  Technology_Assesment
//
//  Created by Haritej on 11/12/20.
//  Copyright © 2020 com.ipac.iOS. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkState {
    
    var isConnected: Bool {
        return NetworkReachabilityManager(host: "www.apple.com")!.isReachable
    }
    
}


protocol APIRouteConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}


class TGRestClient {
    
    //Shared Instance
    
    private static var sharedInstancc = TGRestClient()
    
    private init() {
        
    }
    
    class var sharedInstanc : TGRestClient? {
        get {
            return sharedInstancc
        }
    }
    
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    @discardableResult
    func performRequest<GenericModel:Decodable>(route:APIRouteConfiguration, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<GenericModel,AFError>,Data,String,Bool,Int)->Void) -> DataRequest {
        
        var statusMessage = "The request timed out." //"Unknown error"
        var status:Bool = false
        var statusCodee = 0
        
        return AF.request(route).responseJSON(completionHandler: { (response) in
            debugPrint("=====================", response)
            // check response message and status
            if let responseData = response.data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] {
                        if let statusCode = json["status"] as? Int {
                            print(statusCode)
                            statusCodee = statusCode
                            if statusCode == 200 {
                                status = true
                                statusMessage = json["message"] as? String ?? ""
                            }else if statusCode == 201 {
                                status = false
                                statusMessage = json["message"] as? String ?? ""
                            }else if statusCode == 400 {
                                status = false
                                statusMessage = json["message"] as? String ?? ""
                            } else if statusCode == 401 {
                                status = false
                                statusMessage = json["message"] as? String ?? ""
                               // APP_DELEGATE.pushToLoginViewContoller()
                            } else {
                                status = false
                                statusMessage = json["status"] as? String ?? ""
                                debugPrint("Response false status message :",statusMessage)
                            }
                        }
                    }
                } catch let error as NSError {
                    print("Response error: \(error.localizedDescription)")
                }
            }
            
        }).responseDecodable(completionHandler: { (response: DataResponse<GenericModel, AFError>) in
            completion(response.result, response.data ?? Data(), statusMessage , status,statusCodee)
        })
    }
    
    
    @discardableResult
    func performRequestForResponseInDictionary(route:APIRouteConfiguration, completion:@escaping (
        [String:Any], Data ,String, Bool,Int)->Void) -> DataRequest {
        
        var statusMessage = "The request timed out." //"Unknown error"
        var status:Bool = false
        var statusCodee = 0
        
        return AF.request(route).responseJSON(completionHandler: { (response) in
            debugPrint(response)
            // check response message and status
            if let responseData = response.data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] {
                        if let statusCode = json["status"] as? Int {
                            print(statusCode)
                            statusCodee = statusCode
                            if statusCode == 200 {
                                status = true
                                statusMessage = json["message"] as? String ?? ""
                            } else {
                                status = false
                                statusMessage = json["status"] as? String ?? ""
                                debugPrint("Response false status message :",statusMessage)
                            }
                            completion( json as [String:Any], responseData,statusMessage, status,statusCodee)
                        }
                    }
                } catch let error as NSError {
                    print("Response error: \(error.localizedDescription)")
                }
            }
        })
        
    }
    
    
    func uploadImgage(route:APIRouteConfiguration, image : UIImage, completion:@escaping (DataResponse<Any,AFError>)->Void) {
        
        let payload = route.parameters
        
        let multipartFormData = MultipartFormData()
        for (key, value) in payload! {
            
            if let dataStr = value as? String {
                multipartFormData.append(dataStr.data(using: .utf8)!, withName: key)
            }
            if let data = value as? Int {
                let dataStr = String(data)
                multipartFormData.append(dataStr.data(using: .utf8)!, withName: key)
            }
            if let data = value as? Bool {
                let dataStr = String(data)
                multipartFormData.append(dataStr.data(using: .utf8)!, withName: key)
            }
            if let data = value as? Float {
                let dataStr = String(data)
                multipartFormData.append(dataStr.data(using: .utf8)!, withName: key)
            }
            if let dataVal  = value as? Data {
                multipartFormData.append(dataVal, withName: key,fileName: "image.png",mimeType: "image/png")
            }
            
        }
        
        AF.upload(multipartFormData: multipartFormData, with: route).responseJSON(completionHandler: { (response) in
            debugPrint("Upload image Response : ", response)
            completion(response)
            
            var statusMessage = "The request timed out." //"Unknown error"
            var status:Bool = false
            var statusCodee = 0
                 
            if let responseData = response.data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] {
                        if let statusCode = json["status"] as? Int {
                            print(statusCode)
                            statusCodee = statusCode
                            if statusCode == 200 {
                                status = true
                                statusMessage = json["message"] as? String ?? ""
                            } else if statusCode == 400 {
                                status = false
                                statusMessage = json["status"] as? String ?? ""
                            //    HHelper.showAlert(statusMessage)
                                debugPrint("Response false status message :",statusMessage)
                            }
                        }
                    }
                } catch let error as NSError {
                    print("Response error: \(error.localizedDescription)")
                }
            }
        })
    }
    
}

struct CommonResponse:  Codable {
    let statusCode: Int?
    let statusMessage: String?
    let resultCode:Int?
    
    enum CodingKeys: String, CodingKey {
        case statusCode     = "status"
        case statusMessage  = "message"
        case resultCode     = "result"
    }
    
}
