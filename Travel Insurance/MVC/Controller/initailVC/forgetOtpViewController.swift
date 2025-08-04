//
//  forgetOtpViewController.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 26/10/23.
//

import UIKit
import OTPFieldView

class forgetOtpViewController: UIViewController {
    
    
    
    @IBOutlet weak var otpView: OTPFieldView!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var btnResend: UIButton!
    
    var enterOtp = ""
    var myTimer: Timer?
    var counter = 59
    
    var strEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblTimer.text = "\(counter) Sec"
        
        setupOtpView()
        
        self.counter = 59
        startTimer()
        
        self.lblTimer.isHidden = false
        self.btnResend.isUserInteractionEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    func startTimer() {
        
        self.lblTimer.text = "\(counter) Sec"
        self.btnResend.setTitle("Resend in", for: .normal)
        myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        
        print(counter)
    }
    
    func stopTimer() {
        
        counter = 59
        self.lblTimer.isHidden = true
        self.btnResend.isUserInteractionEnabled = true
        self.btnResend.setTitle("Resent OTP", for: .normal)

        myTimer?.invalidate()
    }
    
    @objc func timerFired() {
        
        if counter != 1 {
            // print("\(counter) seconds to the end of the world")
            counter -= 1
            
            self.lblTimer.text = "\(counter) Sec"
        }
        else
        {
            stopTimer()
        }
        
        // Code to execute when the timer fires
    }
    
    func setupOtpView()
    {
        self.otpView.fieldsCount = 6
        self.otpView.fieldBorderWidth = 1
        self.otpView.defaultBorderColor = UIColor(hexString: "#C8C8C8")
        self.otpView.filledBorderColor = UIColor.black
        self.otpView.cursorColor = UIColor.red
        self.otpView.displayType = .roundedCorner
        self.otpView.fieldSize = 45
        self.otpView.separatorSpace = 9
        self.otpView.shouldAllowIntermediateEditing = false
        self.otpView.delegate = self
        self.otpView.initializeUI()
        
    }
    
    @IBAction func clickedSubmit(_ sender: Any) {
        
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        if enterOtp == ""
        {
            self.view.makeToast("Please enter otp")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please enter otp")
        }
        else
        {
            self.callForgotOtpAPI()
        }
    }
    @IBAction func clickedResendIn(_ sender: Any) {
        callResendOtpAPI()
    }
    
    
    // MARK: - calling API
    
    func callForgotOtpAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["email": self.strEmail, "otp": self.enterOtp]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutAuthHeaderPost(FORGET_PASSWORD_VERIFY, parameters: param) { response, error, statusCode in
            
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
                        let mainS = UIStoryboard(name: "Main", bundle: nil)
                        let vc = mainS.instantiateViewController(withIdentifier: "CreateNewPasswordVC") as! CreateNewPasswordVC
                        vc.strEmail = self.strEmail
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
                    
                    self.setUpMakeToast(msg: message ?? "")
                }
            }
            else
            {
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
    
    func callResendOtpAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["email": self.strEmail]
        
        print(param)
               
        APIClient.sharedInstance.MakeAPICallWithOutAuthHeaderPost(FORGOT_PASSWORD, parameters: param) { response, error, statusCode in
            
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
                        self.setUpMakeToast(msg: "Resend OTP successfully")
                        
                        self.lblTimer.text = "\(self.counter) Sec"
                        
                        self.setupOtpView()
                        
                        self.counter = 59
                        self.startTimer()
                        
                        self.lblTimer.isHidden = false
                        self.btnResend.isUserInteractionEnabled = false
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

extension forgetOtpViewController: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("has entered all otp? \(hasEntered)")
        return false
    }
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpstring: String) {
        print("otpstring: \(otpstring)")
        
        self.enterOtp = otpstring
    }
    
}

