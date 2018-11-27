//
//  DBManager.swift
//  MovieDBProject
//
//  Created by Andrew Scherbina on 27/11/2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit
import RealmSwift

class DBManager: NSObject{

    let realm = try! Realm()
    
    func save(movie: Movie){
      try! realm.write {
        realm.create(Movie.self, value: ["id": movie.id,
                                         "title": movie.title,
                                         "releaseDate": movie.releaseDate,
                                         "overview": movie.overview,
                                         "posterPath": movie.posterPath,
                                         "poster": movie.poster], update: true)
        }
    }

    
    func removeFromDB(movie:Movie){
        try! realm.write {
            let id = movie.id
            if let object = realm.object(ofType: Movie.self, forPrimaryKey: id  ){
                realm.delete(object)
            }
        }
    }
    
    func isAlreadyInDB(movie:Movie)->Bool{
      let id = movie.id
      return realm.object(ofType: Movie.self, forPrimaryKey: id) != nil
    }
    
    func storedMovies()->[Movie]{
        
        var movies:[Movie] = []
        let objects = realm.objects(Movie.self)
        for object in objects {
          movies += [object]
        }
        return movies
    }
    
    func removeAll() {
      try! realm.write {
            realm.deleteAll()
        }
        
    }
    
    
}
