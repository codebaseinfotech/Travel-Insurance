//
//  ModiyInsuranceViewController.swift
//  Hamraa Insurance
//
//  Created by Purv on 19/03/24.
//
/*
 for agent
 mailto:agentios@yopmail.com
 123456
 */
import UIKit
import DropDown

//MARK:- Delegate
protocol PizzaDelegate
{
    func onPizzaReady(type: Bool, policy_id: Int)
}


class ModiyInsuranceViewController: UIViewController, onPlanPeriod {

    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var txtPolicyEDate: UITextField!
    @IBOutlet weak var txtViewReason: UITextView!
    @IBOutlet weak var txtNoOfDay: UITextField!
    @IBOutlet weak var btnModify: UIButton!
    @IBOutlet weak var lblSelectPerson: UILabel!
    @IBOutlet weak var viewSelect: UIView!
    
    var objMyPolocyDetail = TIPolicyDetailResponse()

    var delegate:PizzaDelegate?
    
    var datePickerDOB = UIDatePicker()
    var str = 0
    
    let dropDownContry = DropDown()
    var arrContry: [ContryCodeConversionRate] = [ContryCodeConversionRate]()
    
    let dropDownSelect = DropDown()
    var timePeriod = ""
    var transactionDetailsId = ""
    
    let dropDownPeriod = DropDown()
    var arrPeriod = NSMutableArray()
    var strID = 0
    var strPreiodID = 0
    var insuranceId = 0
    var strPolicyNo = ""
    
    var dicCurrentModifyInsurance = TIModifyDetailData()
    
    var strTimePeriod = false
    
    var download_invoice_url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for i in 1...objMyPolocyDetail.plans.maxDays {
            arrPeriod.add("\(i) days")
        }
        
        lblSelectPerson.text = objMyPolocyDetail.userinsurancedata[0].fullName ?? ""
        insuranceId = objMyPolocyDetail.userinsurancedata[0].insuranceId ?? 0
    
        self.txtDOB.text = objMyPolocyDetail.userinsurancedata[0].policy_start_date ?? ""
        self.txtNoOfDay.text = objMyPolocyDetail.userinsurancedata[0].time_period ?? ""
        self.txtPolicyEDate.text = objMyPolocyDetail.userinsurancedata[0].policy_end_date ?? ""
        
        strPreiodID = Int(objMyPolocyDetail.userinsurancedata[0].time_period.replacingOccurrences(of: " days", with: "")) ?? 0
        
        onCurrentTime(isChangeDate: false)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.datePickerDOB.date = dateFormatter.date(from: objMyPolocyDetail.policyStartDate ?? "")!
        
        setUpDropdownPeriod()
        
        
       
