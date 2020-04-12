//
//  Genres.swift
//  Project Movie
//
//  Created by Cahaya Ramadhan on 11/04/20.
//  Copyright © 2020 Cahaya Ramadhan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Genres {
    var name : String?
    var id : Int?
    
    init(response: JSON) {
        name = response["name"].stringValue
        id = response["id"].intValue
    }
}
