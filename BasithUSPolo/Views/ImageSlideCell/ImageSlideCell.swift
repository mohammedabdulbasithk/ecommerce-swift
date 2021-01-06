//
//  ImageSlideCell.swift
//  BasithUSPolo
//
//  Created by Basith on 04/01/21.
//

import UIKit
import ImageSlideshow
import Alamofire
import AlamofireImage

class ImageSlideCell: UITableViewCell {

    @IBOutlet var slider: ImageSlideshow!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
