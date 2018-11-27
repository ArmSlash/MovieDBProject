//
//  Movie.swift
//  MovieDBProject
//
//  Created by Andrew Scherbina on 23/11/2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import RealmSwift


class Movie: Object {
    @objc dynamic var id = 0
    @objc dynamic var title: String?
    @objc dynamic var releaseDate: String?
    @objc dynamic var overview: String?
    @objc dynamic var posterPath: String?
    @objc dynamic var poster: Data?
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


