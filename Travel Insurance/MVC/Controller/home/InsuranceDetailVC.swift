//
//  InsuranceDetailVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 06/02/24.
//

import UIKit
import DropDown

class InsuranceDetailVC: UIViewController {

    
    @IBOutlet weak var lblCurrecy: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!

    @IBOutlet weak var viewFTop: UIView!
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewPrice: UIView!
    
    @IBOutlet weak var lblPRice: UILabel!
    @IBOutlet weak var viewMakePay: UIView!
    
    
    @IBOutlet weak var ViewContry: UIView!
    @IBOutlet weak var contryCon: NSLayoutConstraint!
    
    @IBOutlet weak var paybleAmount: UILabel!
    
    @IBOutlet weak var viewAgentId: UIView!
    @IBOutlet weak var lblAgentId: UILabel!
    
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var viewCash: UIView!
    
    @IBOutlet weak var bottemCard: NSLayoutConstraint! // 10
    
    @IBOutlet weak var imgCard: UIImageView!
    @IBOutlet weak var imgCash: UIImageView!
    
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblMyCommistion: UILabel!
    
    @IBOutlet weak var viewMyCommistion: UIView!
    @IBOutlet weak var viewPaybleAmount: UIView!
    @IBOutlet weak var heightCardView: NSLayoutConstraint! // 30
    @IBOutlet weak var lblDiwanTax: UILabel!
    @IBOutlet weak var viewDiwanTax: UIView!
    
    @IBOutlet weak var lblTtitleNetTotal: UILabel!
    @IBOutlet weak var lblTitleDiwanTax: UILabel!
    @IBOutlet weak var lblNetAmountIQD: UILabel!
    
    
    var arrPInsurance = NSMutableArray()
    
    var email = ""
    var phoneNumber = ""
    var policySDate = ""
    var policyEDate = ""
    var numberDay = ""
    var nationality = ""
    var marital_status = ""
    var destination = ""
    var zone = ""
    var address = ""
    var gender = ""

    var pagCount = 0
    
    var optional_country_code = ""
    var optional_mobile_no = ""
    var residence_no = ""
    var residence_date = ""
    var residence_duration = ""
    var residence_reason = ""
    var border_entry = ""
    var visa_type = ""
    var visit_type = ""
    
    var selectedTraveller = 0

    var planid = ""
    
    var dicOrderData = TIFormListData()
    
    var isApiCall = false
    
    var FirstarrPInsurance = NSMutableArray()

    var dicPlanDetails = TIPlanDetailsResponse()
    
    let dropDownContry = DropDown()
    var arrContry: [ContryCodeConversionRate] = [ContryCodeConversionRate]()

    var strSelectPayment = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        let dicData = appDelegate?.dicCurrentUserData
//
//        lblAgentId.text = "#\(dicData?.agentCode ?? "")"
//        
//        if dicData?.roleId == 1 {
//            
//            viewAgentId.isHidden = true
//            viewCard.isHidden = true
//            viewCash.isHidden = true
//            heightCardView.constant = 0
//            bottemCard.constant = 0
//            
//            
//            viewMyCommistion.isHidden = true
//            viewPaybleAmount.isHidden = true
//        } else {
//            
//            viewAgentId.isHidden = false
//            
//            if dicData?.cashOption == "1" {
//                viewCash.isHidden = false
//                viewCard.isHidden = false
//                heightCardView.constant = 30
//                bottemCard.constant = 10
//            } else {
//                viewCash.isHidden = true
//                viewCard.isHidden = true
//                heightCardView.constant = 0
//                bottemCard.constant = 0
//            }
//            
//            viewMyCommistion.isHidden = false
//            viewPaybleAmount.isHidden = false
//        }
//        
//        strSelectPayment = 1
//        imgCard.image = UIImage(named: "S_Payment")
//        imgCash.image = UIImage(named: "Un_Payment")
//        
//        ViewContry.isHidden = true
//        contryCon.constant = 0
//        callGetAllConversionRateAPI()
//        
//        appDelegate?.isBackForm = false
//        
//        lblTitle.text = dicPlanDetails.planType ?? ""
//         
//        APIClient.sharedInstance.showIndicator()
//        
//        arrPInsuranceSaving = self.arrPInsurance
//        
//        
//        //viewTop.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 16, spread: 0)
//        viewFTop.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 16, spread: 0)
//        viewPrice.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 16, spread: 0)
//        
//        viewFTop.isHidden = false
//        
//        debugPrint(arrPInsurance)
//
//        myImageUploadRequest(imgKey: "")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let dicData = appDelegate?.dicCurrentUserData

