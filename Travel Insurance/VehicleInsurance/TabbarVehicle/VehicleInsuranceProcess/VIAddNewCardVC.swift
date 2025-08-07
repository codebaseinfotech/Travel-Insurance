//
//  VIAddNewCardVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 05/06/25.
//

import UIKit
import SafariServices
import OPPWAMobile_MSA
import JMMaskTextField_Swift

protocol didOnCallAPI: AnyObject {
    func oncallAPI(txn_id: String, txn_data: String)
}

class VIAddNewCardVC: UIViewController, SFSafariViewControllerDelegate {

    @IBOutlet weak var txtCardNumber: JMMaskTextField!
    @IBOutlet weak var txtExpireDate: JMMaskTextField!
    @IBOutlet weak var txtCVV: JMMaskTextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnPay: UIButton!
    
    let provider = OPPPaymentProvider(mode: .live)
    var transaction: OPPTransaction?
    var safariVC: SFSafariViewController?

    var strCard = ""
    var iQDAmount = 0
    var transactionDetailsId = 0

    var delegateTap: didOnCallAPI?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.provider.threeDSEventListener = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.dismiss(animated: false)
    }
    @IBAction func btnCloseAction(_ sender: Any) {
        self.dismiss(animated: false)
    }
    @IBAction func btnSaveThisMethodAction(_ sender: Any) {
    }
    @IBAction func btnAddNewCard(_ sender: Any) {
        if txtCardNumber.text == ""
        {
            self.setUpMakeToast(msg: "Please enter Card Number")
        }
        else if !isValidCardNumber(txtCardNumber.text ?? "") {
            self.setUpMakeToast(msg: "Card number is invalid.")
        }
        else if txtName.text == ""
        {
            self.setUpMakeToast(msg: "Please enter Card holder name")
        }
        else if txtExpireDate.text == ""
        {
            self.setUpMakeToast(msg: "please enter date")
        }
        else if txtCVV.text == ""
        {
            self.setUpMakeToast(msg: "please enter CVV")
        }
        else
        {
            btnPay.isUserInteractionEnabled = false
            
            let cardNumber = txtCardNumber.text ?? ""
            let cardType = CardType.from(cardNumber: cardNumber)
            print("Card Type: \(cardType.rawValue)")
            strCard = cardType.rawValue
            callPaymentAPI()
        }
    }
    
    // MARK: - isValidCardNumber
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
    
    // MARK: - call API
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
                    self.btnPay.isUserInteractionEnabled = true
                }
            } else {
                APIClient.sharedInstance.hideIndicator()
                self.btnPay.isUserInteractionEnabled = true
            }
        }
    }
    
    // MARK: - Payment helpers
    
    func createTransaction(checkoutID: String) -> OPPTransaction? {
        
        let dateString = txtExpireDate.text ?? ""
        
        let componate = dateString.components(separatedBy: "/")
        
        let month = componate[0]
        let year = componate[1]
        
        do {
            let params = try OPPCardPaymentParams.init(checkoutID: checkoutID, paymentBrand: strCard, holder: self.txtName.text!, number: self.txtCardNumber.text!, expiryMonth: month, expiryYear: year, cvv: self.txtCVV.text!)
            
           // params.shopperResultURL = "msdk.demo.async://payment"
            params.shopperResultURL = "TravelInsurance://result"
            return OPPTransaction.init(paymentParams: params)
        } catch let error as NSError {
            btnPay.isUserInteractionEnabled = true
            APIClient.sharedInstance.hideIndicator()
            AppUtilites.showAlert(title: "", message: error.localizedDescription, cancelButtonTitle: "OK")
            return nil
        }
    }
    
    func handleTransactionSubmission(transaction: OPPTransaction?, error: Error?) {
        guard let transaction = transaction else {
            btnPay.isUserInteractionEnabled = true
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
            btnPay.isUserInteractionEnabled = true
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
    
    func requestPaymentStatus() {
        // You can either hard-code resourcePath or request checkout info to get the value from the server
        // * Hard-coding: "/v1/checkouts/" + checkoutID + "/payment"
        // * Requesting checkout info:
        
        guard let checkoutID = self.transaction?.paymentParams.checkoutID else {
            btnPay.isUserInteractionEnabled = true
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
                            
                            self.delegateTap?.oncallAPI(txn_id: id ?? "", txn_data: urlEncodedJson)
                            self.dismiss(animated: false)
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

}
// MARK: - OPPThreeDSEventListener methods

extension VIAddNewCardVC: OPPThreeDSEventListener {
    
    func onThreeDSChallengeRequired(completion: @escaping (UINavigationController) -> Void) {
        completion(self.navigationController!)
    }
    
    func onThreeDSConfigRequired(completion: @escaping (OPPThreeDSConfig) -> Void) {
        let config = OPPThreeDSConfig()
        config.appBundleID = "com.aciworldwide.MSDKDemo"
        completion(config)
    }
}
