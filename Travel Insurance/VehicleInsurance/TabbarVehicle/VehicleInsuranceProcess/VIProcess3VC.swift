//
//  VIProcess3VC.swift
//  Hamraa Insurance
//
//  Created by Poojagabani on 03/06/25.
//

import UIKit
import DropDown

class VIProcess3VC: UIViewController {

    @IBOutlet weak var stackViewCarInsurance: UIStackView!
    @IBOutlet weak var stackViewTwoWheelerIN: UIStackView!
    
    @IBOutlet weak var txtCarVMake: UITextField!
    @IBOutlet weak var txtCarModelYear: UITextField!
    @IBOutlet weak var txtCarVValue: UITextField!
    @IBOutlet weak var txtCarVModel: UITextField!
    @IBOutlet weak var txtCarPlateNumber: UITextField!
    @IBOutlet weak var txtCarEngineNumber: UITextField!
    @IBOutlet weak var txtCarClassisNumber: UITextField!
    @IBOutlet weak var txtCarEngineSize: UITextField!
    
    @IBOutlet weak var txtBikeVMake: UITextField!
    @IBOutlet weak var txtBikeYearManufacture: UITextField! 
    @IBOutlet weak var txtBikeRegistrationNumber: UITextField!
    @IBOutlet weak var txtBikeModel: UITextField!
    @IBOutlet weak var txtBikeVColor: UITextField!
    @IBOutlet weak var txtBikeFuleType: UITextField!
    @IBOutlet weak var txtBikeClassisNumber: UITextField!
    @IBOutlet weak var txtBikeEngineSize: UITextField!
    
    var arrAllGetBrand: [THGetBrandData] = []
    
    var dropDownMake = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackViewCarInsurance.isHidden = AppManger.shared.isCarInsurance == true ? false : true
        stackViewTwoWheelerIN.isHidden = AppManger.shared.isCarInsurance == true ? true : false

        txtCarPlateNumber.isUserInteractionEnabled = false
        txtCarPlateNumber.text = AppManger.shared.vehicle_no
        
        txtBikeRegistrationNumber.isUserInteractionEnabled = false
        txtBikeRegistrationNumber.text = AppManger.shared.vehicle_no
        