        lblAgentId.text = "#\(dicData?.agentCode ?? "")"
        
        if dicData?.roleId == 1 {
            
            viewAgentId.isHidden = true
            viewCard.isHidden = true
            viewCash.isHidden = true
            heightCardView.constant = 0
            bottemCard.constant = 0
            
            
            viewMyCommistion.isHidden = true
            viewPaybleAmount.isHidden = true
        } else {
            
            viewAgentId.isHidden = false
            
            if dicData?.cashOption == "1" {
                viewCash.isHidden = false
                viewCard.isHidden = false
                heightCardView.constant = 30
                bottemCard.constant = 10
            } else {
                viewCash.isHidden = true
                viewCard.isHidden = true
                heightCardView.constant = 0
                bottemCard.constant = 0
            }
            
            viewMyCommistion.isHidden = false
            viewPaybleAmount.isHidden = false
        }
        
        strSelectPayment = 1
        imgCard.image = UIImage(named: "S_Payment")
        imgCash.image = UIImage(named: "Un_Payment")
        
        ViewContry.isHidden = true
        contryCon.constant = 0
        callGetAllConversionRateAPI()
        
        appDelegate?.isBackForm = false
        
        lblTitle.text = dicPlanDetails.planType ?? ""
        
        arrPInsuranceSaving = self.arrPInsurance
        
