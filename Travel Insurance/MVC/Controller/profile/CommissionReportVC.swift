//
//  CommissionReportVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 09/02/24.
//

import UIKit

class CommissionReportVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var viewFilter: UIView!
    @IBOutlet weak var viewInsurance: UIView!
    @IBOutlet weak var viewAmount: UIView!
    @IBOutlet weak var viewCommission: UIView!
    @IBOutlet weak var tblViewReport: UITableView!
    
    @IBOutlet weak var txtPoliceNo: UITextField!
    @IBOutlet weak var txtSDate: UITextField!
    @IBOutlet weak var txtEDate: UITextField!
    
    @IBOutlet weak var lblTotalInsu: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblTotalCommission: UILabel!
    
    @IBOutlet weak var lblNoData: UILabel!
    
    var arrReportList: [TIReportData] = [TIReportData]()
    
    let datePikerSDate = UIDatePicker()
    let datePikerEDate = UIDatePicker()
    
    var strOpneDate = ""
    
    var objTotalEntitlement = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblViewReport.delegate = self
        tblViewReport.dataSource = self
        
        viewFilter.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 18, spread: 0)
        viewInsurance.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 18, spread: 0)
        viewAmount.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 18, spread: 0)
        viewCommission.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 18, spread: 0)
       
        callAgentCommissionAPI(start_date: "", end_date: "", policy_no: "", isFilter: false)
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickedSearch(_ sender: Any) {
        callAgentCommissionAPI(start_date: txtSDate.text ?? "", end_date: txtEDate.text ?? "", policy_no: self.txtPoliceNo.text ?? "", isFilter: true)
    }
    
    @IBAction func clickedReset(_ sender: Any) {
        
        txtSDate.text = ""
        txtEDate.text = ""
        txtPoliceNo.text = ""
        
        callAgentCommissionAPI(start_date: "", end_date: "", policy_no: "", isFilter: false)
    }
    
    @IBAction func clickedSDate(_ sender: UITextField) {
        strOpneDate = "SDate"
        datePikerSDate.datePickerMode = .date
        datePikerSDate.maximumDate = Date()
        datePikerSDate.preferredDatePickerStyle = .wheels
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(donedatePickerSDate));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePickerSdate));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        sender.inputAccessoryView = toolbar
        sender.inputView = datePikerSDate
    }
    @IBAction func clickedEDate(_ sender: UITextField) {
        strOpneDate = "EDate"
        datePikerEDate.datePickerMode = .date
        datePikerEDate.minimumDate = datePikerSDate.date
        datePikerEDate.preferredDatePickerStyle = .wheels
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(donedatePickerSDate));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePickerSdate));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        sender.inputAccessoryView = toolbar
        sender.inputView = datePikerEDate
    }
    
    @objc func donedatePickerSDate(){
        if strOpneDate == "SDate"
        {
            txtEDate.text = ""
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            txtSDate.text = formatter.string(from: datePikerSDate.date)
            self.view.endEditing(true)
        }
        else if strOpneDate == "EDate"
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            txtEDate.text = formatter.string(from: datePikerEDate.date)
            self.view.endEditing(true)
        }
    }
    
    @objc func cancelDatePickerSdate(){
        self.view.endEditing(true)
    }
    
    
    //MARK: - API Calling
    
    func callAgentCommissionAPI(start_date:String, end_date:String,policy_no:String, isFilter: Bool)
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["":""]
        
        let _url = "?start_date=\(start_date)&end_date=\(end_date)&policy_no=\(policy_no)"
        
        var APIURL = ""
        
        if isFilter == true
        {
            APIURL = AGENTCOMMISION + _url
        }
        else
        {
            APIURL = AGENTCOMMISION
        }
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(APIURL, parameters: param) { response, error, statusCode in
            
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
                        self.arrReportList.removeAll()
                        if let dicResponse = response?.value(forKey: "response") as? NSDictionary
                        {
                            if let arrData = dicResponse.value(forKey: "data") as? NSArray
                            {
                                for objData in arrData
                                {
                                    let dicData = TIReportData(fromDictionary: objData as! NSDictionary)
                                    
                                    if dicData.transectionStatus[0].status == "success" || dicData.transectionStatus[0].status == "cancel request" {
                                        self.arrReportList.append(dicData)
                                    }
                                }
                            }
//                            self.arrReportList = self.arrReportList.reversed()
                            
                            if self.arrReportList.count > 0
                            {
                                self.lblNoData.isHidden = true
                                self.tblViewReport.isHidden = false
                            }
                            else
                            {
                                self.lblNoData.isHidden = false
                                self.tblViewReport.isHidden = true
                            }
                            
                            let totalCommisionAmount = dicResponse.value(forKey: "totalCommisionAmount") as? Double ?? 0.0
                            let total_paid_amount = dicResponse.value(forKey: "total_paid_amount") as? Double ?? 0.0
                            let total_insurances = dicResponse.value(forKey: "total_insurances") as? Int
                            let formattedString = String(format: "%.2f", total_paid_amount)
                            let formattedString1 = String(format: "%.2f", totalCommisionAmount)

                            self.objTotalEntitlement = Int(formattedString1) ?? 0
                            
                            self.lblTotalInsu.text = "\(self.arrReportList.count)"
                            self.lblTotalAmount.text = "\(formattedString)"
                            
                            self.lblTotalCommission.text = formattedString1
                            
                            self.tblViewReport.reloadData()
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
                    
                    self.setUpMakeToast(msg: message ?? "")
                }
            }
            else
            {
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrReportList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblViewReport.dequeueReusableCell(withIdentifier: "ReportCell", for: indexPath) as! ReportCell
     
        let dicData = arrReportList[indexPath.row]
        
       // cell.lblTId.text = "\(dicData.txnId ?? "0")"
        cell.lblPName.text = dicData.plans.planType ?? ""
        
        cell.lblTId.text = dicData.transectionStatus[0].status ?? ""
        
        if dicData.paymentMethod == "1" {
            cell.lblPaymentType.text = "Credit/Debit Card"
        } else{
            cell.lblPaymentType.text = "Cash"
        }
        
        let agentPrice = Double(dicData.agentPrice ?? "") ?? 0.0
                
        var new_premiumAmount = 0.0
        var new_eintitlement = 0.0
        var new_diwanTax = 0.0
        
        for objAll in dicData.userinsurance {
            new_premiumAmount = new_premiumAmount + (Double(objAll.single_price ?? "") ?? 0.0)
            new_eintitlement = new_eintitlement + (Double(objAll.agent_commision ?? "") ?? 0.0)
            new_diwanTax = new_diwanTax + (Double(objAll.diwan_tax ?? "") ?? 0.0)
        }
        
        let formattedString5 = String(format: "%.2f", new_premiumAmount)

        cell.lblTAmount.text = "IQD \(formattedString5)"
        let formattedString1 = String(format: "%.2f", new_eintitlement)

        cell.lblMCmmiission.text = "\(dicData.currency ?? "") \(formattedString1)(\(dicData.userinsurance[0].agent_commision_percent ?? "")%)"

        
        let net_premium = (Double(new_premiumAmount)) - (Double(new_eintitlement))
        let new_net_premium = net_premium + (Double(new_diwanTax))

        print(net_premium)
        print(new_net_premium)
        
        let net_premium1 = String(format: "%.2f", new_net_premium)
        let formattedString2 = String(format: "%.2f", new_diwanTax)

        cell.lblTax.text = "IQD \(net_premium1)"
        cell.lblDiwanTax.text = "IQD \(formattedString2) (\(dicData.diwan_tax_percent ?? "")%)"

        if dicData.userinsuranceCount != 1 {
            cell.lblPId.text = "\(dicData.userinsurance[0].policyNo ?? "") (+\(dicData.userinsuranceCount-1))"
        } else {
            cell.lblPId.text = "\(dicData.userinsurance[0].policyNo ?? "")"
        }
        cell.lblTPerson.text = "\(dicData.userinsuranceCount ?? 0)"

        
        cell.lblTaDate.text = "\(dicData.transactionDate.prefix(10))"
        
        let bidAccepted = dicData.transactionDate ?? ""
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date1 = formatter.date(from: bidAccepted)
        let Dform = DateFormatter()
        Dform.dateFormat = "dd MMM yyyy"
        let strDate = Dform.string(from: date1!)
        cell.lblTaDate.text = strDate
        
        
        cell.cellView.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 18, spread: 0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


class ReportCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var lblTId: UILabel!
    @IBOutlet weak var lblPName: UILabel!
    @IBOutlet weak var lblTAmount: UILabel!
    @IBOutlet weak var lblMCmmiission: UILabel!
    @IBOutlet weak var lblPId: UILabel!
    @IBOutlet weak var lblTPerson: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblTaDate: UILabel!
    @IBOutlet weak var lblPaymentType: UILabel!
    @IBOutlet weak var lblDiwanTax: UILabel!
    
}
