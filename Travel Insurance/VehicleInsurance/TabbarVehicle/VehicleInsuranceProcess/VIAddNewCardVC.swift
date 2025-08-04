//
//  VIAddNewCardVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 05/06/25.
//

import UIKit

class VIAddNewCardVC: UIViewController {

    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtExpireDate: UITextField!
    @IBOutlet weak var txtCVV: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.dismiss(animated: false)
    }
    @IBAction func btnCloseAction(_ sender: Any) {
        self.dismiss(animated: false)
    }
    @IBAction func btnSaveThisMethodAction(_ sender: Any) {
    }
    @IBAction func btnAddNewCard(_ sender: Any) {
    }
    
     

}
