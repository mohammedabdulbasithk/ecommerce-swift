//
//  ViewController.swift
//  BasithUSPolo
//
//  Created by Basith on 04/01/21.
//

import UIKit

class ViewController: BaseViewController {
    
    var list : [Products] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func wishListClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "ListTblCell", bundle: nil), forCellReuseIdentifier: "ListTblCell")
        tableView.register(UINib.init(nibName: "DashboardShimmerCell", bundle: nil), forCellReuseIdentifier: "DashboardShimmerCell")
        
        getProducts()
    }
    
    
    func getProducts(){
        AppModel.sharedInstance.getProducts(){ [self](result) -> () in
            list = result
            print(result.count)
            self.tableView.reloadData()
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if list.count > 0 {
            return UITableView.automaticDimension
        }else{
            return 115
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if list.count > 0 {
            return list.count
        }else{
            return 15
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if list.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListTblCell", for: indexPath) as! ListTblCell
            cell.prepareForReuse()
            cell.heartButton.tag = indexPath.row
            cell.delegate = self
            cell.setData(prod: list[indexPath.row])
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardShimmerCell", for: indexPath) as! DashboardShimmerCell
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if list.count>0{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            vc.product_id = list[indexPath.row].product_id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ViewController : USPDelegate{
    func productClicked(id: String) {
        
    }
    
    func wishListClickedat(index: Int) {
        self.showToast(controller: self, message: "wishlist clickec at \(index)", seconds: 2.0)
    }
}


protocol USPDelegate {
    func wishListClickedat(index : Int)
    func productClicked(id : String)
}
