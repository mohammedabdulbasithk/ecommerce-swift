//
//  DetailNameCell.swift
//  BasithUSPolo
//
//  Created by Basith on 05/01/21.
//

import UIKit

class DetailNameCell: UITableViewCell {

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        detailLabel.text = ""
        nameLabel.text = ""
        ratingLabel.text = ""
    }
    
    func setData(name : String, detail : String, rating : String){
        detailLabel.text = detail
        nameLabel.text = name
        ratingLabel.text = rating
    }
    
}
