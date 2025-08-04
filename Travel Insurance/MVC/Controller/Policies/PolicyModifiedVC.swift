//
//  PolicyModifiedVC.swift
//  Hamraa Insurance
//
//  Created by Purv on 19/03/24.
//

import UIKit

class PolicyModifiedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func clickedHome(_ sender: Any) {
        if appDelegate?.dicCurrentUserData.roleId == 1
        {
            appDelegate?.isBackForm = false
            
            appDelegate?.setUpHomeCustomer()
        }
        else
        {
            appDelegate?.isBackForm = false
            
            appDelegate?.setUpHomeAgent()
        }
    }

}
