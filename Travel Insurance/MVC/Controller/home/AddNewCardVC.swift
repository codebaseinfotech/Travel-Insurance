//
//  AddNewCardVC.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 01/11/23.
//

import UIKit
import DropDown



class AddNewCardVC: UIViewController, MonthDate, YearDate {

    @IBOutlet weak var txtCardHolderName: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtMonth: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var txtCvv: UITextField!
    
    @IBOutlet weak var imgCreditCard: UIImageView!
    @IBOutlet weak var imgDebitCard: UIImageView!
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var lblCardType: UILabel!
    @IBOutlet weak var viewCrdType: UIView!
    
    @IBOutlet weak var btnPay: UIButton!
    
    var price = ""
    var strCardType = ""
    var strMonth = ""
    var strYear = ""
    var dicOrderData = TIFormListData()
    let dropDownGenders = DropDown()
    var policyStartDate = ""
    var policyEndDate = ""
    var timePeriod = ""
    var transactionDetailsId = ""
    var isModiyInsurance = 0
    var arrCarfType = ["VISA","MASTER","AFTERPAY","AIRPLUS","ALIA","ALIADEBIT","AMEX","APPLEPAYTKN","ARGENCARD","AXP","CABAL","CABALDEBIT","CARNET","CARTEBANCAIRE","CARTEBLEUE","CASEYS_GIFT_CARD","CASHLINKMALTA","CENCOSUD","CLICK_TO_PAY","CLIQ","DANKORT","DINERS","DIRECTDEBIT_SEPA","DISCOVER","ELO","GOOGLEPAY","HEB_GIFT_CARD","HIPERCARD","JCB","MADA","MAESTRO","MASTERDEBIT","MERCADOLIVRE","NARANJA","NATIVA","PETCO_GIFT_CARD","PETCO_MASTERCARD","PETCO_UPLCC","POSTPAY","PREPAYMENT_VRP","RATEPAY_INVOICE","SCHEELS","SEPA","SERVIRED","SIBS_MULTIBANCO","STAPLES","TARJETASHOPPING","TCARD","TCARDDEBIT","TRADE_UK","UNIONPAY","VALU","VISASADEBIT","VISAELECTRON","VPAY"]
    
    let order_status = ""
    
    let provider = OPPPaymentProvider(mode: OPPProviderMode.live)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let checkoutSettings = OPPCheckoutSettings()

        // Set available payment brands for your shop
        checkoutSettings.paymentBrands = ["VISA", "DIRECTDEBIT_SEPA"]

        // Set shopper result URL
       // checkoutSettings.shopperResultURL = "com.companyname.appname.payments://result"
        checkoutSettings.shopperResultURL = "com.wayak.travelinsurance.TravelInsurance.payments://result"
        
        strCardType = "Credit Card"
        imgCreditCard.isHidden = false
        imgDebitCard.isHidden = true
        
        viewMain.clipsToBounds = true
        viewMain.layer.cornerRadius = 15
        viewMain.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner

        setDropDownCT()
        
        let currency_symbol = UserDefaults.standard.value(forKey: "currency_symbol") as? String
        if isModiyInsurance == 1 {
            btnPay.setTitle("Pay \(self.price)", for: .normal)
        }
        else
        {
            btnPay.setTitle("Pay \(appDelegate?.objContryCodeConversionRate.abbreviation ?? "") \(dicOrderData.order.totalPrice ?? "")", for: .normal)
        }
        
