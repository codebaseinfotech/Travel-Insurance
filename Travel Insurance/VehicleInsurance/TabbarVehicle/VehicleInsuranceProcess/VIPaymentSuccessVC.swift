//
//  VIPaymentSuccessVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 05/06/25.
//

import UIKit

class VIPaymentSuccessVC: UIViewController {

    @IBOutlet weak var viewPaymentSuccess: UIView!
    @IBOutlet weak var viewPaymentProcess: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var viewPolicyNumber: UIView!
    @IBOutlet weak var viewInsuredName: UIView!
    @IBOutlet weak var viewTotalPremium: UIView!
    @IBOutlet weak var viewPolicyStartDate: UIView!
    @IBOutlet weak var viewRefeenceNumber: UIView!
    
    @IBOutlet weak var lblPolicyNumber: UILabel!
    @IBOutlet weak var lblInsuredName: UILabel!
    @IBOutlet weak var lblTotalPremium: UILabel!
    @IBOutlet weak var lblPolicyDate: UILabel!
    @IBOutlet weak var lblRefernceNumber: UILabel!
    
    @IBOutlet weak var lblViewPolicy: UILabel!
    
    var isCliamRequest = false
    var callAPI = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if callAPI == true {
            viewPaymentSuccess.isHidden = true
            viewPaymentProcess.isHidden = false
            
        } else {
            viewPaymentSuccess.isHidden = false
            viewPaymentProcess.isHidden = true
        }
        
        if isCliamRequest == true {
            
            lblTitle.text = "Claim Submitted Successfully!"
            lblMessage.text = "You will receive an email confirmation\nshortly."
            
            lblViewPolicy.text = "Track Claim"
            
            viewPolicyNumber.isHidden = true
            viewInsuredName.isHidden = true
            viewTotalPremium.isHidden = true
            viewPolicyStartDate.isHidden = true
            viewRefeenceNumber.isHidden = false
        } else {
            
            lblViewPolicy.text = "View Policy"
            
            viewPaymentProcess.isHidden = false
            viewPaymentSuccess.isHidden = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.viewPaymentProcess.isHidden = true
                self.viewPaymentSuccess.isHidden = false
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnViewPolicyAction(_ sender: Any) {
        btnCloseAction(self)
    }
    @IBAction func btnCloseAction(_ sender: Any) {
        if isCliamRequest == true {
            
        } else {
            appDelegate?.setUpHomeVehicle()
        }
    }
    
     

}
