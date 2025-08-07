//
//  VIPaymentProcessVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 04/06/25.
//

import UIKit

class VIPaymentProcessVC: UIViewController {

    @IBOutlet weak var viewCarDetailsMain: UIView!
    @IBOutlet weak var viewBikeDetailsMain: UIView!
    @IBOutlet weak var lblPlanName: UILabel! {
        didSet {
            lblPlanName.text = AppManger.shared.dicGetPremium.vehiclePlan.planName ?? ""
        }
    }
    @IBOutlet weak var lblPlanType: UILabel!
    
    @IBOutlet weak var lblFinalPremium: UILabel! {
        didSet {
            lblFinalPremium.text = "\(AppManger.shared.dicGetPremium.idvAmount ?? 0)"
        }
    }
    
    @IBOutlet weak var tblViewAddOns: UITableView! {
        didSet {
            tblViewAddOns.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
            
            tblViewAddOns.delegate = self
            tblViewAddOns.dataSource = self
        }
    }
    @IBOutlet weak var heightTblView: NSLayoutConstraint!
    
    @IBOutlet weak var lblCarName: UILabel! {
        didSet {
            let companyName = AppManger.shared.vehicle_make
            let vehicleName = AppManger.shared.vehicle_model
            let enginSize = "\(AppManger.shared.engine_size)" + " " + "cc"
            
            lblCarName.text = companyName + " " + vehicleName + " " + "(\(enginSize))"
        }
    }
    @IBOutlet weak var lblCarNumber: UILabel! {
        didSet {
            let number = AppManger.shared.vehicle_no + " | " + AppManger.shared.model_year + " " + "registered"
            lblCarNumber.text = number
        }
    }
    
