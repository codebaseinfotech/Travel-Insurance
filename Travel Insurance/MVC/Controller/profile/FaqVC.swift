//
//  FaqVC.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 02/02/24.
//

import UIKit

class FaqVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
