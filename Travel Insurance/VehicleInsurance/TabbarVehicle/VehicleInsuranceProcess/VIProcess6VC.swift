//
//  VIProcess6VC.swift
//  Hamraa Insurance
//
//  Created by Poojagabani on 04/06/25.
//

import UIKit

class VIProcess6VC: UIViewController {

    @IBOutlet weak var tblViewAddOns: UITableView! {
        didSet {
            tblViewAddOns.delegate = self
            tblViewAddOns.dataSource = self
        }
    }
    @IBOutlet weak var viewPopUp: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var getAddOn = TIGetAddOnVehiclePlan()
    var isApiCall = false
    
    // MARK: - view Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        callGetAddOn()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnContinueAction(_ sender: Any) {
        if AppManger.shared.arrSelectAddOns.count == 0 {
            self.setUpMakeToast(msg: "Please select an add-on to continue.")
            return
        }
        
        let vc = VIInsurancePlansVC.instantiate("Vehicle") as! VIInsurancePlansVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnCloseAction(_ sender: Any) {
        viewPopUp.isHidden = true
    }
    
    @IBAction func clickedClosePopup(_ sender: Any) {
        viewPopUp.isHidden = true
    }
    
    
    func callGetAddOn() {
        APIClient.sharedInstance.showIndicator()
        
        let param = [
            "vehicle_type": "\(AppManger.shared.vehicle_type)"
        ]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(GET_ADDON, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            let status = response?.value(forKey: "status") as? Int
            let message = response?.value(forKey: "message") as? String ?? ""
            
            if error == nil {
                APIClient.sharedInstance.hideIndicator()
                
                if statusCode == 200 {
                    if let data = response?.value(forKey: "vehicle_plan") as? NSDictionary {
                        
                        let dicData = TIGetAddOnVehiclePlan(fromDictionary: data)
                        self.getAddOn = dicData
                        
                    }
                    self.isApiCall = true
                    self.tblViewAddOns.reloadData()
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

// MARK: - tblView Delegate & DataSource
extension VIProcess6VC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isApiCall ? getAddOn.vehicleAddOn.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblViewAddOns.dequeueReusableCell(withIdentifier: "VIAddOnsTblViewCell") as! VIAddOnsTblViewCell
        
        if isApiCall == true {
            let dicData = getAddOn.vehicleAddOn[indexPath.row]
            cell.lblName.text = "\(dicData.title ?? "") (IQD \(dicData.price ?? ""))"
            
            cell.imgAddOns.image = AppManger.shared.arrSelectAddOns.contains(dicData) == true ? UIImage(named: "ic_check") : UIImage(named: "ic_unCheck")
        }
        
        cell.tapOnInfo = {
            self.viewPopUp.isHidden = false
            let dicData = self.getAddOn.vehicleAddOn[indexPath.row]
            if let description = dicData.descriptionField {
                let attributedText = NSMutableAttributedString(string: description)
                
                // Split by "IQD " to find all amounts
                let components = description.components(separatedBy: "IQD ").dropFirst()
                
                let amounts = components.map { "IQD \($0.components(separatedBy: " ").first ?? "")" }
                
                // Loop through each amount and apply red + bold
                for amount in amounts {
                    if let range = description.range(of: amount) {
                        let nsRange = NSRange(range, in: description)
                        attributedText.addAttribute(.foregroundColor, value: UIColor.red, range: nsRange)
                        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: self.lblTitle.font.pointSize), range: nsRange)
                    }
                }
                
                self.lblTitle.attributedText = attributedText
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dicData = self.getAddOn.vehicleAddOn[indexPath.row]
        
        if AppManger.shared.arrSelectAddOns.contains(where: { $0.id == dicData.id }) {
            AppManger.shared.arrSelectAddOns.removeAll(where: { $0.id == dicData.id })
        } else {
            AppManger.shared.arrSelectAddOns.append(dicData)
        }
         
        tblViewAddOns.reloadData()
    }
    
    
    
}

// MARK: - VIAddOnsTblViewCell
class VIAddOnsTblViewCell: UITableViewCell {
    
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgAddOns: UIImageView!
    
    var tapOnInfo: (()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBAction func btnInfoAction(_ sender: Any) {
        tapOnInfo?()
    }
}
