//
//  PolicyDetailVC.swift
//  Hamraa Insurance
//
//  Created by Purv on 21/03/24.
//

import UIKit
import DropDown

class PolicyDetailVC: UIViewController {

    @IBOutlet weak var lblValueEffectiveDate: UILabel!
    @IBOutlet weak var lblValueExpiryDate: UILabel!
    @IBOutlet weak var lblValueTimePeriod: UILabel!
    @IBOutlet weak var lblValueTotalPrice: UILabel!
    
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var tblView: UITableView!
   
    @IBOutlet weak var viewModiFied: UIView!
    
    @IBOutlet weak var viewEntitlement: UIView!
    @IBOutlet weak var viewPAyableAmount: UIView!
    
    @IBOutlet weak var viewDiwanTax: UIView!
    @IBOutlet weak var lblDiwanTax: UILabel!
    @IBOutlet weak var lblAgentId: UILabel!
    @IBOutlet weak var viewAgentID: UIView!
    
    var effectiveDate = ""
    var expiryDate = ""
    var timePeriod = ""
    
    var strId = 0
    var isAPICall = false
    var transection_detail_id = 0
    
    let dropDownContry = DropDown()
    var arrContry: [ContryCodeConversionRate] = [ContryCodeConversionRate]()
    var price = ""
    var isShowModi = false
    
    var dicCurrentModifyInsurance = TIModifyDetailData()
    
    var download_invoice_url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblAgentId.text = "#\(appDelegate?.dicCurrentUserData.agentCode ?? "")"
        
        if appDelegate?.dicCurrentUserData.roleId == 1 {
            viewEntitlement.isHidden = true
            viewPAyableAmount.isHidden = true
            
            viewAgentID.isHidden = true
        } else {
            viewEntitlement.isHidden = false
            viewPAyableAmount.isHidden = false
            viewAgentID.isHidden = false
        }
        
        if dicCurrentModifyInsurance.currentPolicy[0].plans.planTypeCategory.type.contains("Inbound-medical") == true {
            viewDiwanTax.isHidden = true
        } else {
            viewDiwanTax.isHidden = true
        }

