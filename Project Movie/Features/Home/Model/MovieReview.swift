//
//  MovieReview.swift
//  Project Movie
//
//  Created by Cahaya Ramadhan on 12/04/20.
//  Copyright © 2020 Cahaya Ramadhan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MovieReviews {
    var author: String?
    var content: String?
    var id: String?
    var url: String?
    
    init(response: JSON) {
        author = response["author"].stringValue
        content = response["content"].stringValue
        id = response["id"].stringValue
        url = response["String"].stringValue
    }
}
