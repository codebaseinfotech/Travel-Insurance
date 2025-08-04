//
//  Form-2VC.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 18/01/24.
//

import UIKit
import DropDown

class Form2VC: UIViewController, onSeachSelect, onPlanPeriod {
    
    
    
    @IBOutlet weak var lblCurrency: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    //Zone outlets
    @IBOutlet weak var txtSelect: UITextField!
    @IBOutlet weak var imgS: UIImageView!
    //Period outlets
    @IBOutlet weak var txtSelectPeriod: UITextField!
    @IBOutlet weak var imgPeriod: UIImageView!
    //Destination outlets
    @IBOutlet weak var txtSelectDestination: UITextField!
    @IBOutlet weak var imgDestination: UIImageView!
    
    @IBOutlet weak var viewTop: UIView!
    
    let dropDownZone = DropDown()
    let dropDownPeriod = DropDown()
    let dropDownDestination = DropDown()
        
    var planid = ""
    var dicPlanDetails = TIPlanDetailsResponse()
    
    var strPreiodID = 0
    
    let dropDownContry = DropDown()
    var arrContry: [ContryCodeConversionRate] = [ContryCodeConversionRate]()

    var arrAllZone: [TIZoneResponse] = [TIZoneResponse]()
    
    var strZoneId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        appDelegate?.isBackForm = false
        
        lblTitle.text = "\(dicPlanDetails.planType ?? "")"
        
        setUpDropdownState()
        setUpDropdownPeriod()
        
