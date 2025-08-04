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
    
    var planId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callMyInsuranceAPI()
        
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
    
     
    // MARK: - calling API
    func callMyInsuranceAPI() {
        APIClient.sharedInstance.showIndicator()
        
        let parm = ["id":"\(planId)"]
        
        print(parm)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(MY_VEHICLE_INSURANCE_DETAILS, parameters: parm) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String

                if statusCode == 200
                {
                    if status == 1 {
                        if let dicResponse = response?.value(forKey: "data") as? NSDictionary {
                            let dicData = TIVehicleInsuranceDetialsData(fromDictionary: dicResponse)
                           
                            if dicData.vehiclePlanId == 1 {
                                self.viewBikeDetails.isHidden = false
                                self.viewCarDetails.isHidden = true
                            } else {
                                self.viewCarDetails.isHidden = false
                                self.viewBikeDetails.isHidden = true
                            }
                            self.lblCarName.text = "\(dicData.vehicleModel ?? "") (\(dicData.engineSize ?? "") cc)"
                            self.lblBikeName.text = "\(dicData.vehicleModel ?? "") (\(dicData.engineSize ?? "") cc)"
                            self.lblCarNumber.text = "\(dicData.vehicleNo ?? "") | \(dicData.modelYear ?? "") registered"
                            self.lblBikeNumber.text = "\(dicData.vehicleNo ?? "") | \(dicData.modelYear ?? "") registered"
                            self.lblFullName.text = dicData.name ?? ""
                            self.lblEmail.text = "Sent to your email : " + dicData.email ?? ""
                            self.lblCardHolderName.text = dicData.name ?? ""
                            self.lblPolicyNumber.text = dicData.policyId ?? ""
                            self.lblExpireDate.text = dicData.policyEndDate ?? ""
                            self.lblcardPolicyNumber.text = "POLICY NO. " + dicData.policyId
                            self.lblIssueDate.text = dicData.policyStartDate ?? ""
                            self.lblValidTill.text = dicData.policyEndDate ?? ""
                        }
                    }
                    else
                    {
                        APIClient.sharedInstance.hideIndicator()
                        
                        self.setUpMakeToast(msg: message ?? "")
                    }
                }
                else
                {
                    APIClient.sharedInstance.hideIndicator()
                    
                    self.setUpMakeToast(msg: message ?? "")
                }
            }
            else
            {
                APIClient.sharedInstance.hideIndicator()
            }
            
        }
    }

}
