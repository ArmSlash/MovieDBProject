//
//  ViewController.swift
//  MovieDBProject
//
//  Created by Andrew Scherbina on 23/11/2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit
import AlamofireImage


class TopRatedVC: SearchVC {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieManager.fetchTopMovies()
    }
}

 