        self.viewModiFied.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1), alpha: 1, x: 0, y: 0, blur: 17, spread: 0)
        
        let sumOfPrices = dicCurrentModifyInsurance.totalUSDPrice ?? 0.0
        
        let formattedString = String(format: "%.2f", sumOfPrices)
        
        lblValueTotalPrice.text = "\(dicCurrentModifyInsurance.requestDatapolicy.currencySymbol ?? "") \(formattedString)"
        lblValueTimePeriod.text = "IQD \(dicCurrentModifyInsurance.iQDAmount ?? "")"
        
        let agent_commision = Double(dicCurrentModifyInsurance.currentPolicy[0].agentCommisionPercent ?? "") ?? 0.0
        let iQDAmount = Double(dicCurrentModifyInsurance.iQDAmount ?? "") ?? 0.0
        
        let agentPrice = iQDAmount * agent_commision/100
        let formattedStringagentPrice = String(format: "%.2f", agentPrice)
        lblValueEffectiveDate.text = "\(dicCurrentModifyInsurance.currentPolicy[0].currency ?? "") \(formattedStringagentPrice)(\(agent_commision)%)"
        
        let diwan_tax = Double(dicCurrentModifyInsurance.currentPolicy[0].diwanTax ?? "") ?? 0.0
        let formattedStringdiwan_tax = String(format: "%.2f", diwan_tax)

        lblDiwanTax.text = "IQD \(formattedStringdiwan_tax) (\(dicCurrentModifyInsurance.currentPolicy[0].diwanTaxPercent ?? "")%)"
        
        let payableAmount = iQDAmount - agentPrice
        let new_payableAmount = payableAmount + diwan_tax
        
        let formattedStringpayableAmount = String(format: "%.2f", new_payableAmount)

        lblValueExpiryDate.text = "\(dicCurrentModifyInsurance.currentPolicy[0].currency ?? "") \(formattedStringpayableAmount)"
        
        tblView.delegate = self
        tblView.dataSource = self
      
        // Do any additional setup after loading the view.
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
   
    
    @IBAction func clickedNext(_ sender: Any) {
        
        if dicCurrentModifyInsurance.currentPolicy[0].getTransection.paymentMethod == "1" {
            
            let agent_commision = Double(dicCurrentModifyInsurance.currentPolicy[0].agentCommision ?? "") ?? 0.0
            let iQDAmount = Double(dicCurrentModifyInsurance.iQDAmount ?? "") ?? 0.0
            let diwan_tax = Double(dicCurrentModifyInsurance.currentPolicy[0].diwanTax ?? "") ?? 0.0
            
            let agentPrice = iQDAmount * agent_commision/100
            
            let payableAmount = iQDAmount - agentPrice
            let new_payableAmount = payableAmount + diwan_tax
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaymentDoneVC") as! PaymentDoneVC
            vc.transactionDetailsId = dicCurrentModifyInsurance.transactionDetailsId ?? 0
            vc.iQDAmount = Int(new_payableAmount)
            vc.isModify = true
            vc.policy_start_date = dicCurrentModifyInsurance.requestDatapolicy.policyStartDate ?? ""
            vc.policy_end_date = dicCurrentModifyInsurance.requestDatapolicy.policyEndDate ?? ""
            vc.time_period = dicCurrentModifyInsurance.requestDatapolicy.timePeriod ?? ""
            vc.currencySymbol = dicCurrentModifyInsurance.requestDatapolicy.currencySymbol ?? ""
            vc.user_insurance_id = dicCurrentModifyInsurance.requestDatapolicy.userInsuranceId ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else {
            callCashPaymentModifyAPI()
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
    
    
    func generateRandomHexString(length: Int) -> String {
        let characters = "0123456789abcdef"
        var result = ""

        for _ in 0..<length {
            if let randomCharacter = characters.randomElement() {
                result.append(randomCharacter)
            }
        }
        return result
    }
    
    func callCashPaymentModifyAPI() {
            
        APIClient.sharedInstance.showIndicator()
        
        let transaction_details_id = "\(dicCurrentModifyInsurance.transactionDetailsId ?? 0)"
        let policy_start_date = dicCurrentModifyInsurance.requestDatapolicy.policyStartDate ?? ""
        let policy_end_date = dicCurrentModifyInsurance.requestDatapolicy.policyEndDate ?? ""
        let reason = dicCurrentModifyInsurance.requestDatapolicy.reason ?? ""
        let time_period = dicCurrentModifyInsurance.requestDatapolicy.timePeriod ?? ""
        let currencySymbol = dicCurrentModifyInsurance.requestDatapolicy.currencySymbol ?? ""
        let order_status = "success"
        let user_insurance_id = dicCurrentModifyInsurance.requestDatapolicy.userInsuranceId ?? 0
        let txn_id = generateRandomHexString(length: 32)
        
        let param = ["transaction_details_id":"\(transaction_details_id)","order_status":order_status,"txn_id":txn_id,"currency":"IQD","card_type":"Card","payment_response":"Card","payment_method":"2","policy_start_date":policy_start_date,"policy_end_date":policy_end_date,"time_period":time_period,"currencySymbol":currencySymbol,"user_insurance_id":"\(user_insurance_id)"]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(SINGLE_EXTENDPOLICY_PAYMENT, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil {
                APIClient.sharedInstance.hideIndicator()
                
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200 {
                    
                    if let status = response?.value(forKey: "status") as? Int, status == 1 {
                        
                        let url = response?.value(forKey: "url") as? String
                        let insuranceReport = response?.value(forKey: "insuranceReport") as? String
                        
                        let mainS = UIStoryboard(name: "Main", bundle: nil)
                        let vc = mainS.instantiateViewController(withIdentifier: "OrderPlacedViewController") as! OrderPlacedViewController
                        vc.isOpen = true
                        vc.Invoiceurl = url ?? ""
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
}

extension PolicyDetailVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        if dicCurrentModifyInsurance.currentPolicy.count > 0 {
            return dicCurrentModifyInsurance.currentPolicy.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "ModiyFirstPersonCell") as! ModiyFirstPersonCell
            
            cell.viewMain.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1), alpha: 1, x: 0, y: 0, blur: 17, spread: 0)

            let dicData = dicCurrentModifyInsurance.currentPolicy[indexPath.section]
                        
            cell.lblTitl.text = "Traveler 1"
            
            cell.lblPlanType.text = dicData.plans.planTypeCategory.name ?? ""
            
            cell.lblPlanName.text = dicData.plans.planType ?? ""
            
            cell.lblNationality.text = dicData.nationality ?? ""
            
            cell.lblFullName.text = dicData.fullName ?? ""
            cell.lblDestination.text = dicData.destination ?? ""
            cell.lblPassportIf.text = dicData.passportNumber ?? ""
            cell.lblNumber.text = "\(dicData.countryCode ?? "") \(dicData.mobileNumber ?? "")"
            cell.lblNationality.text = dicData.nationality ?? ""

            cell.lblDOB.text = dicData.dateOfBirth ?? ""
            
            cell.lblZone.text = dicCurrentModifyInsurance.currentPolicy[0].zone ?? ""
            cell.lblEmail.text = dicData.email ?? ""
            
            cell.lblPoicyNo.text = dicData.policyNo ?? ""
            
            let dicData_policy = dicCurrentModifyInsurance
            
            if dicData.convertedAmount != dicData_policy.currentPolicy[0].totalPrice {

                let convertedAmount = Double(dicData.convertedAmount ?? "") ?? 0.0
                let formattedString = String(format: "%.2f", convertedAmount)
                
                let price = dicCurrentModifyInsurance.totalUSDPrice ?? 0.0
                let formattedString1 = String(format: "%.2f", price)

                cell.lblPrimumAmount.text = "\(dicData.currency ?? "") \(formattedString1)"
                
                let totalPrice = "\(dicData.currency ?? "") \(formattedString)"
                let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: totalPrice)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
                
                cell.lblSPremiumAmount.attributedText = attributeString
                
            } else {
                
                cell.lblSPremiumAmount.isHidden = true
                
                let convertedAmount = Double(dicData.convertedAmount ?? "") ?? 0.0
                let formattedString = String(format: "%.2f", convertedAmount)
                
                cell.lblPrimumAmount.text = "\(dicData.currency ?? "") \(formattedString)"
            }
            
            
            if dicData.getTransection.paymentMethod == "1" {
                cell.lblPaymentType.text = "Credit/Debit Card"
                
            } else {
                cell.lblPaymentType.text = "Cash"
                
            }
            
            if dicData.plans.planTypeCategory.name.uppercased().contains("(VISA)") == true {
                
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
            } else if dicData.plans.planTypeCategory.name.uppercased().contains("(RESIDENTS)") == true {
                
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
                    
                    cell.lblReason.text = dicData.residenceReason ?? ""
                    cell.viewRReason.isHidden = false
                } else {
                    cell.viewRReason.isHidden = true
                }
                
                cell.viewVisitType.isHidden = true
                cell.viewVisaType.isHidden = true
                
            } else if dicData.plans.planTypeCategory.type.contains("Inbound-medical") == true {
                
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
                    
                    cell.lblReason.text = dicData.residenceReason ?? ""
                    cell.viewRReason.isHidden = false
                } else {
                    cell.viewRReason.isHidden = true
                }
                
                if dicData.visitType != "" {
                    
                    cell.lblVisitType.text = dicData.visitType ?? ""
                    cell.viewVisitType.isHidden = false
                } else {
                    cell.viewVisitType.isHidden = true
                }
                
                cell.viewVisaType.isHidden = false
                cell.viewRReason.isHidden = true
                
                cell.lblVisaType.text = dicData.visaType ?? ""
                cell.lblVisitType.text = dicData.visitType ?? ""
                
            } else {
                cell.viewRReason.isHidden = true
                cell.viewRDuration.isHidden = true
                cell.viewRDate.isHidden = true
                cell.viewRNo.isHidden = true
                cell.viewVisitType.isHidden = true
                cell.viewVisaType.isHidden = true
            }
            
            if dicData.borderEntry != "" {
                
                cell.lblBoarderEntry.text = dicData.borderEntry ?? ""
                cell.viewBoarderEntry.isHidden = false
            } else {
                cell.viewBoarderEntry.isHidden = true
            }
            
            
            let policyStartDate = dicData_policy.currentPolicy[0].policyStartDate ?? ""
            let policyEndDate = dicData_policy.currentPolicy[0].policyEndDate ?? ""
            
            let attributedSDate = NSMutableAttributedString(string: policyStartDate)
            let attributedEDate = NSMutableAttributedString(string: policyEndDate)
            
            attributedSDate.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: policyStartDate.count))
            attributedEDate.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: policyEndDate.count))
         
            cell.lblSEffectiveDate.attributedText = attributedSDate
            cell.lblSExpireDate.attributedText = attributedEDate
            
            cell.lblEffectiveDate.text = dicData_policy.data.policyStartDate ?? ""
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let startDate = dateFormatter.date(from: policyStartDate)!
            
            let timePeriod = Int(dicData_policy.requestDatapolicy.timePeriod ?? "") ?? 0
            
            let get_time = Calendar.current.date(byAdding: .day, value: timePeriod-1, to: startDate)!
            
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: get_time)
            
            cell.lblExpireDate.text = dicData_policy.data.policyEndDate ?? ""
            
            if dicData_policy.currentPolicy[0].timePeriod ?? "" == dicData_policy.requestDatapolicy.timePeriod ?? "" {
                
                cell.lblDays.text = "\(dicData_policy.currentPolicy[0].timePeriod ?? "") days"
                
                cell.lblSDays.isHidden = true
            } else {
                
                let timePeriod = "\(dicData_policy.currentPolicy[0].timePeriod ?? "")"
                
               
                let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: timePeriod)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
                
                let new_timePeriod = NSMutableAttributedString(string: dicData_policy.requestDatapolicy.timePeriod ?? "")
                
                cell.lblDays.text = "\(dicData_policy.requestDatapolicy.timePeriod ?? "") days"
                
                cell.lblSDays.attributedText = attributeString
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
            
            cell.btnViewDoc.tag = indexPath.section
            cell.btnViewDoc.addTarget(self, action: #selector(clickedViewReport(_:)), for: .touchUpInside)
            
            return cell
        }
        else
        {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "SecondPersonCell") as! SecondPersonCell
            
            cell.viewMain.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1), alpha: 1, x: 0, y: 0, blur: 17, spread: 0)
            
            let dicData = dicCurrentModifyInsurance.currentPolicy[indexPath.section]
            let dicAll = dicCurrentModifyInsurance.currentPolicy[0]
            
            cell.lblPerson.text = "Traveler \(indexPath.section+1)"
            
            cell.lblFName.text = dicData.fullName ?? ""
            cell.lblGender.text = dicData.email ?? ""
            cell.lblPassportIf.text = dicData.passportNumber ?? ""
            cell.lblDOB.text = dicData.dateOfBirth ?? ""
            cell.lblNationality.text = dicData.nationality ?? ""
            
            let strPrice = Double(dicData.convertedAmount ?? "") ?? 0.0
            let formattedString = String(format: "%.2f", strPrice)
            
            if dicAll.getTransection.paymentMethod == "1" {
                cell.lblPaymentType.text = "Credit/Debit Card"
                
            } else {
                cell.lblPaymentType.text = "Cash"
                
            }
            
            let dicData_policy = dicCurrentModifyInsurance
            
            if dicData.convertedAmount != dicData_policy.currentPolicy[0].totalPrice {

                let convertedAmount = Double(dicData.convertedAmount ?? "") ?? 0.0
                let formattedString = String(format: "%.2f", convertedAmount)
                
                let price = dicData_policy.formattedPriceData[indexPath.section].price ?? 0.0
                let formattedString1 = String(format: "%.2f", price)

                cell.lblPrice.text = "\(dicData.currency ?? "") \(formattedString1)"
                
                let totalPrice = "\(dicData.currency ?? "") \(formattedString)"
                let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: totalPrice)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
                
                cell.lblSPrice.attributedText = attributeString
                
            } else {
                
                cell.lblSPrice.isHidden = true
                
                let convertedAmount = Double(dicData.convertedAmount ?? "") ?? 0.0
                let formattedString = String(format: "%.2f", convertedAmount)
                
                cell.lblPrice.text = "\(dicData.currency ?? "") \(formattedString)"
            }
            
            cell.lblPN.text = dicData.policyNo ?? ""
            
            cell.viewIr.isHidden = true

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
            cell.btnViewReport.tag = indexPath.section
            cell.btnViewReport.addTarget(self, action: #selector(clickedViewReport(_:)), for: .touchUpInside)
            
            return cell
        }
    }
    
    @objc func imageTapped(str: UITapGestureRecognizer)
    {
        let dicData = dicCurrentModifyInsurance.currentPolicy[str.view!.tag]
        
        if let url = URL(string: dicData.passportCopy ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return UITableView.automaticDimension
        }else{
            return UITableView.automaticDimension
        }
    }
    
    @objc func clickedViewReport(_ sender: UIButton)
    {
        let transactionDetailsId = "\(self.dicCurrentModifyInsurance.currentPolicy[0].transactionDetailsId ?? 0)"
        
        print("ORDER_ID: \(download_invoice_url)\(transactionDetailsId)")
        
        if let url = URL(string: "\(download_invoice_url)\(transactionDetailsId)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    func base64Encode(_ input: String) -> String? {
        if let inputData = input.data(using: .utf8) {
            return inputData.base64EncodedString()
        }
        return nil
    }
    
}

