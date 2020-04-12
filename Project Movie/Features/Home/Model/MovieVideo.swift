//
//  MovieVideo.swift
//  Project Movie
//
//  Created by Cahaya Ramadhan on 12/04/20.
//  Copyright © 2020 Cahaya Ramadhan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MovieVideo {
    var id: String?
    var iso_639_1: String?
    var iso_3166_1: String?
    var key: String?
    var name: String?
    var site: String?
    var size: String?
    var type: String?
    
    init(response: JSON) {
        id = response["id"].stringValue
        iso_639_1 = response["iso_639_1"].stringValue
        iso_3166_1 = response["iso_3166_1"].stringValue
        key = response["key"].stringValue
        name = response["name"].stringValue
        site = response["site"].stringValue
        size = response["size"].stringValue
        type = response["type"].stringValue
        
    }
}

