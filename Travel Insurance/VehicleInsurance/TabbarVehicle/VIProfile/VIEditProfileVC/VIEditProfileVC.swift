//
//  VIEditProfileVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 06/06/25.
//

import UIKit
import ADCountryPicker

class VIEditProfileVC: UIViewController {

    @IBOutlet weak var txtFullName: UITextField! {
        didSet {
            txtFullName.text = appDelegate?.dicCurrentUserData.name ?? ""
        }
    }
    @IBOutlet weak var txtEmail: UITextField! {
        didSet {
            txtEmail.text = appDelegate?.dicCurrentUserData.email ?? ""
        }
    }
    @IBOutlet weak var txtPhoneNumber: UITextField! {
        didSet {
            txtPhoneNumber.text = appDelegate?.dicCurrentUserData.mobileNumber ?? ""
        }
    }
    @IBOutlet weak var lblCouontryCode: UILabel! {
        didSet {
            lblCouontryCode.text = appDelegate?.dicCurrentUserData.countryCode ?? ""
        }
    }
    @IBOutlet weak var lblFlag: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCountruAction(_ sender: Any) {
        let picker = ADCountryPicker()
        // delegate
        picker.delegate = self
        
        // Display calling codes
        picker.showCallingCodes = true
        
        // or closure
        picker.didSelectCountryClosure = { name, code in
            _ = picker.navigationController?.popToRootViewController(animated: true)
            print(code)
        }
        
        // Use this below code to present the picker
        
        let pickerNavigationController = UINavigationController(rootViewController: picker)
        self.present(pickerNavigationController, animated: true, completion: nil)
    }
    @IBAction func btnSaveChangeAction(_ sender: Any) {
        guard let name = txtFullName.text, !name.isEmpty else {
            self.setUpMakeToast(msg: "Please entre name")
            return
        }
        
        guard let mobile = txtPhoneNumber.text, !mobile.isEmpty else {
            self.setUpMakeToast(msg: "Please enter mobile number")
            return
        }
        
        callProfileAPI()
    }
    
    func callProfileAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["name":self.txtFullName.text ?? "","mobile_number": "\(self.txtPhoneNumber.text ?? "")", "date_of_birth": appDelegate?.dicCurrentUserData.dateOfBirth ?? "", "country_code": appDelegate?.dicCurrentUserData.countryCode ?? ""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(PROFILE_UPDATE, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200
                {
                    if status == 201
                    {
                        if let dicResponse = response?.value(forKey: "response") as? NSDictionary
                        {
                            let dicData = TIUserLoginResponse(fromDictionary: dicResponse)
                            
                            appDelegate?.saveCurrentUserData(dic: dicData)
                            appDelegate?.dicCurrentUserData = dicData
                        }
                        self.btnBackAction(self)
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

extension VIEditProfileVC: ADCountryPickerDelegate {
    
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String)
    {
        _ = picker.navigationController?.popToRootViewController(animated: true)
        
        self.lblCouontryCode.text = dialCode
//        self.countruCode = dialCode
        
        let _ =  picker.getFlag(countryCode: code)
        self.lblFlag.text = countryFlag(code)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func countryFlag(_ countryCode: String) -> String {
        let flagBase = UnicodeScalar("🇦").value - UnicodeScalar("A").value
        
        let flag = countryCode
            .uppercased()
            .unicodeScalars
            .compactMap({ UnicodeScalar(flagBase + $0.value)?.description })
            .joined()
        return flag
    }
    
    
}