        //viewTop.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 16, spread: 0)
        viewFTop.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 16, spread: 0)
        viewPrice.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 16, spread: 0)
        
        viewFTop.isHidden = false
        
        debugPrint(arrPInsurance)

        myImageUploadRequest(imgKey: "")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedCard(_ sender: Any) {
        strSelectPayment = 1
        imgCard.image = UIImage(named: "S_Payment")
        imgCash.image = UIImage(named: "Un_Payment")
    }
    @IBAction func clickedCash(_ sender: Any) {
        strSelectPayment = 2
        imgCash.image = UIImage(named: "S_Payment")
        imgCard.image = UIImage(named: "Un_Payment")
    }
    
    
    @IBAction func clickecCurrneyc(_ sender: Any) {
        dropDownContry.show()
    }
    
    @IBAction func clickedBack(_ sender: Any) {
       // arrPInsuranceSaving = self.arrPInsurance
        
        appDelegate?.isBackForm = true
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickedMakePayment(_ sender: Any) {
        if strSelectPayment == 1 {
            
            let iQDAmount = Double(dicOrderData.order.iQDAmount ?? "") ?? 0
            
            let agentPrice = Double(dicOrderData.order.agentPrice ?? "") ?? 0
            let diwan_tax = Double(self.dicOrderData.order.diwan_tax ?? "") ?? 0.0
            let formattedString3 = String(format: "%.2f", diwan_tax)
            
            let net_premium = iQDAmount - agentPrice
            let newPaybleAmount = (net_premium) + (diwan_tax)

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaymentDoneVC") as! PaymentDoneVC
            vc.transactionDetailsId = dicOrderData.order.transactionDetailsId ?? 0
            vc.iQDAmount = Int(newPaybleAmount)
            vc.isModify = false
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else {
            callTransactionAPI()
            
        }
    }
    
    //MARK: - API CALL
    
    func setDropDownEmail()
    {
        
        let arrString = NSMutableArray()
        
        for (index,obj) in self.arrContry.enumerated()
        {
            arrString.add("\(self.countryFlag(self.arrContry[index].abbreviation ?? "").prefix(1))   \(self.arrContry[index].abbreviation ?? "")")
        }
        
        dropDownContry.dataSource = arrString as! [String]
        dropDownContry.anchorView = lblCurrecy
        dropDownContry.direction = .bottom
        
        dropDownContry.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.lblCurrecy.text = item
            
            for (indexz,obj) in self.arrContry.enumerated()
            {
                if indexz == index {
                    
                    self.lblCurrecy.text = "\(self.countryFlag(self.arrContry[index].abbreviation ?? "").prefix(1))   \(self.arrContry[index].abbreviation ?? "")"
                    
                    appDelegate?.objContryCodeConversionRate = obj
                    
                    self.myImageUploadRequest(imgKey: "")
                }
                
            }
           
        }
        
        dropDownContry.bottomOffset = CGPoint(x: 0, y: lblCurrecy.bounds.height)
        dropDownContry.topOffset = CGPoint(x: 0, y: -lblCurrecy.bounds.height)
        dropDownContry.dismissMode = .onTap
        dropDownContry.textColor = .black
        dropDownContry.backgroundColor = .white
        dropDownContry.selectionBackgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)

        dropDownContry.reloadAllComponents()
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
    
    func callGetAllConversionRateAPI()
    {
      //  APIClient.sharedInstance.showIndicator()
        
        let parm = ["":""]
        
        print(parm)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(ALL_CONVERSION_RATE, parameters: parm) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
              //  APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200
                {
                    if status == 1
                    {
                        self.arrContry.removeAll()
                        
                        if let arrData = response?.value(forKey: "conversion_rate") as? NSArray
                        {
                            for objData in arrData
                            {
                                let dicData = ContryCodeConversionRate(fromDictionary: objData as! NSDictionary)
                                self.arrContry.append(dicData)
                                
                                if self.arrContry.count > 0 {
                                    self.lblCurrecy.text = "\(self.countryFlag(appDelegate?.objContryCodeConversionRate.abbreviation ?? "").prefix(1))   \(appDelegate?.objContryCodeConversionRate.abbreviation ?? "")"
                                }
                                
                                self.setDropDownEmail()
                                
                            }
                        }
                    }
                    else
                    {
                        APIClient.sharedInstance.hideIndicator()
                    }
                }
                else
                {
                    APIClient.sharedInstance.hideIndicator()
                }
            }
            else
            {
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
   
    func callTransactionAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let transaction_details_id = dicOrderData.order.transactionDetailsId ?? 0
        let currencySymbol = dicOrderData.order.currencySymbol ?? ""
        
        let parm = ["transaction_details_id":"\(transaction_details_id)","order_status":"success","txn_id":"cash","currency":"IQD","card_type":"","payment_method":"2","currencySymbol":currencySymbol]
        
        print(parm)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(ORDER_INSURANCE + "\(transaction_details_id)", parameters: parm) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
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
                    }
                    
                }
            } else {
                APIClient.sharedInstance.hideIndicator()
            }
        }
        
    }
    
    func myImageUploadRequest(imgKey: String) {
        
        APIClient.sharedInstance.showIndicator()
        
        let token = UserDefaults.standard.value(forKey: "token") as? String

        let myUrl = NSURL(string: BASE_URL + PURCHASE_INSURANCE);
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
                
        let planid = self.planid
        
        let email = self.email
        
        let nationality = self.nationality
        
        let policy_start_date = self.policySDate
        
        let policy_end_date = self.policyEDate
        
        let time_period = self.numberDay
        
        let destination = self.destination
        
        let marital_status = self.marital_status
        
        let address = self.address
        
        let gender = self.gender

        
        let zone = self.zone
        
        let components = phoneNumber.components(separatedBy: " ")
        
        let strCountryCode = components.first ?? ""
        
        let mobile_number = components.last ?? ""
        
        let optional_country_code = self.optional_country_code
        let optional_mobile_no = self.optional_mobile_no
        let residence_no = self.residence_no
        let residence_date = self.residence_date
        let residence_duration = self.residence_duration
        let residence_reason = self.residence_reason
        let border_entry = self.border_entry
        let visa_type = self.visa_type
        let visit_type = self.visit_type
           
        var params = ["planid":planid,"email":email,"mobile_number":mobile_number,"policy_start_date":policy_start_date,"policy_end_date":policy_end_date,"time_period":time_period,"destination":destination,"address":address,"zone":zone,"currency_icon":"\(appDelegate?.objContryCodeConversionRate.abbreviation ?? "")","conversion_rate": "\(appDelegate?.objContryCodeConversionRate.conversionRate ?? 0.0)","country_code":strCountryCode,"optional_country_code": optional_country_code,"optional_mobile_no":optional_mobile_no,"residence_no":residence_no,"residence_date":residence_date,"residence_duration":residence_duration,"residence_reason":residence_reason,"border_entry":border_entry,"visa_type":visa_type,"visit_type":visit_type]
                
        for (index, obj) in arrPInsurance.enumerated()
        {
            let dicDataIn = obj as? NSMutableDictionary
            
            let full_name = dicDataIn?.value(forKey: "full_name") as? String
            let date_of_birth = dicDataIn?.value(forKey: "date_of_birth") as? String
            let gender = dicDataIn?.value(forKey: "gender") as? String
            let passport_number = dicDataIn?.value(forKey: "passport_number") as? String
            let nationality = dicDataIn?.value(forKey: "nationality") as? String
            let passport_copy = dicDataIn?.value(forKey: "passport_copy") as? Data
            let isPDF = dicDataIn?.value(forKey: "isPDF") as? Bool
            
            params["full_name[\(index)]"] = full_name
            params["date_of_birth[\(index)]"] = date_of_birth
            params["gender[\(index)]"] = gender
            params["passport_number[\(index)]"] = passport_number
            params["nationality[\(index)]"] = nationality

        }
        
        print(params)

        let boundary = generateBoundaryString()
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
       
        
        request.httpBody = createBodyWithParameters(parameters: params, filePathKey: imgKey, boundary: boundary, imgKey: imgKey) as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
                        
            if error != nil {
                print("error=\(error!)")
                return
            }
            
            // print reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("response data = \(responseString!)")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                APIClient.sharedInstance.hideIndicator()
                self.viewPrice.isHidden = false
            }
            
            do{
                
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    
                    // try to read out a string array
                    if let success = json["success"] as? Bool
                    {
                        if success == true
                        {
                            if let dic = json["data"] as? NSDictionary
                            {                                
                                DispatchQueue.main.async {
                                    self.viewPrice.isHidden = false
                                    let dicData = TIFormListData(fromDictionary: dic)
                                    self.dicOrderData = dicData
                                    
                                    if self.dicPlanDetails.planTypeCategory.type.contains("Inbound-medical") == true {
                                        self.viewDiwanTax.isHidden = true
                                        
                                        self.lblTitleDiwanTax.text = "Diwan Tax (\(dicData.order.diwan_tax_percent ?? "")% in IQD)"
                                    //    self.lblTtitleNetTotal.text = "Net Premium Amount (in \(dicData.order.currency ?? ""))"
                                        self.lblTtitleNetTotal.text = "Net Premium Amount:"
                                        
                                        let diwan_tax = Double(dicData.order.diwan_tax ?? "") ?? 0.0
                                        
                                        let formattedString = String(format: "%.2f", diwan_tax)
                                        
                                        self.lblDiwanTax.text = "IQD \(formattedString) (\(dicData.order.diwan_tax_percent ?? "")%)"
                                    } else {
                                        self.viewDiwanTax.isHidden = true
                                    }
                                    
                                    self.viewDiwanTax.isHidden = true
                                    
                                    self.isApiCall = true
                                    
                                    self.tblView.dataSource = self
                                    self.tblView.delegate = self
                                    
                                    let amount = Double(dicData.order.iQDAmount ?? "") ?? 0.0
                                    let diwan_tax = Double(self.dicOrderData.order.diwan_tax ?? "") ?? 0.0
                                    let formattedString3 = String(format: "%.2f", diwan_tax)
                                    
                                    let formattedStringIQDAmount = String(format: "%.2f", amount)
                                    self.lblNetAmountIQD.text = "IQD \(formattedStringIQDAmount)"
                                    
                                    let strAddTextAmount = amount + diwan_tax
                                    self.lblTotalAmount.text = "IQD \(strAddTextAmount)"
                                    
                                    let usdAmount = Double(dicData.order.usdAmount ?? "") ?? 0.0
                                    
                                    let formattedString = String(format: "%.2f", usdAmount)
                                    self.lblPRice.text = "\(dicData.order.currency ?? "") \(formattedString)"
                                    
                                    let agentCommision = Double(self.dicOrderData.order.agentCommision ?? "")
                                    
                                    let agentPrice = Double(self.dicOrderData.order.agentPrice ?? "") ?? 0.0
                                    
                                    let formattedString1 = String(format: "%.2f", agentPrice)
                                    self.lblMyCommistion.text = "IQD \(formattedString1) (\(agentCommision ?? 0.0)%)"
                                    
                                    let paybleAmount = (amount) - (agentPrice)
                                    let newPaybleAmount = (paybleAmount) + (diwan_tax)
                                    
                                    self.paybleAmount.text = "IQD \(newPaybleAmount)"
 
                                    self.lblPRice.text = "\(appDelegate?.objContryCodeConversionRate.abbreviation ?? "") \(self.dicOrderData.order.totalPrice ?? "")"
                                    self.viewMakePay.isHidden = false
                                    
                                    dicData.order.userinsurancedata = dicData.order.userinsurancedata.reversed()
                                    
                                    self.tblView.reloadData()
                                    
                                    
                                }
                                
                            }
                        }
                        
                    }
                }
                
            }catch{
                
            }
            
        }
        
        task.resume()
    }
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, boundary: String, imgKey: String) -> NSData {
        
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let filename = "\(imgKey).jpg"
        let mimetype = "image/jpeg"
        
        let filenamePdfBOL = "application.pdf"
        let mimetypePdfBOL = "application/pdf"

        for (index,objImg) in arrPInsurance.enumerated()
        {
            let dicDataIn = objImg as? NSMutableDictionary
            
            let passport_copy = dicDataIn?.value(forKey: "passport_copy") as? Data
            let isPDF = dicDataIn?.value(forKey: "isPDF") as? Bool
            
            if isPDF == false
            {
                let imageToUpload = UIImage(data: passport_copy!)
                
                let imageData = imageToUpload?.jpegData(compressionQuality: 0.3)
                
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"passport_copy[\(index)]\"; filename=\"\(filename)\"\r\n")
                body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
                body.append(imageData! as Data)
                body.appendString(string: "\r\n")
                body.appendString(string: "--\(boundary)--\r\n")
            }
            else
            {
                
                let imageData = passport_copy
                
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"passport_copy[\(index)]\"; filename=\"\(filenamePdfBOL)\"\r\n")
                body.appendString(string: "Content-Type: \(mimetypePdfBOL)\r\n\r\n")
                body.append(imageData as! Data)
                body.appendString(string: "\r\n")
                body.appendString(string: "--\(boundary)--\r\n")
            }
           
        }
       
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func randomString(of length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var s = ""
        for _ in 0 ..< length {
            s.append(letters.randomElement()!)
        }
        return s
    }

}

