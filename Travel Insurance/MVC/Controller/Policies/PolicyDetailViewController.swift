//
//  PolicyDetailViewController.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 02/11/23.
//

import UIKit
import DropDown
import NYTPhotoViewer

protocol onClaimActionDelegate: AnyObject {
    func clickedOnClaim(_ index: Int)
}

class PolicyDetailViewController: UIViewController, PizzaDelegate {
        
    @IBOutlet weak var viewModi: UIView!
    @IBOutlet weak var viewCancel: UIView!
    
    @IBOutlet weak var viewModiHeight: NSLayoutConstraint! //30
    @IBOutlet weak var viewCancelHeight: NSLayoutConstraint!
    @IBOutlet weak var viewTopModi: NSLayoutConstraint! //15
    @IBOutlet weak var viewTopCancel: NSLayoutConstraint!
    
    @IBOutlet weak var viewReupload: UIView!
    @IBOutlet weak var heightReupload: NSLayoutConstraint!
    
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var tblView: UITableView! {
        didSet {
            let nibName = UINib(nibName: "ClaimTblViewCell", bundle: nil)
            tblView.register(nibName, forCellReuseIdentifier: "ClaimTblViewCell")
        }
    }
    @IBOutlet weak var viewTop: UIView!
    
    @IBOutlet weak var lblTPrice: UILabel!
    @IBOutlet weak var lblTIQS: UILabel!
    @IBOutlet weak var lblTEntitlement: UILabel!
    @IBOutlet weak var lblTPaidAmount: UILabel!
    
    @IBOutlet weak var viewButtom: UIView!
    
    @IBOutlet weak var stackTotalAmount: UIStackView!
    @IBOutlet weak var stackEntitlement: UIStackView!
    @IBOutlet weak var stackPaidAmount: UIStackView!
    
    @IBOutlet weak var lblDiwanTax: UILabel!
    @IBOutlet weak var viewDiwanTex: UIView!
    
    var isSelectedTitle = 0
    
    var arrMyPolocyDetail: [TIPolicyDetailResponse] = [TIPolicyDetailResponse]()
    var strId = 0
    var isAPICall = false
    var transection_detail_id = 0
    
    let dropDownContry = DropDown()
    var arrContry: [ContryCodeConversionRate] = [ContryCodeConversionRate]()
    
    var isShowModi = false
    
    var download_invoice_url = ""
    var download_report_url = ""
    
    var currentDate = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModi.layer.cornerRadius = 8
        viewCancel.layer.cornerRadius = 8
       
