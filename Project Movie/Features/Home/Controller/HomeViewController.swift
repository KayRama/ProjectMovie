//
//  ViewController.swift
//  Project Movie
//
//  Created by Cahaya Ramadhan on 11/04/20.
//  Copyright © 2020 Cahaya Ramadhan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var genreTableView: UITableView!
    
    var genreData = [Genres]()
    var getId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genreTableView.delegate = self
        genreTableView.dataSource = self
        
        genreTableView.register(UINib.init(nibName: "GenreTableViewCell", bundle: nil), forCellReuseIdentifier: "GenreTableViewCell")
        
        getGenre()
        
    }
    
    func getGenre() {
        
        NetworkingClient.shared.getGenreListMovie { (status, response) in
            
            for item in response!["genres"].arrayValue {
                self.genreData.append(Genres(response: item))
            }
            
            self.genreTableView.reloadData()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = genreTableView.dequeueReusableCell(withIdentifier: "GenreTableViewCell", for: indexPath) as? GenreTableViewCell else {
            return UITableViewCell()
        }
        
        cell.labelGenre.text = genreData[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getId = genreData[indexPath.row].id ?? 0
        
        self.performSegue(withIdentifier: "segueToListMovie", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToListMovie" {
            
            let destVC = segue.destination as! ListMovieViewController
            destVC.idGenre = getId
            getId = 0
        }
    }
    
    
}

