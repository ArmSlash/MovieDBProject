//
//  SearchVC.swift
//  MovieDBProject
//
//  Created by Andrew Scherbina on 24/11/2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit
import AlamofireImage

class SearchVC: UIViewController {
    
    let movieManager = MoviesFetchManager()
    @IBOutlet weak var tableView: UITableView!
    
    var movies:[Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieManager.delegate = self
    }
    
    
}
extension SearchVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? MovieTableViewCell else {
            return UITableViewCell()
        }
        if indexPath.row <= movies.count{
            cell.title.text = movies[indexPath.row].title
            cell.date.text = movies[indexPath.row].releaseDate
            
            if (movieManager.movies[indexPath.row].posterPath != nil) {
                let urlString = movieManager.baseURLforImages + movies[indexPath.row].posterPath!
                let url = URL(string: urlString)
                cell.poster.af_setImage(withURL: url!, placeholderImage: UIImage(named: "noImage.png"))
            }else{
                cell.poster.image = UIImage(named: "noImage.png")
            }
        }
        return cell
        
    }
    
    
}

extension SearchVC: MovieFetchManagerDelegate{
    func gotMovie() {
        if movies.count > 0{
            tableView.reloadData()
        }
    }
}

extension SearchVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVc = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        
        if indexPath.row <= movies.count{
            let movie = movies[indexPath.row]
            detailVc.movie = movie
            self.navigationController?.pushViewController(detailVc, animated: true)
        }
    }
}


extension SearchVC: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.endEditing(true) 
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("did change")
        movies.removeAll()
        tableView.reloadData()
        movieManager.findMovie(for: searchBar.text!)
        
    }
    
    
}