        viewTop.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1), alpha: 1, x: 0, y: 0, blur: 17, spread: 0)
        
        callMyPlocyAPI(id: strId)
        
        let date = Date() // Current date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let dateString = formatter.string(from: date)
        self.currentDate = dateString
        
        tblView.delegate = self
        tblView.dataSource = self
        
        if appDelegate?.dicCurrentUserData.roleId == 1 {
            
            stackTotalAmount.isHidden = true
            stackEntitlement.isHidden = true
            stackPaidAmount.isHidden = true
            
            viewButtom.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 153-75)
            
        } else {
            // 153
            
            stackTotalAmount.isHidden = false
            stackPaidAmount.isHidden = false
            stackEntitlement.isHidden = false
            
            viewButtom.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 153)
        }
      
        // Do any additional setup after loading the view.
    }
    
    func onPizzaReady(type: Bool, policy_id: Int) {
        if type == true {
            callMyPlocyAPI(id: policy_id)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        callGetAllConversionRateAPI()
    }
    
    @IBAction func clickedCurrenyc(_ sender: Any) {
        dropDownContry.show()
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clickedModifyInsurance(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "ModiyInsuranceViewController") as! ModiyInsuranceViewController
        vc.delegate = self
        vc.timePeriod = "\(arrMyPolocyDetail[0].timePeriod ?? "")"
        vc.transactionDetailsId = "\(arrMyPolocyDetail[0].transactionDetailsId ?? 0)"
        vc.objMyPolocyDetail = arrMyPolocyDetail[0]
        vc.strID = self.strId
        vc.download_invoice_url = download_invoice_url
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickedCancel(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "CancelPolicyVC") as! CancelPolicyVC
        vc.isSelectPerson = true
        vc.delegate = self
        vc.objMyPolocyDetail = arrMyPolocyDetail[0].userinsurancedata
        vc.strId = arrMyPolocyDetail[0].transactionDetailsId ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func clickedReupload(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CancelPolicyVC") as! CancelPolicyVC
        vc.showImage = 2
        vc.strId = arrMyPolocyDetail[0].transactionDetailsId ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - calling API
    
    func callMyPlocyAPI(id: Int)
    {
        APIClient.sharedInstance.showIndicator()
        
        
        var insurance_type = ""
        
        if isSelectedTitle == 1
        {
            insurance_type = "current"
        }
        else if isSelectedTitle == 2
        {
            insurance_type = "upcoming"
        }
        else {
            insurance_type = "expired"
        }
        
        let _url = "/\(id)/\(insurance_type)"
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(MY_INSURANCE_DETAIL + _url, parameters: [:]) { response, error, statusCode in
            
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
                        self.arrMyPolocyDetail.removeAll()
                        if let arrResponse = response?.value(forKey: "response") as? NSArray
                        {
                            for (index,obj) in arrResponse.enumerated()
                            {
                                let dicData = TIPolicyDetailResponse(fromDictionary: obj as! NSDictionary)
                                self.arrMyPolocyDetail.append(dicData)
                            }
                            
                        }
                        
                        let download_report_url = response?.value(forKey: "download_report_url") as? String
                        let download_invoice_url = response?.value(forKey: "download_invoice_url") as? String
                        
                        self.download_report_url = download_report_url ?? ""
                        self.download_invoice_url = download_invoice_url ?? ""
                        
                        if self.isSelectedTitle == 2 {
                            if self.arrMyPolocyDetail[0].cancellationDocument == "" || self.arrMyPolocyDetail[0].transectionStatus[0].status == "cancelled" || self.arrMyPolocyDetail[0].transectionStatus[0].status == "cancel request" {
                                self.viewReupload.isHidden = true
                                self.heightReupload.constant = 0
                            } else {
                                
//                                self.viewReupload.isHidden = false
//                                self.heightReupload.constant = 30
                                self.viewReupload.isHidden = true
                                self.heightReupload.constant = 0
                            }
                            
                            if self.arrMyPolocyDetail[0].transectionStatus.count > 0 {
                                
                                if self.arrMyPolocyDetail[0].transectionStatus[0].status == "success" {
                                    
                                    self.viewModi.isHidden = false
                                    self.viewModiHeight.constant = 30
                                    self.viewTopModi.constant = 15
                                    
                                    self.viewCancel.isHidden = false
                                    self.viewCancelHeight.constant = 30
                                    self.viewTopCancel.constant = 15
                                    
                                    
                                    
                                } else {
                                    self.viewModi.isHidden = true
                                    self.viewModiHeight.constant = 0
                                    self.viewTopModi.constant = 0
                                    
                                    self.viewCancel.isHidden = true
                                    self.viewCancelHeight.constant = 0
                                    self.viewTopCancel.constant = 0

                                }
                            }
                            
                        } else {
                            self.viewModi.isHidden = true
                            self.viewModiHeight.constant = 0 
                            self.viewTopModi.constant = 0
                            
                            self.viewCancel.isHidden = true
                            self.viewCancelHeight.constant = 0
                            self.viewTopCancel.constant = 0
                            
                            self.viewReupload.isHidden = true
                            self.heightReupload.constant = 0
                        }

                        var strPrice = Double(self.arrMyPolocyDetail[0].totalPrice ?? "") ?? 0.0
                        
                        let iQDAmount = Double(self.arrMyPolocyDetail[0].iQDAmount ?? "") ?? 0.0
                        let totalPrice = Double(self.arrMyPolocyDetail[0].totalPrice ?? "") ?? 0.0
                        let agentPrice = Double(self.arrMyPolocyDetail[0].agentPrice ?? "") ?? 0.0
                        let agentCommision = Double(self.arrMyPolocyDetail[0].agentCommision ?? "") ?? 0.0
                        
                        let diwan_tax = Double(self.arrMyPolocyDetail[0].diwan_tax ?? "") ?? 0.0
                        let diwan_tax_percent = Double(self.arrMyPolocyDetail[0].diwan_tax_percent ?? "") ?? 0.0
                        
                        let totalNew = iQDAmount + diwan_tax
                        
                        let formattedString = String(format: "%.2f", totalNew)
                        let formattedString1 = String(format: "%.2f", agentCommision)
                        let formattedString2 = String(format: "%.2f", agentPrice)
                        let formattedString3 = String(format: "%.2f", totalPrice)
                        let formattedString4 = String(format: "%.2f", diwan_tax)
                        let formattedString5 = String(format: "%.2f", diwan_tax_percent)
                        
                        if self.arrMyPolocyDetail[0].plans.planTypeCategory.type.contains("Inbound-medical") == true {
                            self.viewDiwanTex.isHidden = true
                        } else {
                            self.viewDiwanTex.isHidden = true
                        }
                        self.lblDiwanTax.text = "IQD \(formattedString4) (\(formattedString5)%)"
                        
                        self.lblTIQS.text = "IQD \(formattedString)"
                        self.lblTPrice.text = "\(self.arrMyPolocyDetail[0].currencySymbol ?? "") \(formattedString3)"
                        self.lblTEntitlement.text = "IQD \(formattedString2)(\(formattedString1)%)"
                        
                        
                        let total_amount = iQDAmount - agentPrice
                      
                        let new_total_amount = total_amount + diwan_tax
                        
                        let formattedString_total_amount = String(format: "%.2f", new_total_amount)
                        
                        self.lblTPaidAmount.text = "IQD \(formattedString_total_amount)"
                        
                        self.transection_detail_id = self.arrMyPolocyDetail[0].transactionDetailsId ?? 0
                        self.viewButtom.isHidden = false
                        self.isAPICall = true
                        self.tblView.reloadData()
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
            tblView.reloadData()
           
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
                                    
                                    self.lblCurrency.text = "\(self.countryFlag(appDelegate?.objContryCodeConversionRate.abbreviation ?? "").prefix(1))   \(appDelegate?.objContryCodeConversionRate.abbreviation ?? "")"
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
}

extension PolicyDetailViewController: onClaimActionDelegate {
    func clickedOnClaim(_ index: Int) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(identifier: "ClaimVC") as! ClaimVC
        vc.objMyPolocyDetail = arrMyPolocyDetail[0].userinsurancedata[index]
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    
}

extension PolicyDetailViewController: UITableViewDelegate, UITableViewDataSource
{
    func isExpireDateAtLeast60DaysAfterToday(expireDateString: String) -> Bool {
        let calendar = Calendar.current
        
        // Create a DateFormatter to convert the string to Date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"  // Update to your format if needed
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        // Convert the expire date string to a Date
        guard let expireDate = formatter.date(from: expireDateString) else {
            print("Failed to parse expire date string")
            return false
        }
        
        // Get the date 60 days from today
        guard let dateAfter60Days = calendar.date(byAdding: .day, value: 60, to: Date()) else {
            return false
        }
        
         let components = calendar.dateComponents([.day], from: expireDate, to: Date())

        if let days = components.day {
            print("Days between: \(days)")  // Output: Days between: 11
            
            if days <= 60
            {
                return true
            }
            else {
                return false
            }
        }
        
        // Compare the expireDate to 60 days from today
        return expireDate >= dateAfter60Days
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isAPICall == true
        {
            return arrMyPolocyDetail[0].userinsurancedata.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return firstPersonPolicyTblViewCell(indexPath)
        } else {
            return secondPersongPolicyTblViewCell(indexPath)
        }
    }
    
    func firstPersonPolicyTblViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "FirstPolicyDetailCell") as! FirstPolicyDetailCell
        
        cell.viewMain.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1), alpha: 1, x: 0, y: 0, blur: 17, spread: 0)
        
        cell.delegateOnClaim = self
        cell.btnClaim.tag = indexPath.section
        let dicData = arrMyPolocyDetail[0].userinsurancedata[indexPath.section]
        
        if isSelectedTitle != 2 {
            if dicData.policy_status == "success" && dicData.is_claim == "" && isExpireDateAtLeast60DaysAfterToday(expireDateString: dicData.policy_end_date) {
                cell.viewClaimPolicy.isHidden = false
            } else {
                cell.viewClaimPolicy.isHidden = true
            }
        } else {
            cell.viewClaimPolicy.isHidden = true
        }
        
        let dicAll = arrMyPolocyDetail[0]
        
        cell.lblClaimStatus.text = dicData.is_claim.uppercased() ?? ""
        cell.viewClaimStatus.isHidden = dicData.is_claim != "" ? false : true
        
        cell.lblPolicyStatus.text = dicData.policy_status.uppercased() ?? ""
        
        cell.lblPerson.text = "Traveler 1"
        
        cell.lblPolicyType.text = dicAll.plans.planTypeCategory.name ?? ""
        
        cell.lblPolicyName.text = dicAll.plans.planType ?? ""
        
        cell.lblFullName.text = dicData.fullName ?? ""
        cell.lblDEstination.text = dicData.destination ?? ""
//            cell.lblMS.text = dicData.maritalStatus ?? ""
        cell.lblPassportId.text = dicData.passportNumber ?? ""
//            cell.lblGender.text = dicData.gender ?? ""
        cell.lblNumber.text = "\(dicData.countryCode ?? "") \(dicData.mobileNumber ?? "")"
        cell.lblNationality.text = dicData.nationality ?? ""
        cell.lblNoDays.text = "\(dicAll.timePeriod.replacingOccurrences(of: " days", with: "") ?? "") days"
        
        let strPrice = Double(dicData.convertedAmount ?? "") ?? 0.0

//            let strPrice = Double(dicAll.iQDAmount ?? "") ?? 0.0
        
        let formattedString = String(format: "%.2f", strPrice)
        
        cell.lblPrice.text = "\(dicData.currency ?? "") \(formattedString)"
        cell.lblDateofbith.text = dicData.dateOfBirth ?? ""
        cell.lblEffectiveDate.text = dicData.policy_start_date ?? ""
        cell.lblExpireDate.text = dicData.policy_end_date ?? ""
        cell.lblZoneCoverage.text = self.arrMyPolocyDetail[0].zone ?? ""
        cell.lblEmail.text = dicData.email ?? ""
        
        if self.arrMyPolocyDetail[0].paymentMethod == "1" {
            cell.lblPaymentTyp.text = "Credit/Debit Card"
            
        } else {
            cell.lblPaymentTyp.text = "Cash"
            
        }
        
        cell.lblPolicyNo.text = dicData.policyNo ?? ""
        
        if dicAll.plans.planTypeCategory.name.uppercased().contains("(VISA)") == true {
            
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
        } else if dicAll.plans.planTypeCategory.name.uppercased().contains("(RESIDENTS)") == true {
            
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
                
                cell.lblRreason.text = dicData.residenceReason ?? ""
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
            
            cell.lblBoraderEntry.text = dicData.borderEntry ?? ""
            cell.viewBoraderEntry.isHidden = false
        } else {
            cell.viewBoraderEntry.isHidden = true
        }
        
        if dicData.passportCopy.contains(".pdf") == true
        {
            cell.imgPassport.isUserInteractionEnabled = true
            cell.imgPassport.image = UIImage(named: "pdf")
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            tapGesture.view?.tag = indexPath.section
            cell.imgPassport.addGestureRecognizer(tapGesture)

        }
        else
        {
            cell.imgPassport.isUserInteractionEnabled = false

            var media_link_url = dicData.passportCopy ?? ""
            media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            cell.imgPassport.sd_setImage(with: URL.init(string: media_link_url), placeholderImage: UIImage(named: "app_logo"), options: [], completed: nil)
        }
        
        cell.btnDownloadInvoice.tag = indexPath.section
        cell.btnDownloadInvoice.addTarget(self, action: #selector(clickedViewReport(_:)), for: .touchUpInside)
        
        cell.btnDownlaodPolicy.tag = indexPath.section
        cell.btnDownlaodPolicy.addTarget(self, action: #selector(clickedViewPolicy(_:)), for: .touchUpInside)
        
        cell.btnShowImg.accessibilityValue = "1"
        cell.btnShowImg.tag = indexPath.section
        cell.btnShowImg.addTarget(self, action: #selector(clickedShowImg(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func secondPersongPolicyTblViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "SecondPolicyDetailCell") as! SecondPolicyDetailCell
        
        cell.viewMain.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1), alpha: 1, x: 0, y: 0, blur: 17, spread: 0)
        
        cell.delegateOnClaim = self
        cell.btnClaim.tag = indexPath.section
        
        let dicData = arrMyPolocyDetail[0].userinsurancedata[indexPath.section]
        
        if isSelectedTitle != 2 {
            if dicData.policy_status == "success" && dicData.is_claim == "" && isExpireDateAtLeast60DaysAfterToday(expireDateString: dicData.policy_end_date) {
                cell.viewClaim.isHidden = false
            } else {
                cell.viewClaim.isHidden = true
            }
        } else {
            cell.viewClaim.isHidden = true
        }
        
        cell.lblPerson.text = "Traveler \(indexPath.section+1)"
        
        let dicAll = arrMyPolocyDetail[0]
        
        cell.lblClamStatus.text = dicData.is_claim.uppercased() ?? ""
        cell.viewClaimStatus.isHidden = dicData.is_claim != "" ? false : true

        cell.lblPolicyStatus.text = dicData.policy_status.uppercased() ?? ""
        cell.lblPlanName.text = dicAll.plans.planType ?? ""
        cell.lblNationality.text = dicData.nationality ?? ""
       
        
        cell.lblEffectivedate.text = dicData.policy_start_date ?? ""
        cell.lblExpireDate.text = dicData.policy_end_date ?? ""
        
        cell.lblFullName.text = dicData.fullName ?? ""
        cell.lblEmail.text = dicData.email ?? ""
        cell.lblPassport.text = dicData.passportNumber ?? ""
        cell.lblDateOf.text = dicData.dateOfBirth ?? ""
        let strPrice = Double(dicData.convertedAmount ?? "") ?? 0.0
        
        if self.arrMyPolocyDetail[0].paymentMethod == "1" {
            cell.lblPaymentType.text = "Credit/Debit Card"
            
        } else {
            cell.lblPaymentType.text = "Cash"
            
        }
        
        let formattedString = String(format: "%.2f", strPrice)
        
        cell.lblPrice.text = "\(dicData.currency ?? "") \(formattedString)"
        
        cell.lblPolicyNo.text = dicData.policyNo ?? ""
        

        if dicData.passportCopy.contains(".pdf") == true
        {
            cell.imgPasport.isUserInteractionEnabled = true
            cell.imgPasport.image = UIImage(named: "pdf")
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            tapGesture.view?.tag = indexPath.section
            cell.imgPasport.addGestureRecognizer(tapGesture)

        }
        else
        {
            cell.imgPasport.isUserInteractionEnabled = false
            
            var media_link_url = dicData.passportCopy ?? ""
            media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            cell.imgPasport.sd_setImage(with: URL.init(string: media_link_url), placeholderImage: UIImage(named: "app_logo"), options: [], completed: nil)
        }
        
        cell.btnDownloadInvoice.tag = indexPath.section
        cell.btnDownloadInvoice.addTarget(self, action: #selector(clickedViewReport(_:)), for: .touchUpInside)
        
        cell.btnDownlaodPolicy.tag = indexPath.section
        cell.btnDownlaodPolicy.addTarget(self, action: #selector(clickedViewPolicy(_:)), for: .touchUpInside)
        
        cell.lblShowImg.accessibilityValue = "2"
        cell.lblShowImg.tag = indexPath.section
        cell.lblShowImg.addTarget(self, action: #selector(clickedShowImg(_:)), for: .touchUpInside)
        
        return cell
    }
    
    
    // MARK: - cellActionMethod -
    @objc func imageTapped(str: UITapGestureRecognizer)
    {
        let dicData = arrMyPolocyDetail[0].userinsurancedata[str.view!.tag]
        
        if let url = URL(string: dicData.passportCopy ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return UITableView.automaticDimension
        }else{
            return 470
        }
    }
    
    @objc func clickedViewReport(_ sender: UIButton)
    {
        let transactionDetailsId = "\(self.arrMyPolocyDetail[0].transectionStatus[0].transactionDetailsId ?? 0)"
        
        print("ORDER_ID: \(download_invoice_url)\(transactionDetailsId)")

        if let url = URL(string: "\(download_invoice_url)\(transactionDetailsId)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc func clickedViewPolicy(_ sender: UIButton)
    {
        let order_id = base64Encode("\(self.arrMyPolocyDetail[0].orderId ?? "")")
        var insurance_id = base64Encode("\(self.arrMyPolocyDetail[0].userinsurancedata[sender.tag].insuranceId ?? 0)") ?? ""
      
        print("ORDER_ID: \(download_report_url)\(order_id ?? "")/\(insurance_id ?? "")")

        if let url = URL(string: "\(download_report_url)\(order_id ?? "")/\(insurance_id ?? "")") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    @objc func clickedShowImg(_ sender: UIButton) {
        
        if sender.accessibilityValue == "1" {
            let indePath = IndexPath(row: 0, section: sender.tag)
            
            let cell = tblView.cellForRow(at: indePath) as! FirstPolicyDetailCell
            
            let dicData = self.arrMyPolocyDetail[0].userinsurancedata[indePath.section]
            
            if dicData.passportCopy.contains(".pdf") == true {
                
                if let url = URL(string: dicData.passportCopy ?? "") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                
            } else {
                if let img = cell.imgPassport.image{
                    let photo = ChatImage()
                    photo.image = img
                    
                    let photosViewController: NYTPhotosViewController = NYTPhotosViewController(photos: [photo])
                    present(photosViewController, animated: true, completion: nil)
                }
                
            }
            
        } else {
            let indePath = IndexPath(row: 0, section: sender.tag)
            
            let cell = tblView.cellForRow(at: indePath) as! SecondPolicyDetailCell
         
            let dicData = self.arrMyPolocyDetail[0].userinsurancedata[indePath.section]
            
            if dicData.passportCopy.contains(".pdf") == true {
                
                if let url = URL(string: dicData.passportCopy ?? "") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                
            } else {
                if let img = cell.imgPasport.image{
                    let photo = ChatImage()
                    photo.image = img
                    
                    let photosViewController: NYTPhotosViewController = NYTPhotosViewController(photos: [photo])
                    present(photosViewController, animated: true, completion: nil)
                }
                
            }
        }
        
    }
    
    func base64Encode(_ input: String) -> String? {
        if let inputData = input.data(using: .utf8) {
            return inputData.base64EncodedString()
        }
        return nil
    }
    
}
  
class PolicyDetailTblcell: UITableViewCell {
    
    @IBOutlet weak var lblBenefits: UILabel!
}

class FirstPolicyDetailCell: UITableViewCell {
    
    @IBOutlet weak var lblPolicyNo: UILabel!
    @IBOutlet weak var lblPolicyType: UILabel!
    @IBOutlet weak var lblPolicyName: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblDEstination: UILabel!
    @IBOutlet weak var lblPassportId: UILabel!
    @IBOutlet weak var lblDateofbith: UILabel!
    @IBOutlet weak var lblEffectiveDate: UILabel!
    @IBOutlet weak var lblExpireDate: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblNoDays: UILabel!
    @IBOutlet weak var lblZoneCoverage: UILabel!
    @IBOutlet weak var lblBoraderEntry: UILabel!
    @IBOutlet weak var lblVisitType: UILabel!
    @IBOutlet weak var lblVisaType: UILabel!
    @IBOutlet weak var lblRNo: UILabel!
    @IBOutlet weak var lblRDate: UILabel!
    @IBOutlet weak var lblRDuration: UILabel!
    @IBOutlet weak var lblRreason: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblNationality: UILabel!
    @IBOutlet weak var imgPassport: UIImageView!
    @IBOutlet weak var lblPolicyStatus: UILabel!
    
    @IBOutlet weak var btnDownlaodPolicy: UIButton!
    @IBOutlet weak var btnDownloadInvoice: UIButton!
    
    @IBOutlet weak var viewBoraderEntry: UIView!
    @IBOutlet weak var viewVisitType: UIView!
    @IBOutlet weak var viewVisaType: UIView!
    @IBOutlet weak var viewRNo: UIView!
    @IBOutlet weak var viewRDate: UIView!
    @IBOutlet weak var viewRDuration: UIView!
    @IBOutlet weak var viewRReason: UIView!
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblPerson: UILabel!
    
    @IBOutlet weak var btnShowImg: UIButton!
    @IBOutlet weak var lblPaymentTyp: UILabel!
    
    @IBOutlet weak var lblClaimStatus: UILabel!
    @IBOutlet weak var viewClaimStatus: UIView!
    
    @IBOutlet weak var viewClaimPolicy: UIView!
    @IBOutlet weak var btnClaim: UIButton!
    
    var delegateOnClaim: onClaimActionDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func clickedClaim(_ sender: UIButton) {
        delegateOnClaim?.clickedOnClaim(sender.tag)
    }
    
}

class SecondPolicyDetailCell: UITableViewCell {
    
    @IBOutlet weak var lblPolicyNo: UILabel!
    @IBOutlet weak var lblPlanName: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblPassport: UILabel!
    @IBOutlet weak var lblDateOf: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgPasport: UIImageView!
    @IBOutlet weak var lblPolicyStatus: UILabel!
    
    @IBOutlet weak var btnDownlaodPolicy: UIButton!
    @IBOutlet weak var btnDownloadInvoice: UIButton!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblPerson: UILabel!
    
    @IBOutlet weak var lblShowImg: UIButton!
    @IBOutlet weak var lblPaymentType: UILabel!
    @IBOutlet weak var lblNationality: UILabel!
    
    @IBOutlet weak var lblEffectivedate: UILabel!
    @IBOutlet weak var lblExpireDate: UILabel!
    
    @IBOutlet weak var viewClaimStatus: UIView!
    @IBOutlet weak var lblClamStatus: UILabel!
    
    @IBOutlet weak var viewClaim: UIView!
    @IBOutlet weak var btnClaim: UIButton!
    
    var delegateOnClaim: onClaimActionDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func clickedClaim(_ sender: UIButton) {
        delegateOnClaim?.clickedOnClaim(sender.tag)
    }
    
}
