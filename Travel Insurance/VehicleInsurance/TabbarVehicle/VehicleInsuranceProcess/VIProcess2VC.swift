//
//  VIProcess2VC.swift
//  Hamraa Insurance
//
//  Created by Poojagabani on 03/06/25.
//

import UIKit

class VIProcess2VC: UIViewController {

    @IBOutlet weak var txtEnterVehicleNumber: UITextField!
    
    // MARK: - view Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Action Method
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnContinueAction(_ sender: Any) {
        guard let vehicleNumber = txtEnterVehicleNumber.text, !vehicleNumber.isEmpty else {
            self.setUpMakeToast(msg: "Please enter vehicle number")
            return
        }
        
        guard AppUtilites.sharedInstance.isValidVehicleNumber(vehicleNumber) else {
            self.setUpMakeToast(msg: "Please enter a valid vehicle number")
            return
        }
        
        AppManger.shared.vehicle_no = txtEnterVehicleNumber.text?.uppercased() ?? ""
        let vc = VIProcess3VC.instantiate("Vehicle") as! VIProcess3VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