extension InsuranceDetailVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        if isApiCall == true
        {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isApiCall == true{
            return self.dicOrderData.order.userinsurancedata.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0
        {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "FirstPersonCell") as! FirstPersonCell
            
            cell.viewMain.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1), alpha: 1, x: 0, y: 0, blur: 17, spread: 0)
            
            let dicData = self.dicOrderData.order.userinsurancedata[0]
            
            cell.lblPerson.text = "Traveler 1"
            
            cell.lblFName.text = dicData.fullName ?? ""
            cell.lblDestination.text = dicData.destination ?? ""
            // cell.lblMS.text = dicData.maritalStatus ?? ""
            cell.lblPassportIf.text = dicData.passportNumber ?? ""
            //     cell.lblGender.text = dicData.gender ?? ""
            cell.lblNumber.text = "\(dicData.countryCode ?? "") \(dicData.mobileNumber ?? "")"
            cell.lblNoD.text = "\(self.dicOrderData.order.timePeriod ?? "") days"
            cell.lblNationality.text = dicData.nationality ?? ""
            
            let amount = Double(dicData.convertedAmount ?? "") ?? 0.0
            
            let formattedString = String(format: "%.2f", amount)
            cell.lblPrice.text = "\(dicData.currency ?? "") \(formattedString)"
            
            cell.lblDOB.text = dicData.dateOfBirth ?? ""
            cell.lblDOG.text = self.dicOrderData.order.policyStartDate ?? ""
            cell.lblEOG.text = self.dicOrderData.order.policyEndDate ?? ""
            cell.lblZone.text = self.dicOrderData.order.zone ?? ""
            cell.lblEmail.text = dicData.email ?? ""
            
            if dicPlanDetails.planTypeCategory.name.uppercased().contains("(VISA)") == true {
                
                if dicData.visaType != "" {
                    
                    cell.lblVisaType.text = dicData.visaType ?? ""
                    cell.viewVisaType.isHidden = false
                } else {
                    cell.viewVisaType.isHidden = true
                }
                
                if dicData.visitType != "" {
                    
                    cell.lblVisitType.text = dicData.visitType ?? ""
                    cell.viewVisitType.isHidden = false
                } else {
                    cell.viewVisitType.isHidden = true
                }
                
                cell.viewRReason.isHidden = true
                cell.viewRDuration.isHidden = true
                cell.viewRDate.isHidden = true
                cell.viewRNo.isHidden = true
            } else if dicPlanDetails.planTypeCategory.name.uppercased().contains("(RESIDENTS)") == true {
                
                if dicData.residenceNo != "" {
                    
                    cell.viewRNo.isHidden = false
                    cell.lblRNo.text = dicData.residenceNo ?? ""
                } else {
                    cell.viewRNo.isHidden = true
                }
                
                if dicData.residenceDate != "" {
                    
                    cell.viewRDate.isHidden = false
                    cell.lblRDate.text = dicData.residenceDate ?? ""
                } else {
                    cell.viewRDate.isHidden = true
                }
                
                if dicData.residenceDuration != "" {
                    
                    cell.lblRDuration.text = dicData.residenceDuration ?? ""
                    cell.viewRDuration.isHidden = false
                } else {
                    cell.viewRDuration.isHidden = true
                }
                
                if dicData.residenceReason != "" {
                    
                    cell.lblRReason.text = dicData.residenceReason ?? ""
                    cell.viewRReason.isHidden = false
                } else {
                    cell.viewRReason.isHidden = true
                }
                
                cell.viewVisitType.isHidden = true
                cell.viewVisaType.isHidden = true
                
            } else {
                cell.viewRReason.isHidden = true
                cell.viewRDuration.isHidden = true
                cell.viewRDate.isHidden = true
                cell.viewRNo.isHidden = true
                cell.viewVisitType.isHidden = true
                cell.viewVisaType.isHidden = true
            }
            
            if dicData.borderEntry != "" {
                
                cell.lblBoaderEntry.text = dicData.borderEntry ?? ""
                cell.viewBoraderEntry.isHidden = false
            } else {
                cell.viewBoraderEntry.isHidden = true
            }
            if dicData.passportCopy.contains(".pdf") == true
            {
                cell.imgPassport.isUserInteractionEnabled = true
                cell.imgPassport.image = UIImage(named: "pdf")
                
            }
            else
            {
                var media_link_url = dicData.passportCopy ?? ""
                media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                cell.imgPassport.sd_setImage(with: URL.init(string: media_link_url), placeholderImage: UIImage(named: "app_logo"), options: [], completed: nil)
                
            }
            
            
            return cell
        }
        else
        {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "SecondPersonCell") as! SecondPersonCell
            
            cell.viewMain.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1), alpha: 1, x: 0, y: 0, blur: 17, spread: 0)
            
            let dicData = self.dicOrderData.order.userinsurancedata[indexPath.row]
            
            cell.lblPerson.text = "Traveler \(indexPath.row+1)"
            
            cell.lblFName.text = dicData.fullName ?? ""
            cell.lblDOB.text = dicData.dateOfBirth ?? ""
            // cell.lblGender.text = dicData.gender ?? ""
            cell.lblPassportIf.text = dicData.passportNumber ?? ""
            cell.lblNationality.text = dicData.nationality ?? ""
            
            let convertedAmount = Double(dicData.convertedAmount ?? "") ?? 0.0
            
            let formattedString = String(format: "%.2f", convertedAmount)
            cell.lblPrice.text = "\(dicData.currency ?? "") \(formattedString)"
            
            if dicData.passportCopy.contains(".pdf") == true
            {
                cell.imgPassport.isUserInteractionEnabled = true
                cell.imgPassport.image = UIImage(named: "pdf")
                
            }
            else
            {
                var media_link_url = dicData.passportCopy ?? ""
                media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                cell.imgPassport.sd_setImage(with: URL.init(string: media_link_url), placeholderImage: UIImage(named: "app_logo"), options: [], completed: nil)
                
            }
            
            return cell
        }
        
    }
    
    @objc func clickedViewReport(_ sender: UIButton)
    {
        let order_id = base64Encode("\(self.dicOrderData.order.userinsurancedata[0].orderId ?? "")")
        let insurance_id = base64Encode("\(self.dicOrderData.order.userinsurancedata[sender.tag].insuranceId ?? 0)")
        
        print("ORDER_ID:\(order_id ?? "")\n\(insurance_id ?? "")")

        
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "WebVC") as! WebVC
        vc.strTitle = "Insurance Detail"
        vc.strUrl = "https://techmavesoftwaredev.com/Hamraa-insurance/insurance-report/\(order_id ?? "")/\(insurance_id ?? "")"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func base64Encode(_ input: String) -> String? {
        if let inputData = input.data(using: .utf8) {
            return inputData.base64EncodedString()
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0 
    }
    
    
}

