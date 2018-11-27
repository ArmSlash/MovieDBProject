//
//  MovieTableViewCell.swift
//  MovieDBProject
//
//  Created by Andrew Scherbina on 24/11/2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

   
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var title: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = #colorLiteral(red: 0.3045793521, green: 0.3016222711, blue: 0.3016222711, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
