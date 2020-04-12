//
//  Networking.swift
//  Project Movie
//
//  Created by Cahaya Ramadhan on 11/04/20.
//  Copyright © 2020 Cahaya Ramadhan. All rights reserved.
//

import Alamofire
import SwiftyJSON

class NetworkingClient {

    var dispatchGroup = DispatchGroup()
    var token = "17d032a1f9f9954e8dd3e846ecdec61f"
    static let shared = NetworkingClient()
    
    func access(method: HTTPMethod, url: String, params: [String:Any], callback: @escaping(_ result: Bool, _ jsonResult: JSON?) -> Void) {
        
        Alamofire.request(url, method: method, parameters: params, encoding: URLEncoding.methodDependent).responseJSON { (response) in
            print("Alamofire Online")
            
            if response.result.isFailure {
                callback(false, nil)
                print("alamofire is failure \(String(describing: response.result.error?.localizedDescription))")
            } else {
                callback(true, JSON(response.result.value!))
                print("alamo fire is standby")
            }
        }
    }
    
    func getGenreListMovie(callback: @escaping(_ result: Bool, _ jsonResult: JSON?)->Void) {
        
        self.access(method: .get, url: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(token)&language=en-US", params: [:]) { (status, response) in
            if response == nil {
                print("Get Data Failure")
                callback(false, response)
            } else {
                callback(true, response)
            }
        }
        
    }
    
    func getMovieList(id: Int, callback: @escaping(_ result: Bool, _ jsonResult: JSON?)->Void) {
        
        self.access(method: .get, url: "https://api.themoviedb.org/3/list/1?api_key=\(token)&language=en-US", params: [:]) { (status, response) in
            if response == nil {
                print("Get Data Failure")
                callback(false, response)
            } else {
                callback(true, response)
            }
        }
        
    }
    
    func getMovieVideo(movieId: Int, callback: @escaping(_ result: Bool, _ jsonResult: JSON?)->Void) {
        
        self.access(method: .get, url: "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=\(token)&language=en-US", params: [:]) { (status, response) in
            if response == nil {
                print("Get Data Failure")
                callback(false, response)
            } else {
                callback(true, response)
            }
        }
        
    }
    
    func getMovieReviews(movieId: Int, page: Int, callback: @escaping(_ result: Bool, _ jsonResult: JSON?)->Void) {
        
        self.access(method: .get, url: "https://api.themoviedb.org/3/movie/\(movieId)/reviews?api_key=\(token)&language=en-US&page=\(page)", params: [:]) { (status, response) in
            if response == nil {
                print("Get Data Failure")
                callback(false, response)
            } else {
                callback(true, response)
            }
        }
        
    }
}