        viewTop.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 16, spread: 0)
        
        callAllZoneListAPI(id: dicPlanDetails.planTypeCategory.id ?? 0)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        callGetAllConversionRateAPI()
    }
    
    func onPlanPeriod(text: String, isDestintion: Bool, id: Int, days: Int) {
        if isDestintion == true {
            self.txtSelectPeriod.text = text
            self.self.strPreiodID = days
            
            self.txtSelectDestination.text = ""
        }
    }
    
    func onSelectText(text: String, isDestintion: Bool, id: Int) {
        self.txtSelectDestination.text = text
    }
    
    func setUpDropdownState()
    {
        
        var arrZone = [String]()
       
        for obj in self.arrAllZone {
            arrZone.append(obj.name ?? "")
        }
        
        dropDownZone.dataSource = arrZone
        dropDownZone.anchorView = txtSelect
        dropDownZone.direction = .bottom
        
        dropDownZone.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.imgS.rotateBack()
            self.txtSelect.text = item
            
            for obj in arrAllZone {
                
                if item == obj.name ?? "" {
                    self.strZoneId = obj.id ?? 0
                }
                
                self.txtSelectPeriod.text = ""
                self.txtSelectDestination.text = ""
            }
            
        }
        dropDownZone.bottomOffset = CGPoint(x: 0, y: txtSelect.bounds.height)
        dropDownZone.topOffset = CGPoint(x: 0, y: txtSelect.bounds.height)
        dropDownZone.dismissMode = .onTap
        dropDownZone.textColor = UIColor.darkGray
        dropDownZone.backgroundColor = UIColor.white
        dropDownZone.selectionBackgroundColor = UIColor.clear
        
        dropDownZone.reloadAllComponents()
    }
    
    
    func setUpDropdownPeriod()
    {
        var arrPlan = [String]()
        
//        for obj in self.arrAllPlan {
//            arrPlan.append(obj.insurancePeriod ?? "")
//        }
        
        
        dropDownPeriod.dataSource = arrPlan
        dropDownPeriod.anchorView = txtSelectPeriod
        dropDownPeriod.direction = .bottom
        
        dropDownPeriod.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.imgPeriod.rotateBack()
            self.txtSelectPeriod.text = item
            
            self.strPreiodID = index+1
            
            self.txtSelectDestination.text = ""
            
        }
        dropDownPeriod.bottomOffset = CGPoint(x: 0, y: txtSelectPeriod.bounds.height)
        dropDownPeriod.topOffset = CGPoint(x: 0, y: txtSelectPeriod.bounds.height)
        dropDownPeriod.dismissMode = .onTap
        dropDownPeriod.textColor = UIColor.darkGray
        dropDownPeriod.backgroundColor = UIColor.white
        dropDownPeriod.selectionBackgroundColor = UIColor.clear
        
        dropDownPeriod.reloadAllComponents()
    }
   
    @IBAction func clickedZone(_ sender: Any) {
        self.imgS.rotate180()
        dropDownZone.show()
    }
    
    
    @IBAction func clickedPeriod(_ sender: Any) {
//        self.imgPeriod.rotate180()
//        dropDownPeriod.show()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlanPopupVC") as! PlanPopupVC
        vc.modalPresentationStyle = .overFullScreen
        vc.strID = dicPlanDetails.slug ?? ""
        vc.delegateSearch = self
        self.present(vc, animated: false)
    }
    
    
    @IBAction func clickedDestination(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectPopUpVC") as! SelectPopUpVC
        let home = UINavigationController(rootViewController: vc)
        home.modalPresentationStyle = .overFullScreen
        vc.isDestination = true
        vc.delegateSearch = self
        vc.isOpenForm1 = true
        vc.zone_id = self.strZoneId
        self.present(home, animated: false)
        
    }
    
    
    
    @IBAction func clickedCurrenyc(_ sender: Any) {
        dropDownContry.show()
    }
    
    @IBAction func clickedNext(_ sender: Any) {
        if self.txtSelect.text == ""
        {
            self.view.makeToast("Please select Zone")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please select Zone")
        }
        else if self.txtSelectPeriod.text == ""
        {
            self.view.makeToast("Please select period")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please select period")
        }
        else if self.txtSelectDestination.text == ""
        {
            self.view.makeToast("Please select destination")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please select destination")
        }
        else
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FormVC") as! FormVC
            vc.planid = self.planid
            vc.dicPlanDetails = self.dicPlanDetails
            vc.strPeriod = strPreiodID
            vc.strDestination = self.txtSelectDestination.text ?? ""
            vc.strZone = self.txtSelect.text ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setDropDownEmail()
    {
        
        let arrString = NSMutableArray()
        
        for (index,obj) in self.arrContry.enumerated()
        {
            arrString.add("\(self.countryFlag(self.arrContry[index].abbreviation ?? "").prefix(1))   \(self.arrContry[index].abbreviation ?? "")")
        }
        
        dropDownContry.dataSource = arrString as! [String]
        dropDownContry.anchorView = lblCurrency
        dropDownContry.direction = .bottom
        
        dropDownContry.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.lblCurrency.text = item
            
            for (indexz,obj) in self.arrContry.enumerated()
            {
                if indexz == index {
                    
                    self.lblCurrency.text = "\(self.countryFlag(self.arrContry[index].abbreviation ?? "").prefix(1))   \(self.arrContry[index].abbreviation ?? "")"
                    
                    appDelegate?.objContryCodeConversionRate = obj
                }
                
            }
           
        }
        
        dropDownContry.bottomOffset = CGPoint(x: 0, y: lblCurrency.bounds.height)
        dropDownContry.topOffset = CGPoint(x: 0, y: -lblCurrency.bounds.height)
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
                                     
                                    if appDelegate?.objContryCodeConversionRate.abbreviation == nil
                                    {
                                        appDelegate?.objContryCodeConversionRate = self.arrContry[0]
                                    }
                                    else
                                    {
                                        self.lblCurrency.text = "\(self.countryFlag(appDelegate?.objContryCodeConversionRate.abbreviation ?? "").prefix(1))   \(appDelegate?.objContryCodeConversionRate.abbreviation ?? "")"
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
    
    func callAllZoneListAPI(id: Int) {
        
        APIClient.sharedInstance.showIndicator()
        
        let parm = ["":""]
        
        let _url = "?id=\(id)"
        
        print(parm)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(ZONE_LIST + _url, parameters: parm) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200 {
                    
                    if status == 200 {
                        
                        if let arr_response = response?.value(forKey: "response") as? NSArray {
                            
                            for obj in arr_response {
                                let dicData = TIZoneResponse(fromDictionary: obj as! NSDictionary)
                                self.arrAllZone.append(dicData)
                            }
                            
                            self.txtSelect.text = self.arrAllZone[0].name ?? ""
                            self.strZoneId = self.arrAllZone[0].id ?? 0
                            
                            self.setUpDropdownState()
                        }
                    } else {
                        self.setUpMakeToast(msg: message ?? "")
                    }
                } else {
                    self.setUpMakeToast(msg: message ?? "")
                }
            } else {
                APIClient.sharedInstance.hideIndicator()
                
                let message = response?.value(forKey: "message") as? String
                self.setUpMakeToast(msg: message ?? "")
            }
        }
        
    }
    
}
