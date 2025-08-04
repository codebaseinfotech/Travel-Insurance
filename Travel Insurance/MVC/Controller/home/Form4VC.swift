//
//  Form4VC.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 19/01/24.
//

import UIKit

class Form4VC: UIViewController {
    
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var imgTrue: UIImageView!
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewFTop: UIView!
    @IBOutlet weak var viewMakePas: UIView!
    
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
    var pagCount = 0

    var planid = ""
    
    var isAgree = false
    
    var dicOrderData = TIFormListData()
    
    var isApiCall = false
    
    var dicPlanDetails = TIPlanDetailsResponse()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text = dicPlanDetails.planType ?? ""
        
        if let swiftArray = self.arrPInsurance as? [Any] {
            // Reverse the Swift array
            let reversedArray = Array(swiftArray.reversed())

            // Convert the reversed array back to an NSMutableArray if needed
            arrPInsurance = NSMutableArray(array: reversedArray)

         } else {
            print("Failed to convert NSMutableArray to Swift array.")
        }
        
        tblView.dataSource = self
        tblView.delegate = self
        
        viewTop.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 16, spread: 0)
        viewFTop.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 16, spread: 0)
        
        if pagCount == 1
        {
            viewFTop.isHidden = false
            viewTop.isHidden = true
        }
        else
        {
            viewTop.isHidden = false
            viewFTop.isHidden = true
        }
        
        myImageUploadRequest(imgKey: "")
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clikcedNext(_ sender: Any) {
        callOrderInAPI(id: self.dicOrderData.order.transactionDetailsId ?? 0)
    }
    
    @IBAction func clikcedTrue(_ sender: Any) {
        if isAgree == false
        {
            isAgree = true
            imgTrue.image = UIImage(named: "B_T")
            
        }
        else
        {
            imgTrue.image = UIImage(named:"F_T")
            isAgree = false
        }
        
    }
    
    //MARK: - API CALL
    
    func callOrderInAPI(id: Int)
    {
        APIClient.sharedInstance.showIndicator()
        
        let parm = ["":""]
        
        print(parm)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(ORDER_INSURANCE + "\(id)", parameters: [:]) { response, error, statusCode in
            
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
                        self.setUpMakeToast(msg: message ?? "")
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OrderPlacedViewController") as! OrderPlacedViewController
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
        
        let mobile_number = self.phoneNumber
        
        let nationality = self.nationality
        
        let policy_start_date = self.policySDate
        
        let policy_end_date = self.policyEDate
        
        let time_period = self.numberDay
        
        let destination = self.destination
        
        let marital_status = self.marital_status
        
        let address = self.address
        
        let zone = self.zone
        
        var params = ["planid":planid,"email":email,"mobile_number":mobile_number,"nationality":nationality,"policy_start_date":policy_start_date,"policy_end_date":policy_end_date,"time_period":time_period,"destination":destination,"marital_status":marital_status,"address":address,"zone":zone]
        
        for (index, obj) in arrPInsurance.enumerated()
        {
            let dicDataIn = obj as? NSMutableDictionary
            
            let full_name = dicDataIn?.value(forKey: "full_name") as? String
            let date_of_birth = dicDataIn?.value(forKey: "date_of_birth") as? String
            let gender = dicDataIn?.value(forKey: "gender") as? String
            let passport_number = dicDataIn?.value(forKey: "passport_number") as? String
            let passport_copy = dicDataIn?.value(forKey: "passport_copy") as? Data
            let isPDF = dicDataIn?.value(forKey: "isPDF") as? Bool
            
            params["full_name[\(index)]"] = full_name
            params["date_of_birth[\(index)]"] = date_of_birth
            params["gender[\(index)]"] = gender
            params["passport_number[\(index)]"] = passport_number
        }
        
        print(params)

        let boundary = generateBoundaryString()
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = createBodyWithParameters(parameters: params, filePathKey: imgKey, boundary: boundary, imgKey: imgKey) as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            APIClient.sharedInstance.hideIndicator()
            
            if error != nil {
                print("error=\(error!)")
                return
            }
            
            // print reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("response data = \(responseString!)")
            
            do{
                
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    
                    // try to read out a string array
                    if let success = json["success"] as? Bool
                    {
                        if success == true
                        {
                            
                            if let dic = json["data"] as? NSDictionary
                            {
                                let dicData = TIFormListData(fromDictionary: dic)
                                self.dicOrderData = dicData
                            }
                        }
                        self.isApiCall = true
                        
                        DispatchQueue.main.async {
                            self.tblView.reloadData()
                            self.viewMakePas.isHidden = false
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
            
            let imageData = passport_copy
            
            if isPDF == false
            {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"passport_copy[\(index)]\"; filename=\"\(filename)\"\r\n")
                body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
                body.append(imageData! as Data)
                body.appendString(string: "\r\n")
                body.appendString(string: "--\(boundary)--\r\n")
            }
            else
            {
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

extension Form4VC: UITableViewDelegate,UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isApiCall == true{
            return self.dicOrderData.order.userinsurancedata.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  indexPath.section == 0
        {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "FormDetailsCell") as! FormDetailsCell
            
            cell.viewMain.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1), alpha: 1, x: 0, y: 0, blur: 17, spread: 0)
            
            let dicData = self.dicOrderData.order.userinsurancedata[indexPath.section]
            
            cell.lblFullName.text = dicData.fullName ?? ""
            cell.lblDestination.text = dicData.destination ?? ""
            cell.loblMarital.text = dicData.maritalStatus ?? ""
            cell.lblPId.text = dicData.passportNumber ?? ""
            cell.lblGender.text = dicData.gender ?? ""
            cell.lblNumber.text = dicData.mobileNumber ?? ""
            cell.lblMarch.text = "\(self.dicOrderData.order.timePeriod ?? "") days"
            cell.lblNatioalty.text = dicData.nationality ?? ""
            cell.lblPrice.text = "\(appDelegate?.objContryCodeConversionRate.abbreviation ?? "") \(dicData.price ?? 0)"
            cell.lblDOB.text = dicData.dateOfBirth ?? ""
            cell.lblDate.text = self.dicOrderData.order.policyStartDate ?? ""
            cell.lblExpire.text = self.dicOrderData.order.policyEndDate ?? ""
            
            var media_link_url = dicData.passportCopy ?? ""
            media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            cell.imgP.sd_setImage(with: URL.init(string: media_link_url), placeholderImage: UIImage(named: "app_logo"), options: [], completed: nil)
            
            return cell
        }
        else
        {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "FormSecCell") as! FormSecCell
            
            cell.viewMain.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1), alpha: 1, x: 0, y: 0, blur: 17, spread: 0)
            
            let dicData = self.dicOrderData.order.userinsurancedata[indexPath.section]
            
            cell.lblFullN.text = dicData.fullName ?? ""
            cell.lblDob.text = dicData.dateOfBirth ?? ""
            cell.lblGendar.text = dicData.gender ?? ""
            cell.lblPassportId.text = dicData.passportNumber ?? ""
            cell.lblPriceN.text = "\(appDelegate?.objContryCodeConversionRate.abbreviation ?? "") \(dicData.price ?? 0)"
            
            var media_link_url = dicData.passportCopy ?? ""
            media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            cell.imgPassport.sd_setImage(with: URL.init(string: media_link_url), placeholderImage: UIImage(named: "app_logo"), options: [], completed: nil)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return UITableView.automaticDimension
        }
        else
        {
            return 229
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("headerView", owner: self, options: [:])?.first as! headerView
        
        headerView.lblPerson.text = "Traveler \(section+1)"
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    
}

class FormDetailsCell : UITableViewCell {
    
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var loblMarital: UILabel!
    @IBOutlet weak var lblPId: UILabel!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var lblExpire: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblMarch: UILabel!
    @IBOutlet weak var lblPolicy: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblNatioalty: UILabel!
    @IBOutlet weak var imgP: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblAddres: UILabel!
    
    @IBOutlet weak var btnViewReport: UIButton!

}

class FormSecCell: UITableViewCell {
    
    @IBOutlet weak var lblFullN: UILabel!
    @IBOutlet weak var lblPriceN: UILabel!
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lblGendar: UILabel!
    @IBOutlet weak var lblPassportId: UILabel!
    @IBOutlet weak var imgPassport: UIImageView!
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var btnViewReport: UIButton!

}

extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