class ModiyFirstPersonCell: UITableViewCell {
    
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var lblTitl: UILabel!
    @IBOutlet weak var lblPoicyNo: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblPassportIf: UILabel!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var lblEffectiveDate: UILabel!
    @IBOutlet weak var lblSEffectiveDate: UILabel!
    @IBOutlet weak var lblExpireDate: UILabel!
    @IBOutlet weak var lblSExpireDate: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblDays: UILabel!
    @IBOutlet weak var lblSDays: UILabel!
    @IBOutlet weak var lblZone: UILabel!
    @IBOutlet weak var lblPrimumAmount: UILabel!
    @IBOutlet weak var lblSPremiumAmount: UILabel!
    @IBOutlet weak var lblNationality: UILabel!
    
    @IBOutlet weak var imgPassport: UIImageView!
    @IBOutlet weak var btnViewDoc: UIButton!
    
    @IBOutlet weak var lblPlanType: UILabel!
    @IBOutlet weak var lblPlanName: UILabel!
    @IBOutlet weak var lblBoarderEntry: UILabel!
    @IBOutlet weak var lblVisitType: UILabel!
    @IBOutlet weak var lblVisaType: UILabel!
    @IBOutlet weak var lblRNo: UILabel!
    @IBOutlet weak var lblRDate: UILabel!
    @IBOutlet weak var lblRDuration: UILabel!
    @IBOutlet weak var lblReason: UILabel!
    @IBOutlet weak var lblPaymentType: UILabel!
    
    @IBOutlet weak var viewBoarderEntry: UIView!
    @IBOutlet weak var viewVisitType: UIView!
    @IBOutlet weak var viewVisaType: UIView!
    @IBOutlet weak var viewRNo: UIView!
    @IBOutlet weak var viewRDate: UIView!
    @IBOutlet weak var viewRDuration: UIView!
    @IBOutlet weak var viewRReason: UIView!
    
    
    
    
    
    
}
