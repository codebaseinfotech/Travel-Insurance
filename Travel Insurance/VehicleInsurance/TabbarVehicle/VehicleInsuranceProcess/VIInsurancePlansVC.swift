//
//  VIInsurancePlansVC.swift
//  Hamraa Insurance
//
//  Created by Poojagabani on 04/06/25.
//

import UIKit

class VIInsurancePlansVC: UIViewController {

    @IBOutlet weak var viewCarInfoMain: UIView!
    @IBOutlet weak var viewBikeInfoMain: UIView!
    
    @IBOutlet weak var lblCarDetails: UILabel! {
        didSet {
            let companyName = AppManger.shared.vehicle_make
            let vehicleName = AppManger.shared.vehicle_model
            let enginSize = "\(AppManger.shared.engine_size)" + " " + "cc"
            
            lblCarDetails.text = companyName + " " + vehicleName + " " + "(\(enginSize))"
        }
    }
    @IBOutlet weak var lblCarNumber: UILabel! {
        didSet {
            let number = AppManger.shared.vehicle_no + " | " + AppManger.shared.model_year + " " + "registered"
            lblCarNumber.text = number
        }
    }
    
    @IBOutlet weak var lblBikeDetails: UILabel! {
        didSet {
            let companyName = AppManger.shared.vehicle_make
            let vehicleName = AppManger.shared.vehicle_model
            let enginSize = "\(AppManger.shared.engine_size)" + " " + "cc"
            
            lblBikeDetails.text = companyName + " " + vehicleName + " " + "(\(enginSize))"
        }
    }
    @IBOutlet weak var lblBikeNumber: UILabel! {
        didSet {
            let number = AppManger.shared.vehicle_no + " | " + AppManger.shared.model_year + " " + "registered"
            lblBikeNumber.text = number
        }
    }
    
    @IBOutlet weak var tblViewAvalilablePlans: UITableView! {
        didSet {
            tblViewAvalilablePlans.delegate = self
            tblViewAvalilablePlans.dataSource = self
        }
    }
    
    @IBOutlet weak var viewLodder: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewCarInfoMain.isHidden = AppManger.shared.isCarInsurance ? false : true
        viewBikeInfoMain.isHidden = AppManger.shared.isCarInsurance ? true : false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.viewLodder.isHidden = true
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnEditCarDetaails(_ sender: Any) {
        let controllers = self.navigationController?.viewControllers
        for vc in controllers! {
            if vc is VIProcess3VC {
                _ = self.navigationController?.popToViewController(vc as! VIProcess3VC, animated: true)
                
            }
        }
    }
    @IBAction func btnEditBikeDetails(_ sender: Any) {
        let controllers = self.navigationController?.viewControllers
        for vc in controllers! {
            if vc is VIProcess3VC {
                _ = self.navigationController?.popToViewController(vc as! VIProcess3VC, animated: true)
                
            }
        }
    }
    

}

//MARK: - tblViewDelegate & DataSource
extension VIInsurancePlansVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblViewAvalilablePlans.dequeueReusableCell(withIdentifier: "VIAvailablePlansTblViewCell") as! VIAvailablePlansTblViewCell
        
        cell.lblAddOns.text = AppManger.shared.arrSelectAddOns.count > 0 ? "Included" : "Not included"
        cell.lblIDV.text = "\(AppManger.shared.dicGetPremium.idvAmount ?? 0)"
        cell.lblTitleBuyNow.text = "BUY NOW\n\(AppManger.shared.dicGetPremium.premiumAmount ?? 0)/year"
        cell.lblClaimSupport.text = AppManger.shared.dicGetPremium.vehiclePlan.claimSupport ?? ""
        cell.lblPlanName.text = AppManger.shared.dicGetPremium.vehiclePlan.planName ?? ""
        
        cell.tapOnBuyPlan = {
            let vc = VIReviewPolicyVC.instantiate("Vehicle") as! VIReviewPolicyVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.viewMain.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 18, spread: 0)

        return cell
    }
    
    
}

//MARK: - VIAvailablePlansTblViewCell -
class VIAvailablePlansTblViewCell: UITableViewCell {
    
    @IBOutlet weak var lblPlanName: UILabel!
    @IBOutlet weak var lblClaimSupport: UILabel!
    @IBOutlet weak var lblAddOns: UILabel!
    @IBOutlet weak var lblIDV: UILabel!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblTitleBuyNow: UILabel!
    
    var tapOnBuyPlan: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func btnBuyPlanAction(_ sender: Any) {
        tapOnBuyPlan?()
    }
}
