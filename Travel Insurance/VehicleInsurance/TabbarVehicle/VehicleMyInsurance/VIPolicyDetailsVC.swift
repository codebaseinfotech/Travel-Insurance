//
//  VIPolicyDetailsVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 05/06/25.
//

import UIKit

class VIPolicyDetailsVC: UIViewController {

    @IBOutlet weak var viewCarDetails: UIView!
    @IBOutlet weak var viewBikeDetails: UIView!
    
    @IBOutlet weak var lblCarName: UILabel!
    @IBOutlet weak var lblCarNumber: UILabel!
    
    @IBOutlet weak var lblBikeName: UILabel!
    @IBOutlet weak var lblBikeNumber: UILabel!
    
    @IBOutlet weak var lblUserNam: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var lblCardHolderName: UILabel!
    @IBOutlet weak var lblcardPolicyNumber: UILabel!
    @IBOutlet weak var lblValidityInfo: UILabel!
    @IBOutlet weak var lblExpireDate: UILabel!
    
    @IBOutlet weak var lblPolicyNumber: UILabel!
    @IBOutlet weak var lblIssueDate: UILabel!
    @IBOutlet weak var lblValidTill: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnDownloadPdfAction(_ sender: Any) {
    }
    @IBAction func btnDownloadCardAction(_ sender: Any) {
    }
    @IBAction func btnClaimInsurance(_ sender: Any) {
        let vc = VISubmitClaimRequestVC.instantiate("Vehicle") as! VISubmitClaimRequestVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
     

}
