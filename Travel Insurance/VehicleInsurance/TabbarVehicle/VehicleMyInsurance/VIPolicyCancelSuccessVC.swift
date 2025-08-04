//
//  VIPolicyCancelSuccessVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 05/06/25.
//

import UIKit

class VIPolicyCancelSuccessVC: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDes: UILabel!
    @IBOutlet weak var viewNoKeep: UIView!
    @IBOutlet weak var btnYesCancel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text = "Cancel Policy?"
        lblDes.text = "Cancel: If you choose to cancel, the policy will be terminated, and you will receive an email notification of the cancellation.\n\nRefund: The refund will be calculated based on the unused portion of the policy on a pro-rata basis, and the amount will be credited to your original payment method."

        // Do any additional setup after loading the view.
    }

    @IBAction func btnYesCancelAction(_ sender: Any) {
        lblTitle.text = "Policy Cancelled Successfully"
        lblDes.text = "Your policy has been cancelled. A confirmation email has been sent to your registered email address. Refund (if applicable) will be processed shortly."
        viewNoKeep.isHidden = true
        btnYesCancel.setTitle("Back to home", for: .normal)
        
        if btnYesCancel.titleLabel?.text == "Back to home" {
            appDelegate?.setUpHomeVehicle()
        }
    }
    @IBAction func btnNoKeepitAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
