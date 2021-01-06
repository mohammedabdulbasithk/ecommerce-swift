//
//  SearchViewController.swift
//  BasithUSPolo
//
//  Created by Basith on 04/01/21.
//

import UIKit

class SearchViewController: BaseViewController {

    @IBAction func closeClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        searchBar.delegate = self
        searchBar.borderColorV = UIColor.clear
    }

}
