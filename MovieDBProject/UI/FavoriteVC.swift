//
//  FavoriteVC.swift
//  MovieDBProject
//
//  Created by Andrew Scherbina on 26/11/2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit

class FavoriteVC: SearchVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let dbManager = DBManager()
       // movies.removeAll()
        movies = dbManager.storedMovies()
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? MovieTableViewCell else {
            return UITableViewCell()
        }
        if indexPath.row <= movies.count{
            cell.title.text = movies[indexPath.row].title
            cell.date.text = movies[indexPath.row].releaseDate
            
            if let image = UIImage(data: movies[indexPath.row].poster!){
                cell.poster.image = image
            }else{
                cell.poster.image = UIImage(named: "noImage.png")
            }
        }
        return cell
    }
    
}
