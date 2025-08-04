//
//  PolicyCancelledVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 21/02/24.
//

import UIKit

class PolicyCancelledVC: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDEs: UILabel!
    
    var strOpen = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if strOpen == "2" {
            
            lblTitle.text = "Policy cancellation request sent"
            lblDEs.text = "your insurance policy cancellation request has been raised, it is currently under review by our admin team."
        } else {
            
            lblTitle.text = "Policy Cancel"
            lblDEs.text = ""
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func clickedHome(_ sender: Any) {
        if appDelegate?.dicCurrentUserData.roleId == 1
        {
            appDelegate?.setUpHomeCustomer()
        }
        else
        {
            appDelegate?.setUpHomeAgent()
        }
    }

}
