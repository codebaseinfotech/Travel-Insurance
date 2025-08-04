//
//  PaymentDetailsVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 02/09/24.
//

import UIKit
import JMMaskTextField_Swift
import Toast_Swift
import SafariServices
import OPPWAMobile_MSA

enum CardType: String {
    case visa = "VISA"
    case masterCard = "MASTER"
    case amex = "American Express"
    case discover = "Discover"
    case dinersClub = "Diners Club"
    case jcb = "JCB"
    case unknown = "Unknown"
    
    static func from(cardNumber: String) -> CardType {
        // Clean up card number (remove spaces or dashes)
        let cleanedCardNumber = cardNumber.replacingOccurrences(of: " ", with: "")
                                        .replacingOccurrences(of: "-", with: "")
        
        // Regular expressions for different card types
        let cardPatterns: [CardType: String] = [
            .visa: "^4[0-9]{12}(?:[0-9]{3})?$",             // Visa starts with 4 and is 13 or 16 digits long
            .masterCard: "^5[1-5][0-9]{14}$",               // MasterCard starts with 51-55 and is 16 digits long
            .amex: "^3[47][0-9]{13}$",                      // Amex starts with 34 or 37 and is 15 digits long
            .discover: "^6(?:011|5[0-9]{2})[0-9]{12}$",     // Discover starts with 6011 or 65 and is 16 digits long
            .dinersClub: "^3(?:0[0-5]|[68][0-9])[0-9]{11}$", // Diners Club is 14 digits long
            .jcb: "^35[0-9]{14}$"                           // JCB starts with 35 and is 16 digits long
        ]
        
        // Check each pattern against the card number
        for (cardType, pattern) in cardPatterns {
            let regex = try! NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: cleanedCardNumber.utf16.count)
            if regex.firstMatch(in: cleanedCardNumber, options: [], range: range) != nil {
                return cardType
            }
        }
        
        return .unknown
    }
}

class PaymentDetailsVC: UIViewController, SFSafariViewControllerDelegate, OPPThreeDSEventListener, UITextFieldDelegate{
    
    @IBOutlet weak var txtCardNUmber: JMMaskTextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDate: JMMaskTextField!
    @IBOutlet weak var txtCvv: JMMaskTextField!
    @IBOutlet weak var btnPAy: UIButton!
    
    var transactionDetailsId = 0
    var iQDAmount = 0
    
    var policy_start_date = ""
    var policy_end_date = ""
    var time_period = ""
    var currencySymbol = ""
    
    let provider = OPPPaymentProvider(mode: .live)
    var transaction: OPPTransaction?
    var safariVC: SFSafariViewController?
    
    var checkoutID = ""
    
    var isModify = false
    
    var strCard = ""
    var user_insurance_id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.provider.threeDSEventListener = self
        
