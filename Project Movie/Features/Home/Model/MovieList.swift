//
//  MovieList.swift
//  Project Movie
//
//  Created by Cahaya Ramadhan on 12/04/20.
//  Copyright © 2020 Cahaya Ramadhan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MovieList {
    var poster_path: String?
    var popularity: Int?
    var vote_count: Int?
    var video: Bool?
    var media_type: String?
    var id: Int?
    var adult: Bool?
    var backdrop_path: String?
    var original_language: String?
    var original_title: String?
    var genre_ids: Any?
    var title: String?
    var vote_average: Float?
    var overview: String?
    var release_date: String?
    
    init(response: JSON) {
        poster_path = response["poster_path"].stringValue
        popularity = response["popularity"].intValue
        vote_count = response["vote_count"].intValue
        video = response["video"].boolValue
        media_type = response["media_type"].stringValue
        id = response["id"].intValue
        adult = response["adult"].boolValue
        backdrop_path = response["backdrop_path"].stringValue
        original_language = response["original_language"].stringValue
        original_title = response["original_title"].stringValue
        genre_ids = response["genre_ids"]
        title = response["title"].stringValue
        vote_average = response["vote_average"].floatValue
        overview = response["overview"].stringValue
        release_date = response ["release_date"].stringValue
    }
}
