//
//  PremiumCalculationVC.swift
//  Hamraa Insurance
//
//  Created by Poojagabani on 03/06/25.
//

import UIKit

class PremiumCalculationVC: UIViewController {
    
    @IBOutlet weak var lblVehicleMakr: UILabel!
    @IBOutlet weak var lblModelYear: UILabel!
    @IBOutlet weak var lblVehicleValur: UILabel!
    @IBOutlet weak var lblVehicleAge: UILabel!
    @IBOutlet weak var lblBasrPremium: UILabel!
    @IBOutlet weak var lblAgencyRepair: UILabel!
    @IBOutlet weak var lblTotalPremium: UILabel!
    
    let appManger = AppManger.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblVehicleMakr.text = appManger.vehicle_make
        self.lblModelYear.text = appManger.model_year
        self.lblVehicleValur.text = "\(appManger.vehicle_value)" + " IQD"
        
        print(appManger.vehicle_make)
        callGetPremiumCalculation()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnProceedNext(_ sender: Any) {
        let vc = VIProcess4VC.instantiate("Vehicle") as! VIProcess4VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - calling API
    func callGetPremiumCalculation() {
        APIClient.sharedInstance.showIndicator()
        
        let param = [
            "model_year": "\(appManger.model_year)",
            "vehicle_type": "\(appManger.vehicle_plan_id)",
            "vehicle_value": "\(appManger.vehicle_value)"
        ]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(GET_PREMIUM_CALCULATION, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            let status = response?.value(forKey: "status") as? Int
            let message = response?.value(forKey: "message") as? String ?? ""
            
            if error == nil {
                APIClient.sharedInstance.hideIndicator()
                
                if statusCode == 200 {
                    if status == 1 {
                        
                        if let dicData = response?.value(forKey: "data") as? NSDictionary {
                            let modelData = THGerPremiumCalculationData(fromDictionary: dicData)
                            self.appManger.dicGetPremium = modelData
                            
                            self.lblVehicleAge.text = "\(modelData.vehicleAge ?? 0)" + " year"
                            self.lblBasrPremium.text = "\(modelData.baseRate ?? 0.0) %"
                            self.lblAgencyRepair.text = "\(modelData.agencyRepair ?? 0.0) %"
                            
                            let vehicleValue = Float(modelData.vehicleValue)
                            let totalRate: Float = modelData.totalRate

                            let totalAmount = vehicleValue * (totalRate / 100)
                            self.lblTotalPremium.text = "\(totalAmount) IQD"
                            
                            self.appManger.vehicle_age = modelData.vehicleAge ?? 0
                            self.appManger.base_premium = modelData.baseRate ?? 0.0
                            self.appManger.agency_repair = modelData.agencyRepair ?? 0.0
                            self.appManger.total_premium = totalAmount
                        }
                    } else {
                        self.setUpMakeToast(msg: message)
                    }
                } else {
                    self.setUpMakeToast(msg: message)
                }
            } else {
                APIClient.sharedInstance.hideIndicator()
                self.setUpMakeToast(msg: message)
            }
        }
    }
 
}