class FirstPersonCell: UITableViewCell
{
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var lblPerson: UILabel!
    @IBOutlet weak var lblFName: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblMS: UILabel!
    @IBOutlet weak var lblPassportIf: UILabel!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var lblDOG: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblEOG: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblNoD: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblNationality: UILabel!
    @IBOutlet weak var lblZone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var imgPassport: UIImageView!
    @IBOutlet weak var btnViewReport: UIButton!
    
    @IBOutlet weak var viewIR: UIView!
    
    @IBOutlet weak var lblPNo: UILabel!
    
    @IBOutlet weak var viewBoraderEntry: UIView!
    @IBOutlet weak var viewVisitType: UIView!
    @IBOutlet weak var viewVisaType: UIView!
    @IBOutlet weak var viewRNo: UIView!
    @IBOutlet weak var viewRDate: UIView!
    @IBOutlet weak var viewRDuration: UIView!
    @IBOutlet weak var viewRReason: UIView!
    
    @IBOutlet weak var lblBoaderEntry: UILabel!
    @IBOutlet weak var lblVisitType: UILabel!
    @IBOutlet weak var lblVisaType: UILabel!
    @IBOutlet weak var lblRNo: UILabel!
    @IBOutlet weak var lblRDate: UILabel!
    @IBOutlet weak var lblRDuration: UILabel!
    @IBOutlet weak var lblRReason: UILabel!
    

}

class SecondPersonCell: UITableViewCell
{
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var lblPerson: UILabel!
    @IBOutlet weak var lblFName: UILabel!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblPassportIf: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSPrice: UILabel!
    @IBOutlet weak var imgPassport: UIImageView!
    @IBOutlet weak var btnViewReport: UIButton!
    
    @IBOutlet weak var viewIr: UIView!
    
    @IBOutlet weak var lblPN: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPaymentType: UILabel!
    @IBOutlet weak var lblNationality: UILabel!

}
