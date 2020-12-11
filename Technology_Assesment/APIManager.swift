//
//  APIManager.swift
//  Technology_Assesment
//
//  Created by Haritej on 11/12/20.
//  Copyright © 2020 com.ipac.iOS. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {

//Get Login Api

static func getList(completion:@escaping (Result<ListResponseMaster,AFError>,Data ,String, Bool,Int)->Void) {
    TGRestClient.sharedInstanc?.performRequest(route: TGEndPoints.getList, completion: completion)
}
}
