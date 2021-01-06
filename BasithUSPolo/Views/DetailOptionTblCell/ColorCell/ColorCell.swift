//
//  ColorCell.swift
//  BasithUSPolo
//
//  Created by Basith on 05/01/21.
//

import UIKit

class ColorCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        bgView.borderWidthV = 1
        bgView.borderColorV = .clear
        colorView.backgroundColor = .white
    }

}