        setDropDown()
        // Do any additional setup after loading the view.
    }
    
    func setDropDown()
    {
        
        let arrName = NSMutableArray()
       
        for objsd in objMyPolocyDetail.userinsurancedata
        {
            if objsd.policy_status == "success" {
                arrName.add(objsd.fullName ?? "")
            }
        }
        
        dropDownSelect.dataSource = arrName as! [String]
        dropDownSelect.anchorView = viewSelect
        dropDownSelect.direction = .bottom
        
        // Selection Action
        dropDownSelect.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else { return }
            print("Selected item: \(item) at index: \(index)")
            self.lblSelectPerson.text = item
            
            for objsd in objMyPolocyDetail.userinsurancedata
            {
                if objsd.fullName == item
                {
                    self.insuranceId = objsd.insuranceId ?? 0
                    self.strPolicyNo = objsd.policyNo ?? ""
                    
                    self.txtDOB.text = objsd.policy_start_date ?? ""
                    self.txtNoOfDay.text = objsd.time_period ?? ""
                    self.txtPolicyEDate.text = objsd.policy_end_date ?? ""
                }
            }
            
        }
        
        // Styling
        dropDownSelect.bottomOffset = CGPoint(x: 0, y: viewSelect.bounds.height)
        dropDownSelect.dismissMode = .onTap
        dropDownSelect.textColor = .black
        dropDownSelect.backgroundColor = .white
        dropDownSelect.selectionBackgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        
    }
    
    @IBAction func clickedSelectPersong(_ sender: Any) {
        dropDownSelect.show()
    }
    
    func onPlanPeriod(text: String, isDestintion: Bool, id: Int, days: Int) {
        if isDestintion == true {
            self.txtNoOfDay.text = text
            self.strPreiodID = days
            
            strTimePeriod = true
            
            let sDate = txtDOB.text ?? ""
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: sDate)!
            
            let maximumDate = Calendar.current.date(byAdding: .day, value: days-1, to: date)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let expireDate = dateFormatter.string(from: maximumDate!)
            
            txtPolicyEDate.text = expireDate
            
            onCurrentTime(isChangeDate: false)
        }
    }
    
    func onCurrentTime(isChangeDate: Bool) {
        
        if isChangeDate == false {
            if self.strPreiodID == Int(objMyPolocyDetail.userinsurancedata[0].time_period.replacingOccurrences(of: " days", with: "")) ?? 0 {
                btnModify.isHidden = true
                
            } else {
                btnModify.isHidden = false
                
            }
        } else {
            
            DispatchQueue.main.async { [self] in
                if self.txtDOB.text == objMyPolocyDetail.policyStartDate ?? "" {
                    btnModify.isHidden = true
                    
                } else {
                    btnModify.isHidden = false
                    
                }
            }
           
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        callGetAllConversionRateAPI()
    }
    
    func setUpDropdownPeriod()
    {
        
        dropDownPeriod.dataSource = arrPeriod as! [String]
        dropDownPeriod.anchorView = txtNoOfDay
        dropDownPeriod.direction = .bottom
        
        dropDownPeriod.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.txtNoOfDay.text = item
            
            self.strPreiodID = index+1
            
            let maximumDate = Calendar.current.date(byAdding: .day, value: self.strPreiodID-1, to: datePickerDOB.date)
            let formatter7 = DateFormatter()
            formatter7.dateFormat = "yyyy-MM-dd"
            txtPolicyEDate.text = formatter7.string(from: maximumDate!)
        }
        dropDownPeriod.bottomOffset = CGPoint(x: 0, y: txtNoOfDay.bounds.height)
        dropDownPeriod.topOffset = CGPoint(x: 0, y: txtNoOfDay.bounds.height)
        dropDownPeriod.dismissMode = .onTap
        dropDownPeriod.textColor = UIColor.darkGray
        dropDownPeriod.backgroundColor = UIColor.white
        dropDownPeriod.selectionBackgroundColor = UIColor.clear
        
        dropDownPeriod.reloadAllComponents()
    }
    
    func daysBetweenDates(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current
        
        // Specify the components you want to include in the calculation
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        
        // Access the 'day' component to get the number of days
        if let days = components.day {
            return days
        } else {
            return 0 // Could not calculate the difference
        }
    }
    
    @IBAction func clciekdDays(_ sender: Any) {
       // dropDownPeriod.show()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlanPopupVC") as! PlanPopupVC
        vc.modalPresentationStyle = .overFullScreen
        vc.strID = objMyPolocyDetail.plans.slug ?? ""
        vc.delegateSearch = self
        self.present(vc, animated: false)
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickedDOB(_ sender: UITextField) {
        str = 1
        datePickerDOB.datePickerMode = .date
        datePickerDOB.preferredDatePickerStyle = .wheels
        
        //ToolBar
        datePickerDOB.minimumDate = Date()
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "CANCEL", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        sender.inputAccessoryView = toolbar
        sender.inputView = datePickerDOB
    }
    
    @IBAction func clickedModify(_ sender: Any) {
        
        if txtDOB.text == "" {
            
            self.view.makeToast("Please select Change effective date")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please select Change effective date")

        } else if txtNoOfDay.text == "" {
            
            self.view.makeToast("Please select No of days")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please select Change No of days")
            
        } else if txtPolicyEDate.text == "" {
            
            self.view.makeToast("Please select Expire Date")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please select Expire Date")
            
        } else if txtViewReason.text == "" {
        
            self.view.makeToast("Please select Reason")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please select Reason")
            
        } else {
            
            if strTimePeriod == true {
                if self.strPreiodID != Int(objMyPolocyDetail.userinsurancedata[0].time_period.replacingOccurrences(of: " days", with: "")) ?? 0 {
                    callModifyInsuaranceAPI()
                }
            } else {
                if self.strPreiodID != Int(objMyPolocyDetail.userinsurancedata[0].time_period.replacingOccurrences(of: " days", with: "")) ?? 0 {
                    callModifyInsuaranceAPI()
                    
                } else if self.txtDOB.text != objMyPolocyDetail.policyStartDate ?? "" {
                    callModifyInsuaranceDateAPI()
                }
            }
           
        }

    }
    
    
    @IBAction func clickedEDate(_ sender: UITextField) {
        str = 2
        datePickerDOB.datePickerMode = .date
        datePickerDOB.preferredDatePickerStyle = .wheels

        //ToolBar
        let maximumDate = Calendar.current.date(byAdding: .year, value: 84, to: Date())
        datePickerDOB.maximumDate = maximumDate
        let minmumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        datePickerDOB.minimumDate = minmumDate
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "CANCEL", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        sender.inputAccessoryView = toolbar
        sender.inputView = datePickerDOB
        
    }

    @objc func donedatePicker(){
        if str == 1 {
            
            strTimePeriod = false
            
            onCurrentTime(isChangeDate: true)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            txtDOB.text = formatter.string(from: datePickerDOB.date)
 
            let maximumDate = Calendar.current.date(byAdding: .day, value: self.strPreiodID-1, to: datePickerDOB.date)
            let formatter7 = DateFormatter()
            formatter7.dateFormat = "yyyy-MM-dd"
            txtPolicyEDate.text = formatter7.string(from: maximumDate!)
            
            self.view.endEditing(true)
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            txtPolicyEDate.text = formatter.string(from: datePickerDOB.date)
            self.view.endEditing(true)
        }
    }
 
    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }
    
    @IBAction func clickedCurrenyc(_ sender: Any) {
        dropDownContry.show()
    }
    
    //contry
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
       // APIClient.sharedInstance.showIndicator()
        
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
                                    
                                    if dicData.abbreviation ?? "" == self.objMyPolocyDetail.currencySymbol ?? "" {
                                        self.lblCurrency.text = "\(self.countryFlag(dicData.abbreviation ?? "" ?? "").prefix(1))   \(dicData.abbreviation ?? "" ?? "")"
                                        appDelegate?.objContryCodeConversionRate = dicData
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
    
    func callModifyInsuaranceAPI() {
        
        APIClient.sharedInstance.showIndicator()
        
        let transaction_details_id = transactionDetailsId
        let policy_start_date = txtDOB.text ?? ""
        let policy_end_date = txtPolicyEDate.text ?? ""
        let reason = txtViewReason.text ?? ""
        let time_period = "\(strPreiodID)"
        let currencySymbol = appDelegate?.objContryCodeConversionRate.abbreviation ?? ""
        let user_insurance_id = "\(insuranceId)"
       // let param = ["transaction_details_id":transaction_details_id, "policy_start_date":policy_start_date,"policy_end_date":policy_end_date,"reason":reason,"time_period":time_period,"currencySymbol":currencySymbol]
        
        let param = [ "policy_start_date":policy_start_date,"policy_end_date":policy_end_date,"reason":reason,"time_period":time_period,"currencySymbol":currencySymbol,"user_insurance_id":user_insurance_id]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(SINGLE_EXTENDPOLICY, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil {
                APIClient.sharedInstance.hideIndicator()
                
                let message = response?.value(forKey: "message") as? String
                
                if let status = response?.value(forKey: "status") as? Int, status == 1 {
                    
                    if let data = response?.value(forKey: "data") as? NSDictionary {
                        
                        let dicData = TIModifyDetailData(fromDictionary: data)
                        self.dicCurrentModifyInsurance = dicData
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PolicyDetailVC") as! PolicyDetailVC
                        vc.strId = self.strID
                        vc.dicCurrentModifyInsurance = dicData
                        vc.download_invoice_url = self.download_invoice_url
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }
                }
                
            }
        }
    }
    
    func callModifyInsuaranceDateAPI() {
        
        APIClient.sharedInstance.showIndicator()
        
        let transaction_details_id = transactionDetailsId
        let policy_start_date = txtDOB.text ?? ""
        let policy_end_date = txtPolicyEDate.text ?? ""
        let reason = txtViewReason.text ?? ""
        let time_period = "\(strPreiodID)"
        let currencySymbol = objMyPolocyDetail.currencySymbol ?? ""
        let user_insurance_id = "\(insuranceId)"
        
//        let param = ["transaction_details_id":transaction_details_id, "policy_start_date":policy_start_date,"policy_end_date":policy_end_date,"reason":reason,"time_period":time_period]
        
        let param = ["policy_start_date":policy_start_date,"policy_end_date":policy_end_date,"reason":reason,"time_period":time_period,"user_insurance_id": user_insurance_id]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(SINGLE_EXTENDPOLICY_DATE, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil {
                APIClient.sharedInstance.hideIndicator()
                
                let message = response?.value(forKey: "message") as? String
                
                if let status = response?.value(forKey: "status") as? Int, status == 1 {
                    
                    self.setUpMakeToast(msg: message ?? "")
                    self.delegate?.onPizzaReady(type: true, policy_id: self.strID)
                    self.clickedBack(self)
                } else {
                    self.setUpMakeToast(msg: message ?? "")
                }
            }
        }
    }
    
}
