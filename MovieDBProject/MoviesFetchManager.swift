//
//  NetworkManager.swift
//  MovieDBProject
//
//  Created by Andrew Scherbina on 23/11/2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit
import Alamofire

protocol MovieFetchManagerDelegate {
    var movies:[Movie]{ get set }
    func gotMovie()
}

class MoviesFetchManager {
    
    
    var delegate:MovieFetchManagerDelegate?
    
    let baseURLforImages = "http://image.tmdb.org/t/p/w500/"
    private let apiKey = "65efc20976dfb20b2c897a1d72803feb"
    
   
    var movies = [Movie]()
    
    func fetchTopMovies(){
        let url = "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)"
        fetchMovies(for: url)
        
    }
    
    func findMovie(for query: String){
        let urlEncodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(urlEncodedQuery)"
        fetchMovies(for: url)
    }
    
    
    
    private func fetchMovies(for url: String){
        
        Alamofire.request(url).responseJSON { response in
            switch response.result{
            case .success(let value):
                var fetchedMovies: [Movie] = []
                guard let jsonResponse = value as? NSDictionary else {return}
                guard let results = jsonResponse["results"] as? NSArray else {return}
                
                for result in results{
                    let dict = result as! NSDictionary
                    let id = dict["id"] as! Int
                    let title = dict["title"] as! String
                    let releaseDate = dict["release_date"] as! String
                    let overview = dict["overview"] as! String
                    let posterPath = dict["poster_path"] as? String
                    
                    let movie = Movie()
                    movie.id = id
                    movie.title = title
                    movie.releaseDate = releaseDate
                    movie.overview = overview
                    movie.posterPath = posterPath
                    
                    fetchedMovies.append(movie)
                }
                self.movies.removeAll()
                print(self.movies.count)
                self.movies = fetchedMovies
                print(self.movies.count)
                self.delegate?.movies = self.movies
                self.delegate?.gotMovie()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}
