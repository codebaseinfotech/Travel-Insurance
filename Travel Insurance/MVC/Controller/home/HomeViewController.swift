//
//  HomeViewController.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 30/10/23.
//

import UIKit
import SDWebImage
import DropDown

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIApplicationDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblview: UITableView!
    
    @IBOutlet weak var viewTabbar: UIView!
    @IBOutlet weak var uiviewL: UIView!
    
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var loginCon: NSLayoutConstraint!
    
    @IBOutlet weak var viewNoti: UIView!
    @IBOutlet weak var notICon: NSLayoutConstraint!
    @IBOutlet weak var lblContry: UILabel!
    
    @IBOutlet weak var viewContry: UIView!
    @IBOutlet weak var contryCon: NSLayoutConstraint!
    
    @IBOutlet weak var ViewNotiCount: UIView!
    @IBOutlet weak var lblNotiCount: UILabel!
    
    var dicCurrentUserData = TIUserLoginResponse()
    
    var arrPlanList: [TIplansResponse] = [TIplansResponse]()
    var arrSearchPlanList: [TIplansResponse] = [TIplansResponse]()
    
    let dropDownContry = DropDown()
    var arrContry: [ContryCodeConversionRate] = [ContryCodeConversionRate]()
    
    var isSearch = false
    
    var checkoutProvider: OPPCheckoutProvider?
    var transaction: OPPTransaction?
    var isLive = false
    var checkout_id = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ViewNotiCount.layer.cornerRadius = ViewNotiCount.frame.height/2
 
        let token = UserDefaults.standard.value(forKey: "token") as? String
        
        print("userToken:-\(token ?? "")")

        appDelegate?.isBackForm = false
        viewTabbar.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.08), alpha: 1, x: 0, y: 0, blur: 18, spread: 0)
        tblview.dataSource = self
        tblview.delegate = self
            
        //all functio call
        
        callAllPlanAPI()
      
        txtSearch.delegate = self
        txtSearch.addTarget(self, action: #selector(searchWorkersAsPerText(_:)), for: .editingChanged)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedInBound(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "HomeTopPopVC") as! HomeTopPopVC
        vc.modalPresentationStyle = .overFullScreen
        vc.strOpen = "In Bound"
        self.present(vc, animated: false)
    }
    @IBAction func clickedOutBound(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "HomeTopPopVC") as! HomeTopPopVC
        vc.modalPresentationStyle = .overFullScreen
        vc.strOpen = "Out Bound"
        self.present(vc, animated: false)
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        appDelegate?.setUpHomeVehicle()
    }
    
    
    @objc func searchWorkersAsPerText(_ textfield:UITextField) {
        
        if textfield.text == ""
        {
            isSearch = false
            callAllPlanAPI()
        }
        else
        {
            isSearch = true
            callSearchAllPlanAPI(plan_type: textfield.text ?? "")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        callNotiCountAPI()
        
        callGetAllConversionRateAPI()
        
        if let isUserLogin = UserDefaults.standard.value(forKey: "isUserLogin") as? Bool
        {
            if isUserLogin == true
            {
                //Show viewContry
                viewContry.isHidden = false
                contryCon.constant = 100
                //Show notification
                viewNoti.isHidden = false
                notICon.constant = 36
                // viewloginhide
                uiviewL.isHidden = true
                loginCon.constant = 0
            }
            else
            {
                //hide viewContry
                viewContry.isHidden = true
                contryCon.constant = 0
                //hide notification
                viewNoti.isHidden = true
                notICon.constant = 0
                // viewloginShow
                uiviewL.isHidden = false
                loginCon.constant = 76
            }
        }
        else
        {
            //hide viewContry
            viewContry.isHidden = true
            contryCon.constant = 0
            //hide notification
            viewNoti.isHidden = true
            notICon.constant = 0
            // viewloginShow
            uiviewL.isHidden = false
            loginCon.constant = 76
        }
        
    }
    
    //MARK: - callNotiCountAPI
    func callNotiCountAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let parm = ["":""]
        
        print(parm)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(NOTIFICATIONS_COUNT, parameters: [:]) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                let NotificationCOunt = response?.value(forKey: "NotificationCOunt") as? Int

                if statusCode == 200
                {
                    if status == 1 {
                       // self.ViewNotiCount.isHidden = false
                        self.lblNotiCount.text = "\(NotificationCOunt ?? 0)"
                    }
                    else
                    {
                       // self.ViewNotiCount.isHidden = true
                        self.lblNotiCount.text = "0"
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
    
    //MARK: - API CALL
    
    func callAllPlanAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let parm = ["":""]
        
        print(parm)
        
        APIClient.sharedInstance.MakeAPICallWithoutAuthHeaderGet(ALL_PLAN_LIST, parameters: [:]) { response, error, statusCode in
            
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
                        // self.setUpMakeToast(msg: message ?? "")
                        self.arrPlanList.removeAll()
                        if let arrData = response?.value(forKey: "response") as? NSArray
                        {
                            for objData in arrData
                            {
                                let dicData = TIplansResponse(fromDictionary: objData as! NSDictionary)
                                self.arrPlanList.append(dicData)
                            }
                        }
                        
                        if self.arrPlanList.count > 0
                        {
                            self.lblNoData.isHidden = true
                        }
                        else
                        {
                            self.lblNoData.isHidden = false
                        }
                        self.tblview.reloadData()
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
        APIClient.sharedInstance.showIndicator()
        
        let parm = ["":""]
        
        print(parm)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(ALL_CONVERSION_RATE, parameters: parm) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
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
                                    self.lblContry.text = "\(self.countryFlag(self.arrContry[0].abbreviation ?? "").prefix(1))   \(self.arrContry[0].abbreviation ?? "")"
                                    
                                    if appDelegate?.objContryCodeConversionRate.abbreviation == nil
                                    {
                                        appDelegate?.objContryCodeConversionRate = self.arrContry[0]
                                    }
                                    else
                                    {
                                        self.lblContry.text = "\(self.countryFlag(appDelegate?.objContryCodeConversionRate.abbreviation ?? "").prefix(1))   \(appDelegate?.objContryCodeConversionRate.abbreviation ?? "")"
                                    }
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
    
    func setDropDownEmail()
    {
        
        let arrString = NSMutableArray()
        
        for (index,obj) in self.arrContry.enumerated()
        {
            arrString.add("\(self.countryFlag(self.arrContry[index].abbreviation ?? "").prefix(1))   \(self.arrContry[index].abbreviation ?? "")")
        }
        
        dropDownContry.dataSource = arrString as! [String]
        dropDownContry.anchorView = lblContry
        dropDownContry.direction = .bottom
        
        dropDownContry.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.lblContry.text = item
            
            for (indexz,obj) in self.arrContry.enumerated()
            {
                if indexz == index {
                    
                    self.lblContry.text = "\(self.countryFlag(self.arrContry[index].abbreviation ?? "").prefix(1))   \(self.arrContry[index].abbreviation ?? "")"
                    
                    appDelegate?.objContryCodeConversionRate = obj
                }
                
            }
           
        }
        
        dropDownContry.bottomOffset = CGPoint(x: 0, y: lblContry.bounds.height)
        dropDownContry.topOffset = CGPoint(x: 0, y: -lblContry.bounds.height)
        dropDownContry.dismissMode = .onTap
        dropDownContry.textColor = .black
        dropDownContry.backgroundColor = .white
        dropDownContry.selectionBackgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        
        dropDownContry.reloadAllComponents()
    }
    
    func callSearchAllPlanAPI(plan_type: String)
    {
        //        APIClient.sharedInstance.showIndicator()
        
        let parm = ["":""]
        
        let _url = "?plan_type=\(plan_type ?? "")"
        
        print(parm)
        
        APIClient.sharedInstance.MakeAPICallWithoutAuthHeaderGet(ALL_PLAN_LIST + _url, parameters: [:]) { response, error, statusCode in
            
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
                        // self.setUpMakeToast(msg: message ?? "")
                        self.arrSearchPlanList.removeAll()
                        if let arrData = response?.value(forKey: "response") as? NSArray
                        {
                            for objData in arrData
                            {
                                let dicData = TIplansResponse(fromDictionary: objData as! NSDictionary)
                                self.arrSearchPlanList.append(dicData)
                            }
                        }
                        
                        if self.arrSearchPlanList.count > 0
                        {
                            self.lblNoData.isHidden = true
                        }
                        else
                        {
                            self.lblNoData.isHidden = false
                        }
                        
                        self.tblview.reloadData()
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
    
    
    @IBAction func ClickedCountryCode(_ sender: Any) {
        dropDownContry.show()
        
    }
    
    @IBAction func clickedLogin(_ sender: Any) {
        
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.isFromHome = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func clickedPlan(_ sender: Any) {
        if let isUserLogin = UserDefaults.standard.value(forKey: "isUserLogin") as? Bool
        {
            if isUserLogin == true
            {
                let mainS = UIStoryboard(name: "Main", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "MyPoliciesViewController") as! MyPoliciesViewController
                self.navigationController?.pushViewController(vc, animated: false)
                
            }
            else
            {
                let mainS = UIStoryboard(name: "Main", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                vc.isFromHome = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else
        {
            let mainS = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainS.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            vc.isFromHome = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func clickedProfile(_ sender: Any) {
        
        if let isUserLogin = UserDefaults.standard.value(forKey: "isUserLogin") as? Bool
        {
            if isUserLogin == true
            {
                let mainS = UIStoryboard(name: "Main", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                self.navigationController?.pushViewController(vc, animated: false)
                
            }
            else
            {
                let mainS = UIStoryboard(name: "Main", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                vc.isFromHome = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else
        {
            let mainS = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainS.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            vc.isFromHome = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    @IBAction func cliockedNotification(_ sender: Any) {
        
        if let isUserLogin = UserDefaults.standard.value(forKey: "isUserLogin") as? Bool
        {
            if isUserLogin == true
            {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                let mainS = UIStoryboard(name: "Main", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                vc.isFromHome = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else
        {
            let mainS = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainS.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            vc.isFromHome = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch == false
        {
            return arrPlanList.count
        }
        else
        {
            return arrSearchPlanList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblview.dequeueReusableCell(withIdentifier: "HomeTableviewCell") as! HomeTableviewCell
        
        var dicData = TIplansResponse()
        
        if isSearch == false
        {
            dicData = arrPlanList[indexPath.row]
        }
        else
        {
            dicData = arrSearchPlanList[indexPath.row]
        }
        
        cell.lblOut.text = dicData.planTypeCategory.name ?? ""
        
        cell.viewOu.clipsToBounds = true
        cell.viewOu.layer.cornerRadius = 16.5
        cell.viewOu.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner] // Right Corner
        
        cell.lblType.text = "\(dicData.planType ?? "")"
        
        cell.lblDes.text = dicData.planTypeDescription.convertHTMLToPlainText()
        
        var media_link_url = dicData.planImage ?? ""
        media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        cell.imgPlan.sd_setImage(with: URL.init(string: media_link_url), placeholderImage: nil, options: [], completed: nil)
        
        cell.viewMain.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.04), alpha: 1, x: 0, y: 0, blur: 15, spread: 0)
        
        cell.imgPlan.clipsToBounds = true
        cell.imgPlan.layer.cornerRadius = 10
        cell.imgPlan.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var dicData = TIplansResponse()
        
        if isSearch == false
        {
            dicData = arrPlanList[indexPath.row]
        }
        else
        {
            dicData = arrSearchPlanList[indexPath.row]
        }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeDetailVC") as! HomeDetailVC
        vc.isOpenAgent = false
        vc.strId = dicData.slug ?? ""
        
        if dicData.planTypeCategory.name.uppercased().contains("OUTBOUND") == true
        {
            appDelegate?.strSelectedPermissionPurchase = "2"
        }
        else if dicData.planTypeCategory.name.uppercased().contains("INBOUND") == true
        {
            appDelegate?.strSelectedPermissionPurchase = "1"
        }
        else
        {
            appDelegate?.strSelectedPermissionPurchase = "0"
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}



class HomeTableviewCell : UITableViewCell {
    
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var btnViewDetails: UIButton!
    @IBOutlet weak var imgPlan: UIImageView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblDes: UILabel!
    
    @IBOutlet weak var viewOu: UIView!
    @IBOutlet weak var lblOut: UILabel!
}