        // Do any additional setup after loading the view.
    }
   
    
    @IBAction func clcikedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickedCAncel(_ sender: Any) {
        clcikedBack(self)
    }
    @IBAction func clickedPay(_ sender: UIButton) {
        if txtCardNUmber.text == ""
        {
            self.setUpMakeToast(msg: "Please enter Card Number")
        }
        else if !isValidCardNumber(txtCardNUmber.text ?? "") {
            self.setUpMakeToast(msg: "Card number is invalid.")
        }
        else if txtName.text == ""
        {
            self.setUpMakeToast(msg: "Please enter Card holder name")
        }
        else if txtDate.text == ""
        {
            self.setUpMakeToast(msg: "please enter date")
        }
        else if txtCvv.text == ""
        {
            self.setUpMakeToast(msg: "please enter CVV")
        }
        else
        {
            btnPAy.isUserInteractionEnabled = false
            
            let cardNumber = txtCardNUmber.text ?? ""
            let cardType = CardType.from(cardNumber: cardNumber)
            print("Card Type: \(cardType.rawValue)")
            strCard = cardType.rawValue
            callPaymentAPI()
        }
    }
    
    func isValidCardNumber(_ cardNumber: String) -> Bool {
        let trimmedCardNumber = cardNumber.replacingOccurrences(of: " ", with: "")
        
        guard trimmedCardNumber.allSatisfy({ $0.isNumber }) else {
            return false
        }

        let reversedDigits = trimmedCardNumber.reversed().map { String($0) }
        var sum = 0

        for (index, digitStr) in reversedDigits.enumerated() {
            guard let digit = Int(digitStr) else { return false }

            // Double every second digit
            if index % 2 == 1 {
                let doubledValue = digit * 2
                sum += doubledValue > 9 ? doubledValue - 9 : doubledValue
            } else {
                sum += digit
            }
        }

        // Valid if the total modulo 10 is equal to 0
        return sum % 10 == 0
    }
    
    func callPaymentAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let parm = ["entityId" :"\(ENTITY_ID)","amount":"\(iQDAmount)","currency": "IQD","paymentType":"DB"]
        
        print(parm)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPostPaymentGetway("\(PAYMENT_URL)/v1/checkouts", parameters: parm) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
               APIClient.sharedInstance.hideIndicator()
                
                //                let status = response?.value(forKey: "status") as? Int
                //                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200
                {
                    if let result = response?.value(forKey: "result") as? NSDictionary {
                        
                        if let code = result.value(forKey: "code") as? String, code == "000.000.000" || code == "000.000.100" || code == "000.100.110" || code == "000.200.110" || code == "000.200.100" {
                            
                            let id = response?.value(forKey: "id") as? String
                            
                            guard let transaction = self.createTransaction(checkoutID: id ?? "") else {
                                return
                            }
                            self.provider.submitTransaction(transaction, completionHandler: { (transaction, error) in
                                DispatchQueue.main.async {
                                    self.handleTransactionSubmission(transaction: transaction, error: error)
                                }
                            })
                        }
                    }
                    
                  //  APIClient.sharedInstance.hideIndicator()
                } else {
                    APIClient.sharedInstance.hideIndicator()
                    self.btnPAy.isUserInteractionEnabled = true
                }
            } else {
                APIClient.sharedInstance.hideIndicator()
                self.btnPAy.isUserInteractionEnabled = true
            }
        }
    }
    
    // MARK: - Payment helpers
    
    func createTransaction(checkoutID: String) -> OPPTransaction? {
        
        let dateString = txtDate.text ?? ""
        
        let componate = dateString.components(separatedBy: "/")
        
        let month = componate[0]
        let year = componate[1]
        
        do {
            let params = try OPPCardPaymentParams.init(checkoutID: checkoutID, paymentBrand: strCard, holder: self.txtName.text!, number: self.txtCardNUmber.text!, expiryMonth: month, expiryYear: year, cvv: self.txtCvv.text!)
            
           // params.shopperResultURL = "msdk.demo.async://payment"
            params.shopperResultURL = "TravelInsurance://result"
            return OPPTransaction.init(paymentParams: params)
        } catch let error as NSError {
            btnPAy.isUserInteractionEnabled = true
            APIClient.sharedInstance.hideIndicator()
            AppUtilites.showAlert(title: "", message: error.localizedDescription, cancelButtonTitle: "OK")
            return nil
        }
    }
    
    func handleTransactionSubmission(transaction: OPPTransaction?, error: Error?) {
        guard let transaction = transaction else {
            btnPAy.isUserInteractionEnabled = true
            APIClient.sharedInstance.hideIndicator()
            AppUtilites.showAlert(title: "", message: error!.localizedDescription, cancelButtonTitle: "OK")
            return
        }
        
        self.transaction = transaction
        if transaction.type == .synchronous {
            // If a transaction is synchronous, just request the payment status
            self.requestPaymentStatus()
        } else if transaction.type == .asynchronous {
            // If a transaction is asynchronous, you should open transaction.redirectUrl in a browser
            // Subscribe to notifications to request the payment status when a shopper comes back to the app
            NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveAsynchronousPaymentCallback), name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
            self.presenterURL(url: self.transaction!.redirectURL!)
        } else {
            btnPAy.isUserInteractionEnabled = true
            APIClient.sharedInstance.hideIndicator()
            AppUtilites.showAlert(title: "", message: "Invalid transaction", cancelButtonTitle: "OK")
        }
    }
    
    func presenterURL(url: URL) {
        self.safariVC = SFSafariViewController(url: url)
        self.safariVC?.delegate = self;
        self.present(safariVC!, animated: true, completion: nil)
    }
    
    @objc func didReceiveAsynchronousPaymentCallback() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
        self.safariVC?.dismiss(animated: true, completion: {
            DispatchQueue.main.async {
                self.requestPaymentStatus()
            }
        })
    }
    
    // MARK: - OPPThreeDSEventListener methods
    
    func onThreeDSChallengeRequired(completion: @escaping (UINavigationController) -> Void) {
        completion(self.navigationController!)
    }
    
    func onThreeDSConfigRequired(completion: @escaping (OPPThreeDSConfig) -> Void) {
        let config = OPPThreeDSConfig()
        config.appBundleID = "com.aciworldwide.MSDKDemo"
        completion(config)
    }
    
    // MARK: - Safari Delegate
    
    internal func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true) {
            DispatchQueue.main.async {
                self.requestPaymentStatus()
            }
        }
    }
    
    
    func requestPaymentStatus() {
        // You can either hard-code resourcePath or request checkout info to get the value from the server
        // * Hard-coding: "/v1/checkouts/" + checkoutID + "/payment"
        // * Requesting checkout info:
        
        guard let checkoutID = self.transaction?.paymentParams.checkoutID else {
            btnPAy.isUserInteractionEnabled = true
            APIClient.sharedInstance.hideIndicator()
            AppUtilites.showAlert(title: "", message: "Checkout ID is invalid", cancelButtonTitle: "OK")
            return
        }
        self.transaction = nil
        
        self.provider.requestCheckoutInfo(withCheckoutID: checkoutID) { (checkoutInfo, error) in
            DispatchQueue.main.async {
                guard let resourcePath = checkoutInfo?.resourcePath else {
                    AppUtilites.showAlert(title: "", message: "Checkout info is empty or doesn't contain resource path", cancelButtonTitle: "OK")
                    return
                }
                
                print("\(PAYMENT_URL)\(resourcePath)")
                
                self.callPaymentResponseAPI(endPoint: resourcePath)
                
                //                self.requestPaymentStatus(resourcePath: resourcePath) { (success) in
                //                    DispatchQueue.main.async {
                //                        let message = success ? "Your payment was successful" : "Your payment was not successful"
                //                        AppUtilites.showAlert(title: "", message: message, cancelButtonTitle: "OK")
                //                    }
                //                }
            }
        }
    }
    
    func requestPaymentStatus(resourcePath: String, completion: @escaping (Bool) -> Void) {
        OPPMerchantServer.requestPaymentStatus(resourcePath: resourcePath) { status, error in
            if status {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func callPaymentResponseAPI(endPoint: String) {
        // API URL
        let urlString = "\(PAYMENT_URL)\(endPoint)"
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            
            // Specify the HTTP method if needed (GET is default)
            request.httpMethod = "GET"
            
            // Optionally, you can add headers if your request requires them
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Create URL session
            let session = URLSession.shared
            
            // Perform the request
            let task = session.dataTask(with: request) { data, response, error in
                // Check for errors
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                // Handle the HTTP response
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                }
                
                // Handle the response data
                if let data = data {
                    do {
                        // Convert the response data to a dictionary
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            print("Response Dictionary: \(json)")
                            
                            let result = json["result"] as? [String: Any]
                            
                            let code = result?["code"] as? String
                            
                            let paymentBrand = json["paymentBrand"] as? String
                            let paymentType = json["paymentType"] as? String
                            let id = json["id"] as? String
                            
                            var order_status = ""
                            
                            if code == "000.100.110" || code == "000.000.000" || code == "000.000.100" || code == "000.200.110" || code == "000.200.100"
                            {
                                order_status = "success"
                            }
                            else
                            {
                                order_status = "failed"
                            }
                            
                            var urlEncodedJson = ""
                            
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                                
                                // Convert the Data object to a String
                                if let jsonString = String(data: jsonData, encoding: .utf8) {
                                    print(jsonString)
                                    urlEncodedJson = jsonString
                                }
                            } catch {
                                print("Error: \(error)")
                            }
                            
                            print("payment_response: \(urlEncodedJson)")
                            print("order_status: \(order_status)")
                            print("paymentBrand: \(paymentBrand ?? "")")
                            print("paymentType: \(paymentType ?? "")")
                            
                            self.callTransactionAPI(order_status: order_status, paymentBrand: paymentBrand ?? "", paymentType: paymentType ?? "", id: id ?? "", payment_response: urlEncodedJson)
                            
                        } else {
                            print("Failed to parse response as JSON")
                        }
                    } catch let parseError {
                        print("JSON Parsing Error: \(parseError)")
                    }
                }
            }
            
            // Start the task
            task.resume()
        } else {
            print("Invalid URL")
        }
    }
    
    func callTransactionAPI(order_status: String, paymentBrand: String, paymentType: String, id:String, payment_response: String)
    {
      //  APIClient.sharedInstance.showIndicator()
        
        var _url = ""
        
        let transaction_details_id = transactionDetailsId
        
        var parm = ["":""]
        
        if self.isModify == true {
            _url = SINGLE_EXTENDPOLICY_PAYMENT
            
            parm = ["transaction_details_id":"\(transaction_details_id)","order_status":order_status,"txn_id":id,"currency":"IQD","card_type":paymentBrand,"payment_response":"Card","payment_method":"1","policy_start_date":policy_start_date,"policy_end_date":policy_end_date,"time_period":time_period,"currencySymbol":currencySymbol,"user_insurance_id":"\(user_insurance_id)"]
            
        } else {
            _url = ORDER_INSURANCE + "\(transaction_details_id)"
            
            parm = ["transaction_details_id":"\(transaction_details_id)","order_status":order_status,"txn_id":id,"currency":"IQD","card_type":paymentBrand,"payment_response":payment_response,"payment_method":"1"]
        }
        
        print(parm)
        
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(_url, parameters: parm) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                if self.isModify == true {
                    
                    let status = response?.value(forKey: "status") as? Int
                    let message = response?.value(forKey: "message") as? String
                    
                    if statusCode == 200 {
                        
                        if status == 1 {
                            
                            let insuranceReports = response?.value(forKey: "insuranceReports") as? String
                            let url = response?.value(forKey: "url") as? String
                            
                            let mainS = UIStoryboard(name: "Main", bundle: nil)
                            let vc = mainS.instantiateViewController(withIdentifier: "OrderPlacedViewController") as! OrderPlacedViewController
                            vc.isOpen = true
                            vc.Invoiceurl = url ?? ""
                            self.navigationController?.pushViewController(vc, animated: false)
                        } else {
                            
                            APIClient.sharedInstance.hideIndicator()
                            self.btnPAy.isUserInteractionEnabled = true
                            
                            self.setUpMakeToast(msg: message ?? "")
                            
                            
                            let controllers = self.navigationController?.viewControllers
                            for vc in controllers! {
                                if vc is PolicyDetailVC {
                                    _ = self.navigationController?.popToViewController(vc as! PolicyDetailVC, animated: true)
                                    
                                }
                            }
                        }
                    } else {
                        
                        APIClient.sharedInstance.hideIndicator()
                        self.btnPAy.isUserInteractionEnabled = true
                        self.setUpMakeToast(msg: message ?? "")
                        
                        
                        let controllers = self.navigationController?.viewControllers
                        for vc in controllers! {
                            if vc is PolicyDetailVC {
                                _ = self.navigationController?.popToViewController(vc as! PolicyDetailVC, animated: true)
                                
                            }
                        }
                    }
                    
                } else {
                    let success = response?.value(forKey: "success") as? Int
                    let message = response?.value(forKey: "message") as? String
                    
                    if statusCode == 200
                    {
                        if success == 1
                        {
                            // self.setUpMakeToast(msg: message ?? "")
                            
                            let Invoiceurl = response?.value(forKey: "Invoiceurl") as? String
                            let insuranceReports = response?.value(forKey: "insuranceReports") as? NSArray
                            
                            let mainS = UIStoryboard(name: "Main", bundle: nil)
                            let vc = mainS.instantiateViewController(withIdentifier: "OrderPlacedViewController") as! OrderPlacedViewController
                            vc.isOpen = true
                            vc.Invoiceurl = Invoiceurl ?? ""
                            vc.insuranceReports = insuranceReports as! [String]
                            self.navigationController?.pushViewController(vc, animated: false)
                        } else {
                            self.setUpMakeToast(msg: message ?? "")
                            self.btnPAy.isUserInteractionEnabled = true
                            
                            let controllers = self.navigationController?.viewControllers
                            for vc in controllers! {
                                if vc is InsuranceDetailVC {
                                    _ = self.navigationController?.popToViewController(vc as! InsuranceDetailVC, animated: true)
                                    
                                }
                            }
                        }
                        
                    } else {
                        self.setUpMakeToast(msg: message ?? "")
                        self.btnPAy.isUserInteractionEnabled = true
                        
                        let controllers = self.navigationController?.viewControllers
                        for vc in controllers! {
                            if vc is InsuranceDetailVC {
                                _ = self.navigationController?.popToViewController(vc as! InsuranceDetailVC, animated: true)
                                
                            }
                        }
                    }
                }
            } else {
                APIClient.sharedInstance.hideIndicator()
            }
        }
        
    }
}
