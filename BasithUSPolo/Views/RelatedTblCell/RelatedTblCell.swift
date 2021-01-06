//
//  RelatedTblCell.swift
//  BasithUSPolo
//
//  Created by Basith on 05/01/21.
//

import UIKit

class RelatedTblCell: UITableViewCell {
    
    var related : [RelatedProducts] = []
    
    @IBOutlet weak var collectionVIew: UICollectionView!
    
    var delegate : USPDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionVIew.register(UINib.init(nibName: "RelatedCollectionCell", bundle: nil), forCellWithReuseIdentifier: "RelatedCollectionCell")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension RelatedTblCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return related.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RelatedCollectionCell", for: indexPath) as! RelatedCollectionCell
        cell.price.text = "$ " + related[indexPath.row].price
        cell.name.text = related[indexPath.row].name
        cell.imgView.af.setImage(withURL: URL(string: "https://d2tcyife2dgcgh.cloudfront.net/image/"+related[indexPath.row].image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 270)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.productClicked(id : related[indexPath.row].product_id)
    }
    
    
}

