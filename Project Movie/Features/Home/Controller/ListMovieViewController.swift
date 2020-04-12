//
//  ListMovieViewController.swift
//  Project Movie
//
//  Created by Cahaya Ramadhan on 11/04/20.
//  Copyright © 2020 Cahaya Ramadhan. All rights reserved.
//

import UIKit
import SwiftyJSON

class ListMovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var listMovieTableView: UITableView!
    
    var getMovieData = [MovieList]()
    var moviesDetails: MovieList?
    var idGenre = 0
    var id = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "List Movie"

        listMovieTableView.delegate = self
        listMovieTableView.dataSource = self
        
        listMovieTableView.register(UINib.init(nibName: "ListMovieTableViewCell", bundle: nil), forCellReuseIdentifier: "ListMovieTableViewCell")
        
        getMovie()
        
    }
    
    func getMovie() {
        
        NetworkingClient.shared.getMovieList(id: id) { (status, response) in
            
            var match = false
            
            for item in response!["items"].arrayValue {
                
                for item2 in item["genre_ids"].arrayValue {
                    
                    if item2.intValue == self.idGenre {
                        match = true
                        break
                    } else {
                        match = false
                    }
                    
                }
                
                if match == true {
                    self.getMovieData.append(MovieList(response: item))
                }
                
            }
            
            print(self.idGenre)
            print(self.getMovieData)
            
            self.listMovieTableView.reloadData()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getMovieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listMovieTableView.dequeueReusableCell(withIdentifier: "ListMovieTableViewCell", for: indexPath) as? ListMovieTableViewCell else {
            return UITableViewCell()
        }
        
        cell.nameMovie.text = getMovieData[indexPath.row].title!
        
        if let imageURL = URL(string:"https://image.tmdb.org/t/p/w500\(getMovieData[indexPath.row].poster_path ?? "")"){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let imageData = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.imageMovie.image = imageData!
                    }
                }
                
            }
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 182
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moviesDetails = getMovieData[indexPath.row]
        self.performSegue(withIdentifier: "segueToDetails", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetails" {
            
            let destVC = segue.destination as! MovieDetailViewController
            destVC.detailMovie = moviesDetails
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
