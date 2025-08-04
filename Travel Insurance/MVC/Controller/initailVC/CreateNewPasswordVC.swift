//
//  CreateNewPasswordVC.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 26/10/23.
//

import UIKit

class CreateNewPasswordVC: UIViewController {

    @IBOutlet weak var txtEnterPassword: UITextField!
    @IBOutlet weak var txtRepassword: UITextField!
    
    @IBOutlet weak var imgNewPass: UIImageView!
    @IBOutlet weak var imgRePass: UIImageView!
    
    var strEmail = ""
    
    var isHiddanNew = false
    
    var isHiddanRe = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isHiddanNew = true
        imgNewPass.image = UIImage(named: "H_Pass")
        txtEnterPassword.isSecureTextEntry = true
        
        isHiddanRe = true
        imgRePass.image = UIImage(named: "H_Pass")
        txtRepassword.isSecureTextEntry = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedNewPass(_ sender: Any) {
        if isHiddanNew == true
        {
            imgNewPass.image = UIImage(named: "S_Pass")
            txtEnterPassword.isSecureTextEntry = false
            
            isHiddanNew = false
        }
        else
        {
            imgNewPass.image = UIImage(named: "H_Pass")
            txtEnterPassword.isSecureTextEntry = true
            
            isHiddanNew = true
        }
    }
    @IBAction func clickedRePass(_ sender: Any) {
        if isHiddanRe == true
        {
            imgRePass.image = UIImage(named: "S_Pass")
            txtRepassword.isSecureTextEntry = false
            
            isHiddanRe = false
        }
        else
        {
            imgRePass.image = UIImage(named: "H_Pass")
            txtRepassword.isSecureTextEntry = true
            
            isHiddanRe = true
        }
    }
    
    @IBAction func clickedSkip(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickedSubmit(_ sender: Any) {
        if txtEnterPassword.text == ""
        {
            self.view.makeToast("Please enter password")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please enter password")
        }
       else if txtRepassword.text == ""
        {
            self.view.makeToast("Please Re enter password")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please Re enter password")
        }
        else{
            callNewPasswordAPI()
        }
    }
    
    // MARK: - calling API
    
    func callNewPasswordAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["email": self.strEmail, "password": self.txtEnterPassword.text ?? "", "confirm_password": self.txtRepassword.text ?? ""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutAuthHeaderPost(CREATE_PASSWORD, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                let response = response?.value(forKey: "response") as? String
                
                if status == 201
                {
                    self.setUpMakeToast(msg: response ?? "")
                    let mainS = UIStoryboard(name: "Main", bundle: nil)
                    let vc = mainS.instantiateViewController(withIdentifier: "PasswordChangeViewController") as! PasswordChangeViewController
                    self.navigationController?.pushViewController(vc, animated: true)
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
