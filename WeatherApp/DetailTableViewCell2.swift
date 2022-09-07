//
//  DetailTableViewCell2.swift
//  WeatherApp
//
//  Created by Admin on 15/02/22.
//

import UIKit

class DetailTableViewCell2: UITableViewCell {
//Image
    @IBOutlet weak var imgV1: UIImageView!
    @IBOutlet weak var imgV2: UIImageView!
    @IBOutlet weak var imgV3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    //label
    @IBOutlet weak var l1: UILabel!
    @IBOutlet weak var l2: UILabel!
    
    @IBOutlet weak var l4: UILabel!
    @IBOutlet weak var l3: UILabel!
    
    
    @IBOutlet weak var l2v1: UILabel!
    @IBOutlet weak var l2v2: UILabel!
    @IBOutlet weak var l2v3: UILabel!
    @IBOutlet weak var l2v4: UILabel!
    
    @IBOutlet weak var l3v1: UILabel!
    @IBOutlet weak var l3v2: UILabel!
    @IBOutlet weak var l3v3: UILabel!
    @IBOutlet weak var l3v4: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
