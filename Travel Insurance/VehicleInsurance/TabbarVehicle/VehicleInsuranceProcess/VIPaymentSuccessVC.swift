//
//  VIPaymentSuccessVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 05/06/25.
//

import UIKit
protocol didTapOnSuccess: AnyObject {
    func didTapOnTrackClaim()
    func didTapOnClose()
}

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
    @IBOutlet weak var lblRefernceNumber: UILabel! {
        didSet {
            lblRefernceNumber.text = claim_id
        }
    }
    
    @IBOutlet weak var lblViewPolicy: UILabel!
    
    var isCliamRequest = false
    var callAPI = false
    
    var claim_id = ""
    var dicResponse = TIVehicleInsuranceData()
    
    var delegateAction: didTapOnSuccess?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if callAPI == true {
            viewPaymentSuccess.isHidden = true
            viewPaymentProcess.isHidden = false
            
        } else {
            viewPaymentSuccess.isHidden = false
            viewPaymentProcess.isHidden = true
            
            lblPolicyNumber.text = dicResponse.policyId ?? ""
            lblInsuredName.text = dicResponse.name ?? ""
            lblTotalPremium.text = "IQD \(dicResponse.totalPremium ?? "")"
            lblPolicyDate.text = dicResponse.policyStartDate ?? ""
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
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                self.viewPaymentProcess.isHidden = true
//                self.viewPaymentSuccess.isHidden = false
//            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnViewPolicyAction(_ sender: Any) {
        btnCloseAction(self)
    }
    @IBAction func btnCloseAction(_ sender: Any) {
        if isCliamRequest == true {
            delegateAction?.didTapOnClose()
            self.dismiss(animated: false)
        } else {
            delegateAction?.didTapOnClose()
            self.dismiss(animated: false)
        }
    }
    
     

}
