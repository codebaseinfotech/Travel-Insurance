//
//  VIReviewPolicyVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 04/06/25.
//

import UIKit

class VIReviewPolicyVC: UIViewController {

    @IBOutlet weak var lblNameOwner: UILabel! {
        didSet {
            lblNameOwner.text = AppManger.shared.name
        }
    }
    @IBOutlet weak var lblPhoneOwner: UILabel! {
        didSet {
            lblPhoneOwner.text = AppManger.shared.dail_code + " " + AppManger.shared.phone_no
        }
    }
    @IBOutlet weak var lblEmailOwner: UILabel! {
        didSet {
            lblEmailOwner.text = AppManger.shared.email
        }
    }
    
    @IBOutlet weak var lblVehicleMake: UILabel! {
        didSet {
            lblVehicleMake.text = AppManger.shared.vehicle_make
        }
    }
    @IBOutlet weak var lblVehicleModel: UILabel! {
        didSet {
            lblVehicleModel.text = AppManger.shared.vehicle_model
        }
    }
    @IBOutlet weak var lblVehicleYear: UILabel! {
        didSet {
            lblVehicleYear.text = "\(AppManger.shared.vehicle_age)"
        }
    }
    @IBOutlet weak var lblVehicleEngineSize: UILabel! {
        didSet {
            lblVehicleEngineSize.text = "\(AppManger.shared.engine_size)"
        }
    }
    @IBOutlet weak var lblVehiclePlateNumber: UILabel! {
        didSet {
            lblVehiclePlateNumber.text = AppManger.shared.vehicle_no
        }
    }
    @IBOutlet weak var lblVehicleClassisNumber: UILabel! {
        didSet {
            lblVehicleClassisNumber.text = AppManger.shared.chassis_no
        }
    }
    
    @IBOutlet weak var lblPolicyStartDate: UILabel! {
        didSet {
            lblPolicyStartDate.text = AppManger.shared.policy_start_date
        }
    }
    @IBOutlet weak var lblPolicyStandard: UILabel!
    @IBOutlet weak var imgTC: UIImageView!
    
    @IBOutlet weak var tblViewAddOns: UITableView! {
        didSet {
            tblViewAddOns.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)

            tblViewAddOns.delegate = self
            tblViewAddOns.dataSource = self
        }
    }
    @IBOutlet weak var heightTblView: NSLayoutConstraint!
    @IBOutlet weak var viewAddons: UIView!
    @IBOutlet weak var lblTotalAmount: UILabel! {
        didSet {
            lblTotalAmount.text = "IQD" + " " + "\(AppManger.shared.total_premium)"
        }
    }
    
    var isTerms = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewAddons.isHidden = AppManger.shared.arrSelectAddOns.count > 0 ? false : true
        tblViewAddOns.isHidden = AppManger.shared.arrSelectAddOns.count > 0 ? false : true

        // Do any additional setup after loading the view.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey] {
                let newsize  = newvalue as! CGSize
                self.heightTblView.constant = newsize.height
            }
        }
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnEditCarOwnerDetailsAction(_ sender: Any) {
        let controllers = self.navigationController?.viewControllers
        for vc in controllers! {
            if vc is VIProcess4VC {
                _ = self.navigationController?.popToViewController(vc as! VIProcess4VC, animated: true)
                
            }
        }
    }
    @IBAction func btnEditVehicleDetailsAction(_ sender: Any) {
        let controllers = self.navigationController?.viewControllers
        for vc in controllers! {
            if vc is VIProcess3VC {
                _ = self.navigationController?.popToViewController(vc as! VIProcess3VC, animated: true)
                
            }
        }
    }
    @IBAction func btnEditPolicyDetailsAction(_ sender: Any) {
    }
    @IBAction func btnConfirmProceedAction(_ sender: Any) {
        let vc = VIPaymentProcessVC.instantiate("Vehicle") as! VIPaymentProcessVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnTCAction(_ sender: Any) {
        isTerms.toggle()
        imgTC.image = isTerms ? UIImage(named: "ic_check") : UIImage(named: "ic_unCheck")
    }
    
     

}

// MARK: - tblViewDelegate & DataSource
extension VIReviewPolicyVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppManger.shared.arrSelectAddOns.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblViewAddOns.dequeueReusableCell(withIdentifier: "VIAddOnsTblViewCell") as! VIAddOnsTblViewCell
        
        let dicData = AppManger.shared.arrSelectAddOns[indexPath.row]
        
        cell.lblName.text = "\(dicData.title ?? "") (IQD \(dicData.price ?? ""))"

        cell.imgAddOns.image = UIImage(named: "ic_check")
        
        return cell
    }
    
    
}