        callGetBrandAPI()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnContinueAction(_ sender: Any) {
        if AppManger.shared.isCarInsurance == true {
            if isValidCarInsurance() {
                
                let appManger = AppManger.shared
                appManger.vehicle_make = txtCarVMake.text ?? ""
                appManger.model_year = txtCarModelYear.text ?? ""
                appManger.vehicle_value = Int(txtCarVValue.text ?? "") ?? 0
                appManger.vehicle_model = txtCarVModel.text ?? ""
                appManger.engine_no = txtCarEngineNumber.text ?? ""
                appManger.chassis_no = txtCarClassisNumber.text ?? ""
                appManger.engine_size = Int(txtCarEngineSize.text ?? "") ?? 0
                
                let vc = PremiumCalculationVC.instantiate("Vehicle") as! PremiumCalculationVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if isValidBikeInsurance() {
                
                let appManger = AppManger.shared
                appManger.vehicle_make = txtBikeVMake.text ?? ""
                appManger.model_year = txtBikeYearManufacture.text ?? ""
//                appManger.vehicle_value = Int(txtCarVValue.text ?? "") ?? 0
                appManger.vehicle_model = txtBikeModel.text ?? ""
                appManger.engine_no = txtCarEngineNumber.text ?? ""
                appManger.chassis_no = txtBikeClassisNumber.text ?? ""
                appManger.engine_size = Int(txtBikeEngineSize.text ?? "") ?? 0
                appManger.color = txtBikeVColor.text ?? ""
                appManger.fuel_type = txtBikeFuleType.text ?? ""
                
                let vc = PremiumCalculationVC.instantiate("Vehicle") as! PremiumCalculationVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    @IBAction func clickedMake(_ sender: UIButton) {
        dropDownMake.show()
    }
    
    
    func isValidCarInsurance() -> Bool {
        guard let vehicleMake = txtCarVMake.text, !vehicleMake.isEmpty else {
            self.setUpMakeToast(msg: "Please enter vehicle make")
            return false
        }
        
        guard let modelYear = txtCarModelYear.text, !modelYear.isEmpty else {
            self.setUpMakeToast(msg: "Please enter vehicle year")
            return false
        }
        
        guard let vehicleValue = txtCarVValue.text, !vehicleValue.isEmpty else {
            self.setUpMakeToast(msg: "Please enter vehicle value")
            return false
        }
        
        guard let vehicleModel = txtCarVModel.text, !vehicleModel.isEmpty else {
            self.setUpMakeToast(msg: "Please enter vehicle model")
            return false
        }
        
        guard let vehiclePlatNumber = txtCarPlateNumber.text, !vehiclePlatNumber.isEmpty else {
            self.setUpMakeToast(msg: "Please enter vehicle plat number")
            return false
        }
        
        guard let vehicleEngineNumber = txtCarEngineNumber.text, !vehicleEngineNumber.isEmpty else {
            self.setUpMakeToast(msg: "Please enter engine number")
            return false
        }
        
        guard let vehicleChassisNumber = txtCarClassisNumber.text, !vehicleChassisNumber.isEmpty else {
            self.setUpMakeToast(msg: "Please enter chassis number")
            return false
        }
        
        guard let vehicleEngineSize = txtCarEngineSize.text, !vehicleEngineSize.isEmpty else {
            self.setUpMakeToast(msg: "Please enter engine size")
            return false
        }
        
        return true
    }
    
    func isValidBikeInsurance() -> Bool {
        guard let bikeMake = txtBikeVMake.text, !bikeMake.isEmpty else {
            self.setUpMakeToast(msg: "Please enter bike make")
            return false
        }
        
        guard let bikeYear = txtBikeYearManufacture.text, !bikeYear.isEmpty else {
            self.setUpMakeToast(msg: "Please enter year of manufacture")
            return false
        }
        
        guard let registrationNumber = txtBikeRegistrationNumber.text, !registrationNumber.isEmpty else {
            self.setUpMakeToast(msg: "Please enter registration number")
            return false
        }
        
        guard let bikeModel = txtBikeModel.text, !bikeModel.isEmpty else {
            self.setUpMakeToast(msg: "Please enter bike model")
            return false
        }
        
        guard let vehicleColor = txtBikeVColor.text, !vehicleColor.isEmpty else {
            self.setUpMakeToast(msg: "Please enter vehicle color")
            return false
        }
        
        guard let fuelType = txtBikeFuleType.text, !fuelType.isEmpty else {
            self.setUpMakeToast(msg: "Please enter fuel type")
            return false
        }
        
        guard let chassisNumner = txtBikeClassisNumber.text, !chassisNumner.isEmpty else {
            self.setUpMakeToast(msg: "Please enter chassis number")
            return false
        }
        
        guard let engineCapacity = txtBikeEngineSize.text, !engineCapacity.isEmpty else {
            self.setUpMakeToast(msg: "Please enter engine capacity")
            return false
        }
        
        return true
    }
    
    func setUpDropdownGetBrand()
    {
        var arrZone = [String]()
       
        for obj in self.arrAllGetBrand {
            arrZone.append(obj.brand ?? "")
        }
        
        dropDownMake.dataSource = arrZone
        dropDownMake.anchorView = AppManger.shared.isCarInsurance ? txtCarVMake : txtBikeVMake
        dropDownMake.direction = .bottom
        
        dropDownMake.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            if AppManger.shared.isCarInsurance {
                txtCarVMake.text = item
            } else {
                txtBikeVMake.text = item
            }
            
            for obj in arrAllGetBrand {
                if item == obj.brand {
                    AppManger.shared.vehicle_brand = obj.id ?? 0
                }
            }
 
        }
        dropDownMake.bottomOffset = CGPoint(x: 0, y: AppManger.shared.isCarInsurance ? txtCarVMake.bounds.height : txtBikeVMake.bounds.height)
        dropDownMake.topOffset = CGPoint(x: 0, y: AppManger.shared.isCarInsurance ? txtCarVMake.bounds.height : txtBikeVMake.bounds.height)
        dropDownMake.dismissMode = .onTap
        dropDownMake.textColor = UIColor.darkGray
        dropDownMake.backgroundColor = UIColor.white
        dropDownMake.selectionBackgroundColor = UIColor.clear
        
        dropDownMake.reloadAllComponents()
    }
    
    // MARK: - calling API
    func callGetBrandAPI() {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["":""]
        
        var type = ""
        
        type = AppManger.shared.vehicle_type == "1" ? "bike" : "car"
        
        let _url = "type=\(type)"
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(GET_BRAND + _url, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            let status = response?.value(forKey: "status") as? Int
            let message = response?.value(forKey: "message") as? String ?? ""
            
            if error == nil {
                APIClient.sharedInstance.hideIndicator()
                
                if statusCode == 200 {
                        
                    if status == 1 {
                        if let data = response?.value(forKey: "data") as? NSArray {
                            for obj in data {
                                let dicData = THGetBrandData(fromDictionary: obj as! NSDictionary)
                                self.arrAllGetBrand.append(dicData)
                            }
                        }
                        self.setUpDropdownGetBrand()
                    } else {
                        APIClient.sharedInstance.hideIndicator()
                        self.setUpMakeToast(msg: message)
                    }
                } else {
                    APIClient.sharedInstance.hideIndicator()
                    self.setUpMakeToast(msg: message)
                }
            } else {
                APIClient.sharedInstance.hideIndicator()
                self.setUpMakeToast(msg: message)
            }
        }
    }
}
