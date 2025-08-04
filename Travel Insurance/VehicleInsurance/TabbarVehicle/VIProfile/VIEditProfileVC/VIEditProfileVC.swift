//
//  VIEditProfileVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 06/06/25.
//

import UIKit

class VIEditProfileVC: UIViewController {

    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var imgCountryFlag: UIImageView!
    @IBOutlet weak var lblCouontryCode: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCountruAction(_ sender: Any) {
    }
    @IBAction func btnSaveChangeAction(_ sender: Any) {
    }
    
}
