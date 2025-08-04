//
//  VIProcess4VC.swift
//  Hamraa Insurance
//
//  Created by Poojagabani on 03/06/25.
//

import UIKit
import ADCountryPicker

class VIProcess4VC: UIViewController {
    
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var txtPolicyStartDate: UITextField!
    @IBOutlet weak var lblFlaf: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    
    var datePickerDOB = UIDatePicker()
    var datePickerPolicyStart = UIDatePicker()
    
    var isPolicyDate = false
    var countruCode = "+964"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func clikedCountryCode(_ sender: Any) {
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
    
    @IBAction func btnDOBAction(_ sender: UITextField) {
        isPolicyDate = false
        datePickerDOB.datePickerMode = .date
        datePickerDOB.preferredDatePickerStyle = .wheels
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Adjust format to match your input
        dateFormatter.timeZone = TimeZone.current
        
        datePickerDOB.maximumDate = Date()
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "CANCEL", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        sender.inputAccessoryView = toolbar
        sender.inputView = datePickerDOB
    }
    @IBAction func btnPolicyDate(_ sender: UITextField) {
        isPolicyDate = true
        datePickerPolicyStart.datePickerMode = .date
        datePickerPolicyStart.preferredDatePickerStyle = .wheels
                
        datePickerPolicyStart.minimumDate = Date()
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "CANCEL", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        sender.inputAccessoryView = toolbar
        sender.inputView = datePickerPolicyStart
    }
    
    @objc func donedatePicker(){
        if isPolicyDate == true {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            txtPolicyStartDate.text = formatter.string(from: datePickerPolicyStart.date)
            self.view.endEditing(true)
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            txtDob.text = formatter.string(from: datePickerDOB.date)
            self.view.endEditing(true)
        }
    }
    
    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }
    
    @IBAction func btnContinueAction(_ sender: Any) {
        if isValidOwnerDetails() {
            
            let appManager = AppManger.shared
            appManager.name = txtFullName.text ?? ""
            appManager.email = txtEmail.text ?? ""
            appManager.dail_code = countruCode
            appManager.phone_no = txtMobileNumber.text ?? ""
            appManager.dob = txtDob.text ?? ""
            appManager.policy_start_date = txtPolicyStartDate.text ?? ""
            
            let vc = VIProcess5VC.instantiate("Vehicle") as! VIProcess5VC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func isValidOwnerDetails() -> Bool {
        
        guard let fullName = txtFullName.text, !fullName.isEmpty else {
            self.setUpMakeToast(msg: "Please enter full name")
            return false
        }
        
        guard let email = txtEmail.text, !email.isEmpty else {
            self.setUpMakeToast(msg: "Please enter Email address")
            return false
        }
        
        guard AppUtilites.isValidEmail(testStr: email) else {
            self.setUpMakeToast(msg: "Please enter valid email address")
            return false
        }
        
        guard let phoneNumber = txtMobileNumber.text, !phoneNumber.isEmpty else {
            self.setUpMakeToast(msg: "Please enter mobile number")
            return false
        }
        
        guard let dob = txtDob.text, !dob.isEmpty else {
            self.setUpMakeToast(msg: "Please select date of birth")
            return false
        }
        
        guard let policyDate = txtPolicyStartDate.text, !policyDate.isEmpty else {
            self.self.setUpMakeToast(msg: "Please select policy start date")
            return false
        }
        
        return true
    }
    
    
}

extension VIProcess4VC: ADCountryPickerDelegate {
    
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String)
    {
        _ = picker.navigationController?.popToRootViewController(animated: true)
        
        self.lblCode.text = code
        self.countruCode = dialCode
        
        let _ =  picker.getFlag(countryCode: code)
        self.lblFlaf.text = countryFlag(code)
        
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
