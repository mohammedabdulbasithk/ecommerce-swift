//
//  ListTblCell.swift
//  BasithUSPolo
//
//  Created by Basith on 04/01/21.
//

import UIKit
import Alamofire
import AlamofireImage

class ListTblCell: UITableViewCell {
    
    @IBOutlet weak var heartButton: UIButton!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var delegate:USPDelegate?
    
    
    @IBAction func wishListClicked(_ sender: Any) {
        delegate?.wishListClickedat(index : heartButton.tag)
    }
    
    func setData(prod : Products){
        priceLabel.text = "$ " + prod.price
        ratingLabel.text = prod.rating
        categoryLabel.text = prod.category
        nameLabel.text = prod.name
        if let link = prod.image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let imgUrl = "https://d2tcyife2dgcgh.cloudfront.net/image/" + link
            imgView.af.setImage(withURL: URL(string: imgUrl)!)
        }
    }
    
    override func prepareForReuse() {
        priceLabel.text = ""
        ratingLabel.text = ""
        categoryLabel.text = ""
        nameLabel.text = ""
        imgView.image = nil
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