    @IBOutlet weak var lblBikeName: UILabel! {
        didSet {
            let companyName = AppManger.shared.vehicle_make
            let vehicleName = AppManger.shared.vehicle_model
            let enginSize = "\(AppManger.shared.engine_size)" + " " + "cc"
            
            lblBikeName.text = companyName + " " + vehicleName + " " + "(\(enginSize))"
        }
    }
    @IBOutlet weak var lblBikeNumber: UILabel! {
        didSet {
            let number = AppManger.shared.vehicle_no + " | " + AppManger.shared.model_year + " " + "registered"
            lblBikeNumber.text = number
        }
    }
    @IBOutlet weak var viewPaymentProsess: UIView! {
        didSet {
            viewPaymentProsess.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewCarDetailsMain.isHidden = AppManger.shared.isCarInsurance ? false : true
        viewBikeDetailsMain.isHidden = AppManger.shared.isCarInsurance ? true : false

        // Do any additional setup after loading the view.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey] {
                let newsize  = newvalue as! CGSize
                self.heightTblView.constant = newsize.height
            }
        }
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnPaySecurelyAction(_ sender: Any) {
        let vc = VIAddNewCardVC.instantiate("Vehicle") as! VIAddNewCardVC
        let home = UINavigationController(rootViewController: vc)
        home.navigationBar.isHidden = true
        home.modalPresentationStyle = .overFullScreen
        vc.delegateTap = self
        self.present(home, animated: false)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension VIPaymentProcessVC: didOnCallAPI {
    func oncallAPI(txn_id: String, txn_data: String) {
        AppManger.shared.txn_id = txn_id
        AppManger.shared.txn_data = txn_data
        
        myImageUploadRequest(imgKey: "")
    }
    
    // MARK: - calling API -
    func myImageUploadRequest(imgKey: String) {
        viewPaymentProsess.isHidden = false
//        APIClient.sharedInstance.showIndicator()
        
        let token = UserDefaults.standard.value(forKey: "token") as? String
        
        let myUrl = NSURL(string: BASE_URL + VEHICLE_INSURANCE);
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        
        let AppManger = AppManger.shared
        
        let vehicle_type = AppManger.vehicle_type + " " + "wheeler"
        let vehicle_no = AppManger.vehicle_no
        let vehicle_plan_id = "\(AppManger.vehicle_plan_id)"
        let vehicle_brand = "\(AppManger.vehicle_brand)"
        let vehicle_model = AppManger.vehicle_model
        let model_year = AppManger.model_year
        let engine_no = AppManger.engine_no
        let chassis_no = AppManger.chassis_no
        let engine_size = "\(AppManger.engine_size)"
        let vehicle_value = "\(AppManger.vehicle_value)"
        let base_premium = "\(AppManger.base_premium)"
        let agency_repair = "\(AppManger.agency_repair)"
        let total_premium = "\(AppManger.total_premium)"
        let name = AppManger.name
        let email = AppManger.email
        let dail_code = AppManger.dail_code
        let phone_no = AppManger.phone_no
        let dob = AppManger.dob.toDisplayDate()
        let policy_start_date = AppManger.policy_start_date.toDisplayDate()
        let txn_id = AppManger.txn_id
        let txn_data = AppManger.txn_data
        let duration = "\(AppManger.duration)"
        let color = AppManger.color
        let fuel_type = AppManger.fuel_type
        
        var params = [
            "vehicle_type":vehicle_type,
            "vehicle_no":vehicle_no,
            "vehicle_plan_id":vehicle_plan_id,
            "vehicle_brand":vehicle_brand,
            "vehicle_model":vehicle_model,
            "model_year":model_year,
            "engine_no":engine_no,
            "chassis_no":chassis_no,
            "engine_size":engine_size,
            "vehicle_value":vehicle_value,
            "base_premium":base_premium,
            "agency_repair":agency_repair,
            "total_premium":total_premium,
            "name":name,
            "email":email,
            "dail_code":dail_code,
            "phone_no":phone_no,
            "dob":dob,
            "policy_start_date":policy_start_date,
            "txn_id":txn_id,
            "txn_data":txn_data,
            "duration":duration,
            "color":color,
            "fuel_type":fuel_type
        ]
        
        for (index, obj) in AppManger.arrSelectAddOns.enumerated() {
            params["add_on[id][\(index)]"] = "\(obj.id ?? 0)"
            params["add_on[price][\(index)]"] = obj.price
        }
      
        print(params)
        
        let boundary = generateBoundaryString()
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = createBodyWithParameters(parameters: params, filePathKey: imgKey, boundary: boundary, imgKey: imgKey) as Data
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            self.viewPaymentProsess.isHidden = true
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
                    if let status = json["status"] as? Int
                    {
                        if status == 1
                        {
                            let data = json["data"] as? NSDictionary
                            let dicData = TIVehicleInsuranceData(fromDictionary: data!)
                            let message = json["message"] as? String ?? ""
                            print(message)
                            DispatchQueue.main.async {
                                let vc = VIPaymentSuccessVC.instantiate("Vehicle") as! VIPaymentSuccessVC
                                vc.modalPresentationStyle = .overFullScreen
                                vc.callAPI = false
                                vc.dicResponse = dicData
                                vc.delegateAction = self
                                self.present(vc, animated: true)
                            }
                        }
                        else
                        {
                            let message = json["message"] as? String ?? ""
                            print(message)
                            DispatchQueue.main.async {
                                self.view.makeToast(message)
                                let window = UIApplication.shared.windows
                                window.last?.makeToast(message)
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
        
        let filenameImageBOL = "image.jpg"
        let mimetypeImageBOL = "image/jpg"
        
        // Image files
        let fileFields = [
            "registration[front]",
            "registration[back]",
            "id_proof[front]",
            "id_proof[back]",
            "driving_license[front]",
            "driving_license[back]",
            "vehicle[media]"
        ]
        
        let uploads = AppManger.shared.arrAddAllPic
        
        for obj in uploads {
            let dfs = fileFields.filter { requiredKey in
                if obj.key == requiredKey {
                    
                    let imageData = obj.image.jpegData(compressionQuality: 0.5)
                    
                        body.appendString(string: "--\(boundary)\r\n")
                        body.appendString(string: "Content-Disposition: form-data; name=\"\(obj.key)\"; filename=\"\(filenameImageBOL)\"\r\n")
                        body.appendString(string: "Content-Type: \(mimetypeImageBOL)\r\n\r\n")
                        body.append(imageData! as Data)
                        body.appendString(string: "\r\n")
                        body.appendString(string: "--\(boundary)--\r\n")
                    return true
                }
                return false
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

extension VIPaymentProcessVC: didTapOnSuccess {
    func didTapOnTrackClaim() {
        
    }
    
    func didTapOnClose() {
        let vc = VehicleMyInsuranceVC.instantiate("Vehicle") as! VehicleMyInsuranceVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
}

//MARK: - tblView Delegate & DataSource
extension VIPaymentProcessVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblViewAddOns.dequeueReusableCell(withIdentifier: "VIAddOnsTblViewCell") as! VIAddOnsTblViewCell
        
        cell.imgAddOns.image = UIImage(named: "ic_check")
        
        return cell
    }
    
    
}
