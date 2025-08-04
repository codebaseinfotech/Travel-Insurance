//
//  PaymentDoneVC.swift
//  Hamraa Insurance
//
//  Created by Purv on 12/04/24.
//

import UIKit
import SwiftyJSON

class PaymentDoneVC: UIViewController {
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var ViewPayment: UIView!
    @IBOutlet weak var btnPay: UIButton!
    
    var transactionDetailsId = 0
    var iQDAmount = 0
    
    var policy_start_date = ""
    var policy_end_date = ""
    var time_period = ""
    var currencySymbol = ""
    var user_insurance_id = 0
    
    var isModify = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnPay.layer.cornerRadius = 10
        
        print(policy_start_date)
        
        let amount = Double(iQDAmount)
        
        let formattedString = String(format: "%.2f", amount)
        lblPrice.text = "\(formattedString) IQD"
        ViewPayment.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clickedPayNow(_ sender: Any) {
        ViewPayment.isHidden = false
       
    }
    @IBAction func clickedCancel(_ sender: Any) {
        ViewPayment.isHidden = true
    }
    @IBAction func clickedVisa(_ sender: Any) {
        
        if isModify == true {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaymentDetailsVC") as! PaymentDetailsVC
            vc.modalPresentationStyle = .overFullScreen
            vc.transactionDetailsId = transactionDetailsId
            vc.iQDAmount = iQDAmount
            vc.isModify = isModify
            vc.policy_start_date = policy_start_date
            vc.policy_end_date = policy_end_date
            vc.time_period = time_period
            vc.currencySymbol = currencySymbol
            vc.user_insurance_id = user_insurance_id
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaymentDetailsVC") as! PaymentDetailsVC
            vc.modalPresentationStyle = .overFullScreen
            vc.transactionDetailsId = transactionDetailsId
            vc.iQDAmount = iQDAmount
            vc.isModify = isModify
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
