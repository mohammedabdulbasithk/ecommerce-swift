//
//  DetailVC.swift
//  BasithUSPolo
//
//  Created by Basith on 04/01/21.
//

import UIKit
import Alamofire
import ImageSlideshow

class DetailVC: BaseViewController {
    
    var alamofireSource : [AlamofireSource] = []
    
    var options : [ProductOptions] = []
    var related : [RelatedProducts] = []
    
    var name : String = ""
    var price : String = ""
    var details : String = ""
    var rating : String = ""
    
    var product_id : String = ""
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "ImageSlideCell", bundle: nil), forCellReuseIdentifier: "ImageSlideCell")
        tableView.register(UINib.init(nibName: "DetailNameCell", bundle: nil), forCellReuseIdentifier: "DetailNameCell")
        tableView.register(UINib.init(nibName: "DetailOptionTblCell", bundle: nil), forCellReuseIdentifier: "DetailOptionTblCell")
        tableView.register(UINib.init(nibName: "DetailButtonCell", bundle: nil), forCellReuseIdentifier: "DetailButtonCell")
        
        tableView.register(UINib.init(nibName: "RelatedTblCell", bundle: nil), forCellReuseIdentifier: "RelatedTblCell")
        
        
        
        if self.product_id != ""{
            getDetails()
        }else{
            self.showAlert(title: "", message: "Error")
        }
        
    }

}

extension DetailVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if price != ""{
            return 5
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        }else if indexPath.section == 1 { 
            return UITableView.automaticDimension
        }else if indexPath.section == 2 {
            return UITableView.automaticDimension
        }else if indexPath.section == 3 {
            return UITableView.automaticDimension
        }else if indexPath.section == 4 {
            return 320
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageSlideCell", for: indexPath) as! ImageSlideCell
            cell.slider.setImageInputs(self.alamofireSource)
            cell.slider.backgroundColor = UIColor.white
            cell.slider.pageIndicator?.view.tintColor = .black
            cell.slider.pageIndicator?.view.borderColorV = .black
            cell.slider.slideshowInterval = 5.0
            cell.slider.contentScaleMode = UIViewContentMode.scaleAspectFit
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailNameCell", for: indexPath) as! DetailNameCell
            cell.prepareForReuse()
            cell.setData(name: name, detail: details, rating: rating)
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailOptionTblCell", for: indexPath) as! DetailOptionTblCell
            cell.prepareForReuse()
            cell.setData(item: options[indexPath.row], name: options[indexPath.row].name)
            return cell
        }else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailButtonCell", for: indexPath) as! DetailButtonCell
            cell.priceLabel.text = "$ " + price
            return cell
            
        }else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RelatedTblCell", for: indexPath) as! RelatedTblCell
            cell.related = self.related
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return options.count
        case 3:
            return 1
        case 4:
            if related.count > 0 {
                return 1
            }else{
                return 0
            }
        default:
            return 0
        }
    }
}


extension DetailVC {
    func getDetails(){
        let parameters = [
            "user_id": "69",
            "device_type":"iOS",
            "customer_id":"69",
            "token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJjdXN0b21lcl9pZCI6IjY5IiwiaWF0IjoxNjA2ODgzNjE3fQ.QK13epjPKnc-twJCwObDVNenfPsmw2HR1f9lJUG3CEo",
            "language_id":"1",
            "country_id":"225",
            "area_id":"1716",
            "product_id":self.product_id
        ]
        AF.request("https://beta.gastro-admin.xyz/mobileapi/retail/get_product_details", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:AFDataResponse<Any>) -> Void in
            switch(response.result) {
            case .success(_):
                if let data2 = response.value {
                    print("data2",data2)
                    let productResult = data2 as! NSDictionary
                    if let product_details = productResult["product_details"] as? NSDictionary{
                        self.name = product_details["name"] as? String ?? ""
                        self.details = product_details["description"] as? String ?? ""
                        self.rating = product_details["rating"] as? String ?? "5.0"
                        self.price = product_details["price"] as? String ?? "0.0"
                        
                        if let images = product_details["images"] as? NSArray {
                            if(images.count > 0){
                                for index in 0..<images.count{
                                    let img = images[index] as? String ?? ""
                                    if let imageFileSource:AlamofireSource = AlamofireSource(urlString:("https://d2tcyife2dgcgh.cloudfront.net/image/" + img).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!){
                                        self.alamofireSource += [imageFileSource]
                                    }
                                }
                                
                            }
                        }
                        
                        
                        if let product_options = productResult["product_options"] as? NSArray {
                            if(product_options.count > 0){
                                for index in 0..<product_options.count{
                                    if let item = product_options[index] as? NSDictionary {
                                        let name = item["name"] as? String ?? ""
                                        var product_optionArray : [ProductOptionValue] = []
                                        if let temp =  item["product_option_value"] as? NSArray {
                                            for a in temp {
                                                if let dta = a as? NSDictionary {
                                                    let product_option_value_id = dta["product_option_value_id"] as? String ?? ""
                                                    let name = dta["name"] as? String ?? ""
                                                    let color_code = dta["color_code"] as? String ?? ""
                                                    product_optionArray.append(ProductOptionValue(product_option_value_id: product_option_value_id, name: name, color_code: color_code))
                                                }
                                            }
                                        }
                                        
                                        self.options.append(ProductOptions(name: name, product_option_value: product_optionArray))
                                        
                                    }
                                }
                                
                            }
                        }
                        
                        if let temp =  productResult["related_products"] as? NSArray {
                            for a in temp {
                                if let dta = a as? NSDictionary {
                                    let product_id = dta["product_id"] as? String ?? ""
                                    let name = dta["name"] as? String ?? ""
                                    let price = dta["price"] as? String ?? ""
                                    let image = dta["image"] as? String ?? ""
                                    self.related.append(RelatedProducts(product_id: product_id, name: name, price: price, image: image))
                                }
                            }
                        }
                        
                        self.tableView.reloadData()
                        
                    }
                    
                }
                break
            case .failure(_):
                break
            }
        }
    }
}

extension DetailVC : USPDelegate{
    func wishListClickedat(index: Int) {
        
    }
    
    func productClicked(id: String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        vc.product_id = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
