//
//  MovieDetailViewController.swift
//  Project Movie
//
//  Created by Cahaya Ramadhan on 12/04/20.
//  Copyright © 2020 Cahaya Ramadhan. All rights reserved.
//

import UIKit
import AVKit
import SwiftyJSON
import YoutubePlayer_in_WKWebView

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var trailerListStackView: UIStackView!
    
    var detailMovie: MovieList?
    var dataMovieVideo = [MovieVideo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMovieVideo()
        setupView()
        
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        
        reviewButton.layer.cornerRadius = 7
        
        titleLabel.text = detailMovie?.title
        popularityLabel.text = "Popularity: \(detailMovie!.popularity ?? 0)"
        voteLabel.text = "Vote Total: \(detailMovie!.vote_average ?? 0)"
        voteAverageLabel.text = "Vote Avarage: \(detailMovie!.vote_count ?? 0)"
        overview.text = "Overview: \(detailMovie!.overview ?? "")"
        
        if let imageURL = URL(string:"https://image.tmdb.org/t/p/w500\(detailMovie?.poster_path ?? "")"){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let imageData = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.movieImage.image = imageData!
                    }
                }
                
            }
        }
        
        
    }
    
    func getMovieVideo() {
        NetworkingClient.shared.getMovieVideo(movieId: detailMovie!.id ?? 0) { (status, response) in
            
            for item in response!["results"].arrayValue {
                self.dataMovieVideo.append(MovieVideo(response: item))
            }
            
            self.trailerListStackView.arrangedSubviews.forEach { (list) in
                self.trailerListStackView.removeArrangedSubview(list)
            }
            
            self.dataMovieVideo.forEach { (listVideo) in
                if let card = UINib(nibName: String(describing: TrailerDetailView.self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? TrailerDetailView {
                    card.playerView.load(withVideoId: listVideo.key!)
                    card.playerView.layer.cornerRadius = 7
                    card.layer.cornerRadius = 7
                    
                    self.trailerListStackView.addArrangedSubview(card)
                }
            }
            
        }
        
       
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToReviews" {
            
            let destVC = segue.destination as! MovieReviewsViewController
            destVC.movieId = detailMovie!.id!
            
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
