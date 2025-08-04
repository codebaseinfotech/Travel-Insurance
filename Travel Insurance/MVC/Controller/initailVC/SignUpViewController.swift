//
//  SignUpViewController.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 25/10/23.
//

import UIKit
import ADCountryPicker
import DropDown

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var txtEnterName: UITextField!
    @IBOutlet weak var txtEnterEmail: UITextField!
    @IBOutlet weak var EnterPassword: UITextField!
    @IBOutlet weak var txtEnterMoblie: UITextField!
    @IBOutlet weak var EnterDateOfbirth: UITextField!
    
    @IBOutlet weak var txtCountry: UITextField!
    
    @IBOutlet weak var lblFlag: UILabel!
    @IBOutlet weak var imgTC: UIImageView!
    
    @IBOutlet weak var imgPass: UIImageView!
    
    @IBOutlet weak var viewGender: UIView!
    @IBOutlet weak var lblGender: UILabel!
    
    let picker = ADCountryPicker()
    
    let datePikerSDate = UIDatePicker()
    
    let dropDownGenders = DropDown()
    let dropDownGender = ["Male","Female"]
    
    var strDOB = ""
    
    var isHiddanPassword = false
    
    var isTerams = false
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isTerams = false
        imgTC.image = UIImage(named: "B_T")
        
        isHiddanPassword = true
        imgPass.image = UIImage(named: "H_Pass")
        EnterPassword.isSecureTextEntry = true
        
        setDropDownGender()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedTerm(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "WebVC") as! WebVC
        vc.strTitle = "Terms & Conditions"
        vc.strUrl = "https://www.alhamraains.com/wayak/terms_and_condition"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickedPassword(_ sender: Any) {
        if isHiddanPassword == true
        {
            imgPass.image = UIImage(named: "S_Pass")
            EnterPassword.isSecureTextEntry = false
            
            isHiddanPassword = false
        }
        else
        {
            imgPass.image = UIImage(named: "H_Pass")
            EnterPassword.isSecureTextEntry = true
            
            isHiddanPassword = true
        }
    }
    
    @IBAction func clickedTC(_ sender: Any) {
        // B_T, F_T
        if isTerams == true
        {
            imgTC.image = UIImage(named: "B_T")
            isTerams = false
        }
        else
        {
            imgTC.image = UIImage(named: "F_T")
            isTerams = true
        }
    }
    
    
    @IBAction func clickedCountry(_ sender: Any) {
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
    
    @IBAction func clickedGender(_ sender: Any) {
        self.dropDownGenders.show()
    }
    
    @IBAction func clickedSignUp(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clickedSkip(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func clickedProceed(_ sender: Any) {
        self.setUpHideMakeToast()
        
        if txtEnterName.text == ""
        {
            self.setUpMakeToast(msg: "Please enter name")
        }
        
        else if txtEnterEmail.text == ""
        {
            self.setUpMakeToast(msg: "Please enter Email")
        }
        else if !AppUtilites.isValidEmail(testStr: txtEnterEmail.text ?? "")
        {
            self.setUpMakeToast(msg: "Please enter valid email")
        }
        else if EnterPassword.text == ""
        {
            self.setUpMakeToast(msg: "Please enter password")
        }
        else if (EnterPassword.text?.count ?? 0) < 6
        {
            self.setUpMakeToast(msg: "Please Enter minimum 6 digit password")
        }
        else if txtEnterMoblie.text == ""
        {
            self.setUpMakeToast(msg: "Please enter mobile")
        }
        else if (txtEnterMoblie.text?.count ?? 0) < 8
        {
            self.setUpMakeToast(msg: "Please Enter minimum 8 digit mobile number")
        }
        else if EnterDateOfbirth.text == ""
        {
            self.setUpMakeToast(msg: "Please select date of birth")
        }
//        else if isTerams == false
//        {
//            self.setUpMakeToast(msg: "Select Terms & Conditions")
//        }
        else
        {
            callRegisterUserAPI()
        }
    }
 
    @IBAction func clickedDOB(_ sender: UITextField) {
        datePikerSDate.datePickerMode = .date
        datePikerSDate.maximumDate = Date()
        datePikerSDate.preferredDatePickerStyle = .wheels
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(donedatePickerSDate));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePickerSdate));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        sender.inputAccessoryView = toolbar
        sender.inputView = datePikerSDate
        
    }
    
    @objc func donedatePickerSDate(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        EnterDateOfbirth.text = formatter.string(from: datePikerSDate.date)
        
        let formatterAPI = DateFormatter()
        formatterAPI.dateFormat = "yyyy-MM-dd"
        self.strDOB = formatterAPI.string(from: datePikerSDate.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePickerSdate(){
        self.view.endEditing(true)
    }
    
    func setDropDownGender()
    {
        dropDownGenders.dataSource = dropDownGender
        dropDownGenders.anchorView = viewGender
        dropDownGenders.direction = .bottom
        
        dropDownGenders.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.lblGender.text = item
        }
        
        dropDownGenders.bottomOffset = CGPoint(x: 0, y: viewGender.bounds.height)
        dropDownGenders.topOffset = CGPoint(x: 0, y: -viewGender.bounds.height)
        dropDownGenders.dismissMode = .onTap
        dropDownGenders.textColor = .black
        dropDownGenders.backgroundColor = UIColor.white
        dropDownGenders.selectionBackgroundColor = UIColor.clear
        dropDownGenders.reloadAllComponents()
    }
    
    // MARK: - calling API
    
    func callRegisterUserAPI()
    {
        APIClient.sharedInstance.showIndicator()
        let FirebaseToken = UserDefaults.standard.value(forKey: "FirebaseToken") as? String
        
        let name = self.txtEnterName.text ?? ""
        let email = self.txtEnterEmail.text ?? ""
        let password = self.EnterPassword.text ?? ""
        let mobile_number = self.txtEnterMoblie.text ?? ""
        let date_of_birth = self.strDOB
        let country_code = self.txtCountry.text ?? ""
        
        let param = ["name":name,"email":email,"password":password,"mobile_number":mobile_number,"date_of_birth":date_of_birth,"device_token":FirebaseToken ?? "1234","country_code":country_code,"gender":self.lblGender.text ?? ""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutAuthHeaderPost(USER_REGISTER, parameters: param) { response, error, statusCode in
            
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
                            let otp = dicResponse.value(forKey: "otp") as? String
                            
//                            self.setUpMakeToast(msg: otp ?? "")
                            
                            let mainS = UIStoryboard(name: "Main", bundle: nil)
                            let vc = mainS.instantiateViewController(withIdentifier: "OtpViewController") as!
                            OtpViewController
                            vc.strEmail = self.txtEnterEmail.text ?? ""
                            self.navigationController?.pushViewController(vc, animated: true)
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

extension SignUpViewController: ADCountryPickerDelegate {
    
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String)
    {
        _ = picker.navigationController?.popToRootViewController(animated: true)
        
        self.txtCountry.text = dialCode
        
        let flagImage =  picker.getFlag(countryCode: code)
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
