//
//  VIMyEndrosementDetailsVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 06/06/25.
//

import UIKit

class VIMyEndrosementDetailsVC: UIViewController {

    @IBOutlet weak var lblPerviousOwner: UILabel!
    @IBOutlet weak var lblNewOwner: UILabel!
    @IBOutlet weak var lblNewOwnerContact: UILabel!
    @IBOutlet weak var lblNewAddress: UILabel!
    @IBOutlet weak var imgFirstDocu: UIImageView!
    @IBOutlet weak var imgSecondDoc: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
 

}
