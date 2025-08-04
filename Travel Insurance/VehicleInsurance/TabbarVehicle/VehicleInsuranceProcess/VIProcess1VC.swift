//
//  VIProcess1VC.swift
//  Hamraa Insurance
//
//  Created by Poojagabani on 03/06/25.
//

import UIKit

class VIProcess1VC: UIViewController {

    @IBOutlet weak var imgCarInsurance: UIImageView!
    @IBOutlet weak var imgTwoWheelerInsurance: UIImageView!
    
    @IBOutlet weak var viewCarInsuranceMain: UIView!
    @IBOutlet weak var viewTwoWheelerMain: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCarInsuranceAction(_ sender: Any) {
        AppManger.shared.isCarInsurance = true
        AppManger.shared.vehicle_type = "4"
        AppManger.shared.vehicle_plan_id = 2
        
        imgCarInsurance.image = UIImage(named: "ic_selectVI")
        imgTwoWheelerInsurance.image = UIImage(named: "ic_unSelectVI")
        
        viewCarInsuranceMain.borderColor = #colorLiteral(red: 0.9333333333, green: 0.1137254902, blue: 0.137254902, alpha: 1)
        viewTwoWheelerMain.borderColor = #colorLiteral(red: 0.8980392157, green: 0.9058823529, blue: 0.9215686275, alpha: 1)
    }
    @IBAction func btnTwoWheelerAction(_ sender: Any) {
        AppManger.shared.isCarInsurance = false
        AppManger.shared.vehicle_type = "2"
        AppManger.shared.vehicle_plan_id = 1
        
        imgTwoWheelerInsurance.image = UIImage(named: "ic_selectVI")
        imgCarInsurance.image = UIImage(named: "ic_unSelectVI")
        
        viewTwoWheelerMain.borderColor = #colorLiteral(red: 0.9333333333, green: 0.1137254902, blue: 0.137254902, alpha: 1)
        viewCarInsuranceMain.borderColor = #colorLiteral(red: 0.8980392157, green: 0.9058823529, blue: 0.9215686275, alpha: 1)
    }
    @IBAction func btnContinueAction(_ sender: Any) {
        let vc = VIProcess2VC.instantiate("Vehicle") as! VIProcess2VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
