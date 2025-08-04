//
//  ForgetPasswordViewController.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 26/10/23.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var txtEnterEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedSkip(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
     }
    
    @IBAction func clickedProceed(_ sender: Any) {
        if txtEnterEmail.text == ""
        {
            self.setUpMakeToast(msg: "Please enter email")
        }
        else if !AppUtilites.isValidEmail(testStr: txtEnterEmail.text ?? "")
        {
            self.setUpMakeToast(msg: "Please enter valid email")
        }
        else
        {
            callForgotPasswordAPI()
        }
    }
    
    // MARK: - calling API
    
    func callForgotPasswordAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["email": self.txtEnterEmail.text ?? ""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutAuthHeaderPost(FORGOT_PASSWORD, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if status == 200
                {
                    if let dicResponse = response?.value(forKey: "response") as? NSDictionary
                    {
                        let otp = dicResponse.value(forKey: "otp") as? String
                        
//                        self.setUpMakeToast(msg: otp ?? "")
                        
                        let mainS = UIStoryboard(name: "Main", bundle: nil)
                        let vc = mainS.instantiateViewController(withIdentifier: "forgetOtpViewController") as!
                        forgetOtpViewController
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
            }
        }
    }

}
