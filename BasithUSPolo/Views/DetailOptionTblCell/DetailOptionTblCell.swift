//
//  DetailOptionTblCell.swift
//  BasithUSPolo
//
//  Created by Basith on 05/01/21.
//

import UIKit

class DetailOptionTblCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var item : ProductOptions?
    
    var selectIndex : Int = 0
    
    override func prepareForReuse() {
        nameLabel.text = ""
        item = nil
        collectionView.reloadData()
    }
    
    func setData(item : ProductOptions, name : String){
        nameLabel.text = name
        self.item = item 
        self.collectionView.reloadData()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib.init(nibName: "SizeCell", bundle: nil), forCellWithReuseIdentifier: "SizeCell")
        collectionView.register(UINib.init(nibName: "ColorCell", bundle: nil), forCellWithReuseIdentifier: "ColorCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


extension DetailOptionTblCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (item?.product_option_value.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if item?.product_option_value[indexPath.row].color_code == ""{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SizeCell", for: indexPath) as! SizeCell
            if selectIndex == indexPath.row {
                cell.bgView.borderColorV = .systemGreen
                cell.bgView.borderWidthV = 1
            }else{
                cell.bgView.borderColorV = .clear
                cell.bgView.borderWidthV = 0
            }
            cell.sizeLabel.text = item?.product_option_value[indexPath.row].name.uppercased()
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as! ColorCell
            if selectIndex == indexPath.row {
                cell.bgView.borderColorV = .systemGreen
                cell.bgView.borderWidthV = 1
            }else{
                cell.bgView.borderColorV = .clear
                cell.bgView.borderWidthV = 0
            }
            cell.colorView.backgroundColor = .hexStringToUIColor(hex: (item?.product_option_value[indexPath.row].color_code)!)
            return cell
        } 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectIndex = indexPath.row
        self.collectionView.reloadData()
    }
    
    
}


extension UIColor{
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
