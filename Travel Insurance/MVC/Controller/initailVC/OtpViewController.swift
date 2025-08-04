//
//  OtpViewController.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 25/10/23.
//

import UIKit
import OTPFieldView
import Toast_Swift

class OtpViewController: UIViewController  {
    
    @IBOutlet weak var otpView: OTPFieldView!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var btnResend: UIButton!
    
    var myTimer: Timer?
    var counter = 59
    
    var enterOtp = ""
    
    var strEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblTimer.text = "\(self.counter) Sec"
        
        setupOtpView()
        self.counter = 59
        startTimer()
        self.lblTimer.isHidden = false
        self.btnResend.isUserInteractionEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    func startTimer() {
        
        self.lblTimer.text = "\(self.counter) Sec"
        self.btnResend.setTitle("Resend in", for: .normal)
        
        myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        
        print(counter)
    }
    
    func stopTimer() {
        
        counter = 59
        self.lblTimer.isHidden = true
        self.btnResend.setTitle("Resent OTP", for: .normal)
        self.btnResend.isUserInteractionEnabled = true
        myTimer?.invalidate()
    }
    
    @objc func timerFired() {
        
        if counter != 1 {
           // print("\(counter) seconds to the end of the world")
            counter -= 1
            
            self.lblTimer.text = "\(self.counter) Sec"
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
        
        self.setUpHideMakeToast()
        if enterOtp == ""
        {
            self.setUpMakeToast(msg: "Please enter otp")
        }
        else
        {
            callVerifyOtpAPI()
        }
        
    }
    @IBAction func clickedResendIn(_ sender: Any) {
        callResendOtpAPI()
    }
    
    // MARK: - calling API
    
    func callVerifyOtpAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["otp":self.enterOtp, "email": self.strEmail]
        
        print(param)
               
        APIClient.sharedInstance.MakeAPICallWithOutAuthHeaderPost(VERIFY_OTP, parameters: param) { response, error, statusCode in
            
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
                        self.setUpMakeToast(msg: "Register Successfully")
                        
                        let dicResponce = response?.value(forKey: "response") as? NSDictionary
                        
                        let authorisation = response?.value(forKey: "authorisation") as? NSDictionary
                        
                        let token = authorisation?.value(forKey: "token") as? String
                        
                        let dicData = TIUserLoginResponse(fromDictionary: dicResponce!)
                        
                        appDelegate?.saveCurrentUserData(dic: dicData)
                        appDelegate?.dicCurrentUserData = dicData
                        
                        UserDefaults.standard.setValue(token ?? "", forKey: "token")
                        UserDefaults.standard.setValue(true, forKey: "isUserLogin")
                        UserDefaults.standard.synchronize()
                        
//                        appDelegate?.setUpHomeCustomer()
                        appDelegate?.setUpHomeVehicle()
                        
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
               
        APIClient.sharedInstance.MakeAPICallWithOutAuthHeaderPost(RESEND_OTP, parameters: param) { response, error, statusCode in
            
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

extension OtpViewController: OTPFieldViewDelegate {
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
