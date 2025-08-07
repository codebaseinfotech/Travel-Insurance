//
//  VIPaymentProcessVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 04/06/25.
//

import UIKit

class VIPaymentProcessVC: UIViewController {

    @IBOutlet weak var viewCarDetailsMain: UIView!
    @IBOutlet weak var viewBikeDetailsMain: UIView!
    @IBOutlet weak var lblPlanName: UILabel! {
        didSet {
            lblPlanName.text = AppManger.shared.dicGetPremium.vehiclePlan.planName ?? ""
        }
    }
    @IBOutlet weak var lblPlanType: UILabel!
    
    @IBOutlet weak var lblFinalPremium: UILabel! {
        didSet {
            lblFinalPremium.text = "\(AppManger.shared.dicGetPremium.idvAmount ?? 0)"
        }
    }
    
    @IBOutlet weak var tblViewAddOns: UITableView! {
        didSet {
            tblViewAddOns.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
            
            tblViewAddOns.delegate = self
            tblViewAddOns.dataSource = self
        }
    }
    @IBOutlet weak var heightTblView: NSLayoutConstraint!
    
    @IBOutlet weak var lblCarName: UILabel! {
        didSet {
            let companyName = AppManger.shared.vehicle_make
            let vehicleName = AppManger.shared.vehicle_model
            let enginSize = "\(AppManger.shared.engine_size)" + " " + "cc"
            
            lblCarName.text = companyName + " " + vehicleName + " " + "(\(enginSize))"
        }
    }
    @IBOutlet weak var lblCarNumber: UILabel! {
        didSet {
            let number = AppManger.shared.vehicle_no + " | " + AppManger.shared.model_year + " " + "registered"
            lblCarNumber.text = number
        }
    }
    
    @IBOutlet weak var lblBikeName: UILabel! {
        didSet {
            let companyName = AppManger.shared.vehicle_make
            let vehicleName = AppManger.shared.vehicle_model
            let enginSize = "\(AppManger.shared.engine_size)" + " " + "cc"
            
            lblBikeName.text = companyName + " " + vehicleName + " " + "(\(enginSize))"
        }
    }
    @IBOutlet weak var lblBikeNumber: UILabel! {
        didSet {
            let number = AppManger.shared.vehicle_no + " | " + AppManger.shared.model_year + " " + "registered"
            lblBikeNumber.text = number
        }
    }
    @IBOutlet weak var viewPaymentProsess: UIView! {
        didSet {
            viewPaymentProsess.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewCarDetailsMain.isHidden = AppManger.shared.isCarInsurance ? false : true
        viewBikeDetailsMain.isHidden = AppManger.shared.isCarInsurance ? true : false

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
    @IBAction func btnPaySecurelyAction(_ sender: Any) {
        let vc = VIPaymentModeVC.instantiate("Vehicle") as! VIPaymentModeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

//MARK: - tblView Delegate & DataSource
extension VIPaymentProcessVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblViewAddOns.dequeueReusableCell(withIdentifier: "VIAddOnsTblViewCell") as! VIAddOnsTblViewCell
        
        cell.imgAddOns.image = UIImage(named: "ic_check")
        
        return cell
    }
    
    
}
