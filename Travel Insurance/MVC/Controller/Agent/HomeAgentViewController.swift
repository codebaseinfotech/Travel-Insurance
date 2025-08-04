//
//  HomeAgentViewController.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 03/11/23.
//

import UIKit
import DropDown

class HomeAgentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate{

    @IBOutlet weak var lblCuurecy: UILabel!
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblview: UITableView!
    
    @IBOutlet weak var StackView: UIStackView!
    @IBOutlet weak var lblAgentI: UILabel!
    @IBOutlet weak var lblNoData: UILabel!
    
    @IBOutlet weak var viewNotification: UIView!
    @IBOutlet weak var lblNotiC: UILabel!
    
    var arrimg = ["0","1","2"]
    var arrname = ["Silver Plan","Gold Plan","Diamond Plan"]
    
    var arrPlanList: [TIplansResponse] = [TIplansResponse]()
    var arrSearchPlanList: [TIplansResponse] = [TIplansResponse]()

    var isSearch = false

    let dropDownContry = DropDown()
    var arrContry: [ContryCodeConversionRate] = [ContryCodeConversionRate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token = UserDefaults.standard.value(forKey: "token") as? String
        
        print("userToken:-\(token ?? "")")
        
        viewNotification.layer.cornerRadius = viewNotification.frame.height/2
        
        lblAgentI.text = "Agent ID: #\(appDelegate?.dicCurrentUserData.agentCode ?? "")"
        
        tblview.dataSource = self
        tblview.delegate = self
        
        StackView.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.08), alpha: 1, x: 0, y: 0, blur: 18, spread: 0)
        
        callAllPlanAPI()
        
        txtSearch.delegate = self
        txtSearch.addTarget(self, action: #selector(searchWorkersAsPerText(_:)), for: .editingChanged)
        
        callNotiCountAPI()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        callGetAllConversionRateAPI()
        callNotiCountAPI()
        callAllPlanAPI()
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
    
    func setDropDownEmail()
    {
        
        let arrString = NSMutableArray()
        
        for (index,obj) in self.arrContry.enumerated()
        {
            arrString.add("\(self.countryFlag(self.arrContry[index].abbreviation ?? "").prefix(1))   \(self.arrContry[index].abbreviation ?? "")")
        }
        
        dropDownContry.dataSource = arrString as! [String]
        dropDownContry.anchorView = lblCuurecy
        dropDownContry.direction = .bottom
        
        dropDownContry.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.lblCuurecy.text = item
            
            for (indexz,obj) in self.arrContry.enumerated()
            {
                if indexz == index {
                    
                    self.lblCuurecy.text = "\(self.countryFlag(self.arrContry[index].abbreviation ?? "").prefix(1))   \(self.arrContry[index].abbreviation ?? "")"
                    
                    appDelegate?.objContryCodeConversionRate = obj
                }
                
            }
           
        }
        
        dropDownContry.bottomOffset = CGPoint(x: 0, y: lblCuurecy.bounds.height)
        dropDownContry.topOffset = CGPoint(x: 0, y: -lblCuurecy.bounds.height)
        dropDownContry.dismissMode = .onTap
        dropDownContry.textColor = .black
        dropDownContry.backgroundColor = .white
        dropDownContry.selectionBackgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)

        dropDownContry.reloadAllComponents()
    }
    
    @IBAction func clickedSelectCurrect(_ sender: Any) {
        dropDownContry.show()
    }
    
    @IBAction func clickedInBond(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "HomeTopPopVC") as! HomeTopPopVC
        vc.modalPresentationStyle = .overFullScreen
        vc.strOpen = "In Bound"
        self.present(vc, animated: false)
    }
    @IBAction func clickedOutBond(_ sender: Any) {
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
    
    @IBAction func clickedPlan(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "MyPoliciesViewController") as! MyPoliciesViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func clickedProfile(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func cliockedNotification(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - tblView Delegate & DataSource
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
        let cell =
        self.tblview.dequeueReusableCell(withIdentifier: "HomeTableviewCell") as! HomeTableviewCell
      
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
        
        cell.btnViewDetails.tag = indexPath.row
        cell.btnViewDetails.addTarget(self, action: #selector(clickedDetail(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
        vc.strId = dicData.slug ?? ""
        vc.isOpenAgent = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clickedDetail(_ sender: UIButton)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeDetailVC") as! HomeDetailVC
        vc.isOpenAgent = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - API CALL
    
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
                       // self.viewNotification.isHidden = false
                        self.lblNotiC.text = "\(NotificationCOunt ?? 0)"
                    }
                    else
                    {
                       // self.viewNotification.isHidden = true
                        self.lblNotiC.text = "0"
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
    
    func callAllPlanAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
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
//                        self.setUpMakeToast(msg: message ?? "")
                        self.arrPlanList.removeAll()
                        if let arrData = response?.value(forKey: "response") as? NSArray
                        {
                            for objData in arrData
                            {
                                let dicData = TIplansResponse(fromDictionary: objData as! NSDictionary)
                                
                                if appDelegate?.dicCurrentUserData.permissionPurchase == "0" {
                                    self.arrPlanList.append(dicData)
                                    
                                } else if appDelegate?.dicCurrentUserData.permissionPurchase == "1" {
                                    
                                    if dicData.planTypeCategory.name.uppercased().contains("INBOUND") {
                                        self.arrPlanList.append(dicData)
                                        
                                    }
                                    
                                } else {
                                    if dicData.planTypeCategory.name.uppercased().contains("OUTBOUND") {
                                        self.arrPlanList.append(dicData)
                                        
                                    }
                                }
                            }
                        }
                        
                        if self.arrPlanList.count > 0
                        {
                            self.lblNoData.isHidden = true
                            self.tblview.isHidden = false
                        }
                        else
                        {
                            self.lblNoData.isHidden = false
                            self.tblview.isHidden = true
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
                                    self.lblCuurecy.text = "\(self.countryFlag(self.arrContry[0].abbreviation ?? "").prefix(1))   \(self.arrContry[0].abbreviation ?? "")"
                                    
                                    if appDelegate?.objContryCodeConversionRate.abbreviation == nil
                                    {
                                        appDelegate?.objContryCodeConversionRate = self.arrContry[0]
                                    }
                                    else
                                    {
                                        self.lblCuurecy.text = "\(self.countryFlag(appDelegate?.objContryCodeConversionRate.abbreviation ?? "").prefix(1))   \(appDelegate?.objContryCodeConversionRate.abbreviation ?? "")"
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
}


    


