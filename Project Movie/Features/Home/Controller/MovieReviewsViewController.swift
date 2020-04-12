//
//  MovieReviewsViewController.swift
//  Project Movie
//
//  Created by Cahaya Ramadhan on 12/04/20.
//  Copyright © 2020 Cahaya Ramadhan. All rights reserved.
//

import UIKit
import SwiftyJSON

class MovieReviewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var reviewTableView: UITableView!
    
    var dataMovieReviews = [MovieReviews]()
    var movieId = 0
    var page = 1
    var totalPages = 0
    var totalReviews = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Reviews"
        
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        
        getMovieReviews()
        
        reviewTableView.register(UINib.init(nibName: "ReviewsTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewsTableViewCell")
        // Do any additional setup after loading the view.
    }
    
    func getMovieReviews() {
        NetworkingClient.shared.getMovieReviews(movieId: movieId, page: page) { (status, response) in
            
            print(response!)
            
            self.totalPages = response!["total_pages"].intValue
            self.totalReviews = response!["total_results"].intValue
            
            print(self.totalPages)
            
            for item in response!["results"].arrayValue {
                
                self.dataMovieReviews.append(MovieReviews(response: item))
                
            }
            
            self.reviewTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataMovieReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = reviewTableView.dequeueReusableCell(withIdentifier: "ReviewsTableViewCell", for: indexPath) as? ReviewsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.authorLabel.text = dataMovieReviews[indexPath.row].author
        cell.contentLabel.text = dataMovieReviews[indexPath.row].content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if page <= totalPages {
            if indexPath.row == dataMovieReviews.count - 1 {
                page += 1
                if dataMovieReviews.count < totalReviews {
                    DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                        NetworkingClient.shared.getMovieReviews(movieId: self.movieId, page: self.page) { (status, response) in
                            
                            for item in response!["results"].arrayValue {
                                
                                self.dataMovieReviews.append(MovieReviews(response: item))
                                
                            }
                            
                            self.reviewTableView.reloadData()
                        }
                    })
                }
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
