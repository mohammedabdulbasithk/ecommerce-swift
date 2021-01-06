//
//  SizeCell.swift
//  BasithUSPolo
//
//  Created by Basith on 05/01/21.
//

import UIKit

class SizeCell: UICollectionViewCell {

    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        bgView.borderWidthV = 0
        bgView.borderColorV = .clear
    }

}
