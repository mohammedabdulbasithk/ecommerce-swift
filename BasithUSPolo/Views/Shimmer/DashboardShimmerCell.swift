//
//  DashboardShimmerCell.swift
//  OurShopee
//
//  Created by Basith on 09/12/20.
//  Copyright © 2020 iLeaf. All rights reserved.
//

import UIKit

class DashboardShimmerCell: UITableViewCell {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view1.startShimmeringViewAnimation()
        view2.startShimmeringViewAnimation()
        view3.startShimmeringViewAnimation()
        view4.startShimmeringViewAnimation()
        view5.startShimmeringViewAnimation() 
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


 
