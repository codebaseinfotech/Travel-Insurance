//
//  LoginViewController.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 25/10/23.
//

import UIKit
import Toast_Swift
import Foundation

extension Notification.Name {
    
    public static let myNotificationForm1 = Notification.Name(rawValue: "myNotificationForm1")
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtEnterUserName: UITextField!
    @IBOutlet weak var txtEnterPassword: UITextField!

    @IBOutlet weak var imgPass: UIImageView!
    
    var isHiddanPassword = false
    
    var isFromHome = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //txtEnterUserName.text = "cash@yopmail.com"
    //    txtEnterPassword.text = "123456"
        
        txtEnterUserName.text = "saurabh@techmavesoftware.com"
        txtEnterPassword.text = "123456"
        
//        txtEnterUserName.text = "notcashnotout@yopmail.com"
//        txtEnterPassword.text = "123456"

        
        isHiddanPassword = true
        imgPass.image = UIImage(named: "H_Pass")
        txtEnterPassword.isSecureTextEntry = true
      
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedPasswor(_ sender: Any) {
        if isHiddanPassword == true
        {
            imgPass.image = UIImage(named: "S_Pass")
            txtEnterPassword.isSecureTextEntry = false
            
            isHiddanPassword = false
        }
        else
        {
            imgPass.image = UIImage(named: "H_Pass")
            txtEnterPassword.isSecureTextEntry = true
            
            isHiddanPassword = true
        }
    }
    
    @IBAction func clickedProceed(_ sender: Any) {
        self.setUpHideMakeToast()
        if txtEnterUserName.text == ""
        {
            self.setUpMakeToast(msg: "Please enter username")
        }
        else if txtEnterPassword.text == ""
        {
            self.setUpMakeToast(msg: "Please enter Password")
        }
        else
        {
            callLoginUsrAPI()
        }
    }
    
    @IBAction func clickedSkip(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func clickedForgetPassword(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as! ForgetPasswordViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func clickedSignUp(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - callingAPI
    
    func callLoginUsrAPI()
    {
        APIClient.sharedInstance.showIndicator()
        let FirebaseToken = UserDefaults.standard.value(forKey: "FirebaseToken") as? String
        let param = ["email":self.txtEnterUserName.text ?? "","password":self.txtEnterPassword.text ?? "","device_token":FirebaseToken ?? "1234"]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutAuthHeaderPost(USER_LOGIN, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200
                {
                    if status == 200
                    {
                        self.setUpMakeToast(msg: message ?? "")
                        
                        let dicResponce = response?.value(forKey: "response") as? NSDictionary
                        
                        let authorisation = response?.value(forKey: "authorisation") as? NSDictionary
                       
                        let currency_symbol = response?.value(forKey: "currency_symbol") as? String
                        
                        let token = authorisation?.value(forKey: "token") as? String
                        
                        let dicData = TIUserLoginResponse(fromDictionary: dicResponce!)
                        
                        appDelegate?.saveCurrentUserData(dic: dicData)
                        appDelegate?.dicCurrentUserData = dicData
 
                        
                        UserDefaults.standard.setValue(currency_symbol ?? "", forKey: "currency_symbol")
                        UserDefaults.standard.setValue(token ?? "", forKey: "token")
                        UserDefaults.standard.setValue(true, forKey: "isUserLogin")
                        UserDefaults.standard.synchronize()
                        
                        if self.isFromHome == true
                        {
                            if dicData.permissionPurchase == "0"
                            {
                                NotificationCenter.default.post(name: Notification.Name.myNotificationForm1, object: nil, userInfo:["": ""]) // Notification

                                self.navigationController?.popViewController(animated: false)
                            }
                            else if dicData.permissionPurchase == appDelegate?.strSelectedPermissionPurchase
                            {
                                NotificationCenter.default.post(name: Notification.Name.myNotificationForm1, object: nil, userInfo:["": ""])
                                
                                self.navigationController?.popViewController(animated: false)
                            }
                            else
                            {
                                /*if dicData.roleId == 1
                                {
                                    appDelegate?.setUpHomeCustomer()
                                }
                                else
                                {
                                    appDelegate?.setUpHomeAgent()
                                }*/
                                appDelegate?.setUpHomeVehicle()
                            }
 
                        }
                        else
                        {
                            /*if dicData.roleId == 1
                            {
                                appDelegate?.setUpHomeCustomer()
                            }
                            else
                            {
                                appDelegate?.setUpHomeAgent()
                            }*/
                            appDelegate?.setUpHomeVehicle()
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
