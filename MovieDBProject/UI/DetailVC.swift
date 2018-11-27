//
//  DetailViewController.swift
//  MovieDBProject
//
//  Created by Andrew Scherbina on 25/11/2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit
import AlamofireImage


class DetailVC: UIViewController {
    

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titlelable: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    var movie = Movie()
    let baseURLforImages = "http://image.tmdb.org/t/p/w500/"
    let dbManager = DBManager()
    var buttonPresed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(buttonPresed)
        titlelable.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        overviewLabel.text = movie.overview
        if dbManager.isAlreadyInDB(movie: movie){
            button.setTitle("Remove from favorites", for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        }
        fetchMoviePosterImage()
    }
    
    func fetchMoviePosterImage(){
        let placeholderImage = UIImage(named:"noImage.png")!
        if let posterPath = movie.posterPath {
            let urlString = baseURLforImages + posterPath
            let url = URL(string: urlString)
            posterImageView.af_setImage(withURL: url!, placeholderImage: placeholderImage)
        }else{
            print("no path to image")
            posterImageView.image = placeholderImage
        }
    }
    
    private func posterImageToData(image:UIImage){
        if let data:Data = image.pngData() {
            putImageData(data: data)
        } else if let data:Data = image.jpegData(compressionQuality: 1.0){
            putImageData(data: data)
        }
    }
    
    private func putImageData(data: Data){
        movie.poster = data
    }
    
    
    @IBAction func addToFavorite(_ sender: Any) {
        if !buttonPresed{
        if dbManager.isAlreadyInDB(movie: movie){
            dbManager.removeFromDB(movie: movie)
             button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }else{
            let image  = posterImageView.image!
            posterImageToData(image: image)
            dbManager.save(movie: movie)
            button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            }
        }
         buttonPresed = true
    }
}
