//
//  DetailButtonCell.swift
//  BasithUSPolo
//
//  Created by Basith on 05/01/21.
//

import UIKit

class DetailButtonCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    var count : Int = 0
    
    @IBOutlet weak var countLabel: UILabel!
    
    
    @IBAction func plusClicked(_ sender: Any) {
        count = count + 1
        countLabel.text = "\(count)"
    }
    
    @IBAction func minusClicked(_ sender: Any) {
        if count != 1 {
            count = count - 1
            countLabel.text = "\(count)"
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
