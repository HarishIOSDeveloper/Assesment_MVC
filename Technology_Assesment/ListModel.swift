//
//  ListModel.swift
//  Technology_Assesment
//
//  Created by Haritej on 11/12/20.
//  Copyright © 2020 com.ipac.iOS. All rights reserved.
//

import Foundation

struct ListResponseMaster: Codable {
    let status : String?
    let copyright : String?
    let num_results : Int?
    let results : [ListResponse]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case copyright = "copyright"
        case num_results = "num_results"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try? values.decodeIfPresent(String.self, forKey: .status)
        num_results = try? values.decodeIfPresent(Int.self, forKey: .num_results)
        copyright = try? values.decodeIfPresent(String.self, forKey: .copyright)
        results = try? values.decodeIfPresent([ListResponse].self, forKey: .results)
    }

}

struct ListResponse : Codable {
    let title : String?
    let abstract : String?
    let published_date : String?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case abstract = "abstract"
        case published_date = "published_date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try? values.decodeIfPresent(String.self, forKey: .title)
        abstract = try? values.decodeIfPresent(String.self, forKey: .abstract)
        published_date = try? values.decodeIfPresent(String.self, forKey: .published_date)
    }

}