        // Do any additional setup after loading the view.
    }
    
    func onMonthYear(str: String) {
        txtMonth.text = "\(str.components(separatedBy: " ")[0])"
    }
    
    func onYear(str: String) {
        txtYear.text = str
    }
    //MARK: - DropDown For Gender
    func setDropDownCT()
    {
        dropDownGenders.dataSource = arrCarfType
        dropDownGenders.anchorView = viewCrdType
        dropDownGenders.direction = .bottom
        
        dropDownGenders.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.lblCardType.text = item
        }
        
        dropDownGenders.bottomOffset = CGPoint(x: 0, y: viewCrdType.bounds.height)
        dropDownGenders.topOffset = CGPoint(x: 0, y: -viewCrdType.bounds.height)
        dropDownGenders.dismissMode = .onTap
        dropDownGenders.textColor = .black
        dropDownGenders.backgroundColor = UIColor(red: 255/255, green:  255/255, blue:  255/255, alpha: 1)
        dropDownGenders.selectionBackgroundColor = UIColor.clear
        dropDownGenders.reloadAllComponents()
    }
    
    
    @IBAction func clickedMonth(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectMonthVC") as! SelectMonthVC
        vc.modalPresentationStyle = .overFullScreen
        vc.delegateOn = self
        self.present(vc, animated: false)
    }
    
    @IBAction func ClickedYear(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectYearVC") as! SelectYearVC
        vc.modalPresentationStyle = .overFullScreen
        vc.delegateOn = self
        self.present(vc, animated: false)
    }
    
    @IBAction func clickedDebitCard(_ sender: Any) {
        strCardType = "Debit Card"
        
        imgDebitCard.isHidden = false
        imgCreditCard.isHidden = true
    }
    @IBAction func clickedCreditCard(_ sender: Any) {
        strCardType = "Credit Card"
        
        imgCreditCard.isHidden = false
        imgDebitCard.isHidden = true
    }
    
    @IBAction func clickedMakePayment(_ sender: Any) {
        self.setUpHideMakeToast()
        if lblCardType.text == "Select card type"
        {
            self.setUpMakeToast(msg: "Select card type")
        }
        else if txtCardHolderName.text == ""
        {
            self.setUpMakeToast(msg: "Enter card holder name")
        }
        else if txtCardNumber.text == ""
        {
            self.setUpMakeToast(msg: "Enter card number")
        }
        else if txtMonth.text == ""
        {
            self.setUpMakeToast(msg: "Enter valid Month")
        }
        else if txtMonth.text == "01"
        {
            self.setUpMakeToast(msg: "Invalid Month")
        }
        else if txtMonth.text == "02"
       {
           self.setUpMakeToast(msg: "Invalid Month")
       }
        else if txtYear.text == ""
        {
            self.setUpMakeToast(msg: "Enter valid Year")
        }
        else if txtCvv.text == ""
        {
            self.setUpMakeToast(msg: "Enter cvv")
        }
        else if (txtCvv.text?.count ?? 0) < 3
        {
            self.setUpMakeToast(msg: "Enter valid cvv")
        }
        else
        {
            if isModiyInsurance == 1 {
                callPaymentModify()
            }
            else
            {
                callAddCardAPI(id: self.dicOrderData.order.transactionDetailsId ?? 0)
            }
            
        }
    }
    @IBAction func clikedclose(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    @IBAction func clickedCardType(_ sender: Any) {
        dropDownGenders.show()
    }
    
    //MARK: - callPaymentModify
    func callPaymentModify()
    {
        APIClient.sharedInstance.showIndicator()
       
        let card_number = self.txtCardNumber.text?.replacingOccurrences(of: " ", with: "")
        
//        if let strMonthYear = self.txtValid.text?.components(separatedBy: "/")
//        {
//            if (strMonthYear.count) > 1
//            {
//
        
        self.strMonth = txtMonth.text ?? ""
        self.strYear = txtYear.text ?? ""
//            }
//        }
        
        
        let parm = ["cardholder_name":"\(txtCardHolderName.text ?? "")", "card_number":"\(card_number ?? "")", "expiry_month":"\(strMonth)", "expiry_year":"\(strYear)", "cvv":"\(txtCvv.text ?? "")", "policy_start_date":"\(policyStartDate)", "policy_end_date":"\(policyEndDate)", "time_period":"\(timePeriod)", "currencySymbol": appDelegate?.objContryCodeConversionRate.abbreviation ?? "", "transaction_details_id":"\(transactionDetailsId)","cardtype":"\(self.lblCardType.text ?? "")"]
        
        print(parm)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(PAYMENTMODIFY, parameters: parm) { response, error, statusCode in
            
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
                        self.setUpMakeToast(msg: message ?? "")
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PolicyModifiedVC") as! PolicyModifiedVC
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
                let message = response?.value(forKey: "message") as? String
                
                APIClient.sharedInstance.hideIndicator()
                self.setUpMakeToast(msg: message ?? "")
            }
        }
    }
    // MARK: - calling API
    
    func callAddCardAPI(id: Int)
    {
        APIClient.sharedInstance.showIndicator()
        
        let currency_symbol = UserDefaults.standard.value(forKey: "currency_symbol") as? String
        
        let card_type = self.lblCardType.text ?? ""
        
        let card_number = self.txtCardNumber.text?.replacingOccurrences(of: " ", with: "")
        
//        if let strMonthYear = self.txtValid.text?.components(separatedBy: "/")
//        {
//            if (strMonthYear.count) > 1
//            {
                self.strMonth = txtMonth.text ?? ""
                self.strYear = txtYear.text ?? ""
//            }
//        }
        
        let expiry_month = self.strMonth
        
        let expiry_year = self.strYear
        
        let card_holder_name = self.txtCardHolderName.text ?? ""
        
        let cvv = self.txtCvv.text ?? ""
        
        let currency = currency_symbol ?? ""
        
        let parm = ["card_type":"\(card_type)","card_number":"\(card_number ?? "")","expiry_month":"\(expiry_month)","expiry_year":"\(expiry_year)","cvv":"\(cvv)","card_holder_name":"\(card_holder_name)","currency":"\(currency)","order_status":self.dicOrderData.order.orderStatus ?? ""]
        
        let _url = "\(id)"
        
        print(parm)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(ORDER_INSURANCE + _url, parameters: parm) { response, error, statusCode in
            
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
                        arrPInsuranceSaving.removeAllObjects()
                        
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
                let message = response?.value(forKey: "message") as? String
                
                APIClient.sharedInstance.hideIndicator()
                self.setUpMakeToast(msg: message ?? "")
            }
        }
    }
}
