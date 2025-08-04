//
//  FormVC.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 31/10/23.
//

import UIKit
import DropDown
import MobileCoreServices
import ADCountryPicker
import NYTPhotoViewer
import libPhoneNumber_iOS
import AVFoundation

class FormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate, onSeachSelect {
    
    @IBOutlet weak var topOptionalMole: NSLayoutConstraint!//18
    @IBOutlet weak var HeightOptionMoile: NSLayoutConstraint! //78
    
    
    @IBOutlet weak var lblCurrency: UILabel!
    
    
    @IBOutlet weak var lblTitile: UILabel!
    
    
    @IBOutlet weak var txtEnterName: UITextField!
    
    @IBOutlet weak var txtEnterEmail: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    
    @IBOutlet weak var lblFlag: UILabel!
    
    
    @IBOutlet weak var txtEnterPassportId: UITextField!
    
    @IBOutlet weak var imgPassportImage: UIImageView!
    
    @IBOutlet weak var txtStatus: UILabel!
    @IBOutlet weak var viewMarital: UIView!
    
    
    @IBOutlet weak var lblNationality: UILabel!
    
   // @IBOutlet weak var lblGender: UILabel!
    
    @IBOutlet weak var viewBtn: UIView!
    
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var txtPolicy: UITextField!
    @IBOutlet weak var txtPolicyEDate: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewDuration: UIView!
    @IBOutlet weak var heightDurationView: NSLayoutConstraint! // 242
    @IBOutlet weak var viewB: UIView!
   // @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var NationalityButton: UIButton!
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewFTop: UIView!
    
    
    @IBOutlet weak var btnChangeDocumenu: UIButton!
    
    @IBOutlet weak var txtCountry: UITextField!
    
    @IBOutlet weak var imgPdf: UIImageView!
    @IBOutlet weak var viewUploadPic: UIView!
    
    @IBOutlet weak var imgOther: UIImageView!
    
    @IBOutlet weak var viewOptionalMobileNo: UIView!

    @IBOutlet weak var lblFlagOptional: UILabel!
    @IBOutlet weak var lblCountryCodeOptional: UITextField!
    @IBOutlet weak var txtOptionalMbile: UITextField!
    
    @IBOutlet weak var lblSelectCurrency: UILabel!
    
    @IBOutlet weak var viewBoarderEntry: UIView!
    @IBOutlet weak var viewVisatype: UIView!
    @IBOutlet weak var viewVisitType: UIView!
    @IBOutlet weak var viewRNo: UIView!
    @IBOutlet weak var viewReson: UIView!
    @IBOutlet weak var viewRDuration: UIView!
    @IBOutlet weak var viewRDate: UIView!
    
    @IBOutlet weak var txtBoarderEntry: UITextField!
    
    @IBOutlet weak var txtRNo: UITextField!
    
    @IBOutlet weak var txtRDuration: UITextField!
    @IBOutlet weak var txtRDate: UITextField!
    
    @IBOutlet weak var topBoarderEntry: NSLayoutConstraint! // 18
    @IBOutlet weak var heightBoarderEntry: NSLayoutConstraint! // 78
    
    @IBOutlet weak var topVisaType: NSLayoutConstraint!
    @IBOutlet weak var heightVisaType: NSLayoutConstraint!
    
    @IBOutlet weak var topVisitType: NSLayoutConstraint!
    @IBOutlet weak var heightVisitType: NSLayoutConstraint!
    
    @IBOutlet weak var topRNo: NSLayoutConstraint!
    @IBOutlet weak var heightRNo: NSLayoutConstraint!
    
    @IBOutlet weak var topReson: NSLayoutConstraint!
    @IBOutlet weak var heightReson: NSLayoutConstraint!
    
    @IBOutlet weak var topDuration: NSLayoutConstraint!
    @IBOutlet weak var heightDuration: NSLayoutConstraint!
    
    @IBOutlet weak var topDate: NSLayoutConstraint!
    @IBOutlet weak var heightRDate: NSLayoutConstraint!
    
    @IBOutlet weak var viewRR: UIView!
    @IBOutlet weak var lblReason: UILabel!
    
    @IBOutlet weak var txtVisaType: UILabel!
    @IBOutlet weak var txtVisitType: UILabel!
    
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var heightEmail: NSLayoutConstraint! // 78
    @IBOutlet weak var buttomEmail: NSLayoutConstraint! // 18
    
    @IBOutlet weak var viewGender: UIView!
    @IBOutlet weak var lblGender: UILabel!
    
    var arrPInsurance = NSMutableArray()
    var isSwitchImg = true
    var isUploasPassport = false
    var isUplaodPDF = false
    
    var UploadData = Data()
    let picker = ADCountryPicker()
    
    var selectedImg: String?
    var imagePicker: ImagePicker!
    
    var dicPlanDetails = TIPlanDetailsResponse()
    
    //Nationality
    let datePickerDOB = UIDatePicker()
    let datePickerPolicy = UIDatePicker()
    let datePickerPolicyEndDate = UIDatePicker()
    var pageCount = 0
    var strOpenDate = ""
    
    let datePickerRDate = UIDatePicker()
    
    var selectedTraveller = 0
    
    let dropDownGenders = DropDown()
    let dropDownGender = ["Male","Female"]
    
    let dropDownMarital = DropDown()
    let arrMarital = ["Single","Married","Divorced","Widowed","Other"]
    
    let dropDownCoverage = DropDown()
    let arrCoverage = ["Worldwide including USA","Worldwide excluding USA, Canada","Schengen Countries","Arab Gulf countries, Africa & Asia"]
    
    var planid = ""
    
    
    var strPeriod = 0
    var strDestination = ""
    var strZone = ""

    let dropDownContry = DropDown()
    var arrContry: [ContryCodeConversionRate] = [ContryCodeConversionRate]()
    
    let dropDownReason = DropDown()
    let dropDownVisa = DropDown()
    let dropDownVisit = DropDown()

    var strOpenCounty = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        lblTitile.text = "\(dicPlanDetails.planType ?? "")"
        
        if dicPlanDetails.planTypeCategory.name.contains("Non-visa") == true {
            
            viewBoarderEntry.isHidden = false
            topBoarderEntry.constant = 18
            heightBoarderEntry.constant = 78
            
            viewVisatype.isHidden = true
            topVisaType.constant = 0
            heightVisaType.constant = 0
            
            viewVisitType.isHidden = true
            topVisitType.constant = 0
            heightVisitType.constant = 0
            
            viewRNo.isHidden = true
            topRNo.constant = 0
            heightRNo.constant = 0
            
            viewReson.isHidden = true
            topReson.constant = 0
            heightReson.constant = 0
            
            viewRDuration.isHidden = true
            topDuration.constant = 0
            heightDuration.constant = 0
            
            viewRDate.isHidden = true
            topDate.constant = 0
            heightRDate.constant = 0
            
        } else if dicPlanDetails.planTypeCategory.name.contains("VISA") == true {
            
            viewBoarderEntry.isHidden = true
            topBoarderEntry.constant = 0
            heightBoarderEntry.constant = 0
            
            viewVisatype.isHidden = false
            topVisaType.constant = 18
            heightVisaType.constant = 78
            
            viewVisitType.isHidden = false
            topVisitType.constant = 18
            heightVisitType.constant = 78
            
            viewRNo.isHidden = true
            topRNo.constant = 0
            heightRNo.constant = 0
            
            viewReson.isHidden = true
            topReson.constant = 0
            heightReson.constant = 0
            
            viewRDuration.isHidden = true
            topDuration.constant = 0
            heightDuration.constant = 0
            
            viewRDate.isHidden = true
            topDate.constant = 0
            heightRDate.constant = 0
            
        } else if dicPlanDetails.planTypeCategory.name.contains("Residents") == true {
            
            viewBoarderEntry.isHidden = true
            topBoarderEntry.constant = 0
            heightBoarderEntry.constant = 0
            
            viewVisatype.isHidden = true
            topVisaType.constant = 0
            heightVisaType.constant = 0
            
            viewVisitType.isHidden = true
            topVisitType.constant = 0
            heightVisitType.constant = 0
            
            viewRNo.isHidden = false
            topRNo.constant = 18
            heightRNo.constant = 78
            
            viewReson.isHidden = false
            topReson.constant = 18
            heightReson.constant = 78
            
            viewRDuration.isHidden = false
            topDuration.constant = 18
            heightDuration.constant = 78
            
            viewRDate.isHidden = false
            topDate.constant = 18
            heightRDate.constant = 78
            
        }
        else if dicPlanDetails.planTypeCategory.type.contains("Inbound-medical") == true {
            
            viewOptionalMobileNo.isHidden = true
            topOptionalMole.constant = 0
            HeightOptionMoile.constant = 0
            
            viewBoarderEntry.isHidden = true
            topBoarderEntry.constant = 0
            heightBoarderEntry.constant = 0
            
            viewVisatype.isHidden = true
            topVisaType.constant = 0
            heightVisaType.constant = 0
            
            viewVisitType.isHidden = true
            topVisitType.constant = 0
            heightVisitType.constant = 0
            
            viewRNo.isHidden = true
            topRNo.constant = 0
            heightRNo.constant = 0
            
            viewRDate.isHidden = true
            topDate.constant = 0
            heightRDate.constant = 0
            
            viewRDuration.isHidden = true
            topDuration.constant = 0
            heightDuration.constant = 0
            
            viewReson.isHidden = true
            topReson.constant = 0
            heightReson.constant = 0
            
            viewDuration.isHidden = true
            topDuration.constant = 0
            heightDuration.constant = 0
            
           
            
            viewVisatype.isHidden = false
            topVisaType.constant = 18
            heightVisaType.constant = 78
            
            
            
        }
        else {
            
            viewBoarderEntry.isHidden = true
            topBoarderEntry.constant = 0
            heightBoarderEntry.constant = 0
            
            viewVisatype.isHidden = true
            topVisaType.constant = 0
            heightVisaType.constant = 0
            
            viewVisitType.isHidden = true
            topVisitType.constant = 0
            heightVisitType.constant = 0
            
            viewRNo.isHidden = true
            topRNo.constant = 0
            heightRNo.constant = 0
            
            viewReson.isHidden = true
            topReson.constant = 0
            heightReson.constant = 0
            
            viewRDuration.isHidden = true
            topDuration.constant = 0
            heightDuration.constant = 0
            
            viewRDate.isHidden = true
            topDate.constant = 0
            heightRDate.constant = 0
        }
        
        
        if appDelegate?.dicCurrentUserData.roleId == 1
        {
            txtEnterEmail.isUserInteractionEnabled = true
            
//            heightEmail.constant = 78
//            buttomEmail.constant = 18
//            viewEmail.isHidden = false
            
            heightEmail.constant = 0
         //   buttomEmail.constant = 0
            
            viewEmail.isHidden = true
            
            txtEnterName.text = appDelegate?.dicCurrentUserData.name ?? ""
            txtDOB.text = appDelegate?.dicCurrentUserData.dateOfBirth ?? ""
            txtEnterEmail.text = appDelegate?.dicCurrentUserData.email ?? ""
            
            if let arrSpit = appDelegate?.dicCurrentUserData.mobileNumber.components(separatedBy: " ")
            {
                if arrSpit.count > 0
                {
                    if arrSpit.count == 1
                    {
                        self.txtNumber.text = arrSpit[0] as? String
                    }
                    else if arrSpit.count == 2
                    {
                        self.txtCountry.text = arrSpit[0] as? String
                        
                        self.txtNumber.text = arrSpit[1] as? String
                    }
                }
            }
        }
        else
        {
            txtEnterEmail.isUserInteractionEnabled = true
            
            heightEmail.constant = 0
        //    buttomEmail.constant = 0
            
            viewEmail.isHidden = true
            txtEnterEmail.text = appDelegate?.dicCurrentUserData.email ?? ""
            
            if let arrSpit = appDelegate?.dicCurrentUserData.mobileNumber.components(separatedBy: " ")
            {
                if arrSpit.count > 0
                {
                    if arrSpit.count == 1
                    {
                      //  self.txtNumber.text = arrSpit[0] as? String
                    }
                    else if arrSpit.count == 2
                    {
                        self.txtCountry.text = arrSpit[0] as? String
                        
                       // self.txtNumber.text = arrSpit[1] as? String
                    }
                }
            }
        }
       
        do {
            let phoneNumberUtil = NBPhoneNumberUtil()
            let phoneNumber = try phoneNumberUtil.parse(appDelegate?.dicCurrentUserData.mobileNumber ?? "", defaultRegion: nil)
            
            if let countryCode = phoneNumberUtil.getRegionCode(forCountryCode: phoneNumber.countryCode ?? 0),
               let countryName = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: countryCode) {
                print("Country Name: \(countryName)")
                
                let country_Code = countryCodeDemo(forCountry: countryName ) ?? ""
                
                self.lblFlag.text = countryFlag(country_Code)
                
            } else {
                print("Country name not found for the given phone number.")
            }
        } catch {
            print("Error parsing phone number: \(error.localizedDescription)")
        }
        
        viewB.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.08), alpha: 1, x: 0, y: 0, blur: 18, spread: 0)
        
        viewDuration.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.06), alpha: 1, x: 0, y: 0, blur: 15, spread: 0)
        
//        viewTop.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 16, spread: 0)
        viewFTop.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 16, spread: 0)
        
        viewDuration.isHidden = true
        heightDurationView.constant = 0
        
        tblView.delegate = self
        tblView.dataSource = self
        
        //MARK: - All DropDown Function call
        setDropDownGender()
        
       // setDropDownMarital()
        
        
        self.callGetPriceAPI()
        
        setdropDownVisit()
        setdropDownVisa()
        setdropDownReason()
        // Do any additional setup after loading the view.
    }
    
    func onSelectText(text: String, isDestintion: Bool, id: Int) {
        if self.strDestination == text {
            self.setUpMakeToast(msg: "Please select nationality different from your destination")
        } else {
            self.lblNationality.text = text
        }
    }
    
    func countryCodeDemo(forCountry country: String) -> String? {
        let locale = Locale(identifier: "en_US")
        let countries = Locale.isoRegionCodes.compactMap { locale.localizedString(forRegionCode: $0) }
        let countryDict = Dictionary(uniqueKeysWithValues: zip(countries.map { $0.uppercased() }, Locale.isoRegionCodes))
        let countryCode = countryDict[country.uppercased()]
        return countryCode
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.callGetPriceAPI()
        callGetAllConversionRateAPI()
        arrPInsuranceSaving.removeAllObjects()
        self.arrPInsurance.removeAllObjects()
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
                                    self.lblSelectCurrency.text = "\(self.countryFlag(appDelegate?.objContryCodeConversionRate.abbreviation ?? "").prefix(1))   \(appDelegate?.objContryCodeConversionRate.abbreviation ?? "")"
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
        dropDownContry.anchorView = lblSelectCurrency
        dropDownContry.direction = .bottom
        
        dropDownContry.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.lblSelectCurrency.text = item
            
            for (indexz,obj) in self.arrContry.enumerated()
            {
                if indexz == index {
                    
                    self.lblSelectCurrency.text = "\(self.countryFlag(self.arrContry[index].abbreviation ?? "").prefix(1))   \(self.arrContry[index].abbreviation ?? "")"
                    
                    appDelegate?.objContryCodeConversionRate = obj
                    
                    self.callGetPriceAPI()
                }
                
            }
           
        }
        
        dropDownContry.bottomOffset = CGPoint(x: 0, y: lblSelectCurrency.bounds.height)
        dropDownContry.topOffset = CGPoint(x: 0, y: -lblSelectCurrency.bounds.height)
        dropDownContry.dismissMode = .onTap
        dropDownContry.textColor = .black
        dropDownContry.backgroundColor = .white
        dropDownContry.selectionBackgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)

        dropDownContry.reloadAllComponents()
    }
    
    func callGetPriceAPI()
    {
       // APIClient.sharedInstance.showIndicator()
        
        let parm = ["date_of_birth":self.txtDOB.text ?? "","no_of_days":"\(strPeriod)","plan_slug":dicPlanDetails.slug ?? ""]
        
        print(parm)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(GET_PRICE, parameters: parm) { response, error, statusCode in
            
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
                        
                        let dicResponse = response?.value(forKey: "response") as? NSDictionary
                        let price = dicResponse?.value(forKey: "price") as? String
                        
                        let strPrice = (Double(price ?? "") ?? 0.0) * (Double(appDelegate?.objContryCodeConversionRate.conversionRate ?? 0.0) ?? 0.0)
                        
                        let formattedString = String(format: "%.2f", strPrice)
                        
                        self.txtStatus.text = "\(appDelegate?.objContryCodeConversionRate.abbreviation ?? "") \(formattedString)"
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
    
    //MARK: - DropDown For Gender
    func setDropDownGender()
    {
        dropDownGenders.dataSource = dropDownGender
        dropDownGenders.anchorView = viewGender
        dropDownGenders.direction = .bottom

        dropDownGenders.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")

            self.lblGender.text = item
        }

        dropDownGenders.bottomOffset = CGPoint(x: 0, y: viewGender.bounds.height)
        dropDownGenders.topOffset = CGPoint(x: 0, y: -viewGender.bounds.height)
        dropDownGenders.dismissMode = .onTap
        dropDownGenders.textColor = .black
        dropDownGenders.backgroundColor = UIColor(red: 255/255, green:  255/255, blue:  255/255, alpha: 1)
        dropDownGenders.selectionBackgroundColor = UIColor.clear
        dropDownGenders.reloadAllComponents()
    }

    //MARK: - Marital
    
    @IBAction func clickedRDate(_ sender: UITextField) {
        strOpenDate = "3"
        datePickerRDate.datePickerMode = .date
        datePickerRDate.preferredDatePickerStyle = .wheels
        
        datePickerRDate.maximumDate = Date()
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "CANCEL", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        sender.inputAccessoryView = toolbar
        sender.inputView = datePickerRDate
    }
    
    
    @IBAction func clickedCurrneyc(_ sender: Any) {
        dropDownContry.show()
    }
    
    @IBAction func clickedGender(_ sender: Any) {
        self.dropDownGenders.show()
    }
    
    func setDropDownMarital()
    {
        dropDownMarital.dataSource = arrMarital
        dropDownMarital.anchorView = viewMarital
        dropDownMarital.direction = .bottom
        
        dropDownMarital.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.txtStatus.text = item
        }
        
        dropDownMarital.bottomOffset = CGPoint(x: 0, y: viewMarital.bounds.height)
        dropDownMarital.topOffset = CGPoint(x: 0, y: -viewMarital.bounds.height)
        dropDownMarital.dismissMode = .onTap
        dropDownMarital.textColor = .black
        dropDownMarital.backgroundColor = UIColor(red: 255/255, green:  255/255, blue:  255/255, alpha: 1)
        dropDownMarital.selectionBackgroundColor = UIColor.clear
        dropDownMarital.reloadAllComponents()
    }
    
    func setdropDownReason()
    {
        dropDownReason.dataSource = ["Tourism","Work","Family"]
        dropDownReason.anchorView = viewRR
        dropDownReason.direction = .bottom
        
        dropDownReason.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.lblReason.text = item
        }
        
        dropDownReason.bottomOffset = CGPoint(x: 0, y: viewRR.bounds.height)
        dropDownReason.topOffset = CGPoint(x: 0, y: -viewRR.bounds.height)
        dropDownReason.dismissMode = .onTap
        dropDownReason.textColor = .black
        dropDownReason.backgroundColor = UIColor(red: 255/255, green:  255/255, blue:  255/255, alpha: 1)
        dropDownReason.selectionBackgroundColor = UIColor.clear
        dropDownReason.reloadAllComponents()
    }
    
    func setdropDownVisa()
    {
        dropDownVisa.dataSource = ["Single","Multiple"]
        dropDownVisa.anchorView = txtVisaType
        dropDownVisa.direction = .bottom
        
        dropDownVisa.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.txtVisaType.text = item
        }
        
        dropDownVisa.bottomOffset = CGPoint(x: 0, y: txtVisaType.bounds.height)
        dropDownVisa.topOffset = CGPoint(x: 0, y: -txtVisaType.bounds.height)
        dropDownVisa.dismissMode = .onTap
        dropDownVisa.textColor = .black
        dropDownVisa.backgroundColor = UIColor(red: 255/255, green:  255/255, blue:  255/255, alpha: 1)
        dropDownVisa.selectionBackgroundColor = UIColor.clear
        dropDownVisa.reloadAllComponents()
    }
    
    func setdropDownVisit()
    {
        dropDownVisit.dataSource = ["Tourism","Work","Family"]
        dropDownVisit.anchorView = txtVisitType
        dropDownVisit.direction = .bottom
        
        dropDownVisit.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.txtVisitType.text = item
        }
        
        dropDownVisit.bottomOffset = CGPoint(x: 0, y: txtVisitType.bounds.height)
        dropDownVisit.topOffset = CGPoint(x: 0, y: -txtVisitType.bounds.height)
        dropDownVisit.dismissMode = .onTap
        dropDownVisit.textColor = .black
        dropDownVisit.backgroundColor = UIColor(red: 255/255, green:  255/255, blue:  255/255, alpha: 1)
        dropDownVisit.selectionBackgroundColor = UIColor.clear
        dropDownVisit.reloadAllComponents()
    }
    
    @IBAction func clickedCountry(_ sender: Any) {
        strOpenCounty = "1"
        let picker = ADCountryPicker()
        // delegate
        picker.delegate = self
        
        // Display calling codes
        picker.showCallingCodes = true
        
        // or closure
        picker.didSelectCountryClosure = { name, code in
            _ = picker.navigationController?.popToRootViewController(animated: true)
            print(code)
        }
        
        // Use this below code to present the picker
        
        let pickerNavigationController = UINavigationController(rootViewController: picker)
        self.present(pickerNavigationController, animated: true, completion: nil)
    }
    
    @IBAction func clickedOptionCountry(_ sender: Any) {
        strOpenCounty = "2"
        let picker = ADCountryPicker()
        // delegate
        picker.delegate = self
        
        // Display calling codes
        picker.showCallingCodes = true
        
        // or closure
        picker.didSelectCountryClosure = { name, code in
            _ = picker.navigationController?.popToRootViewController(animated: true)
            print(code)
        }
        
        // Use this below code to present the picker
        
        let pickerNavigationController = UINavigationController(rootViewController: picker)
        self.present(pickerNavigationController, animated: true, completion: nil)
    }
    
    
    @IBAction func clickedMarital(_ sender: Any) {
        dropDownMarital.show()
    }
    
    @IBAction func clickedChangeDocumnet(_ sender: Any) {
        let alert = UIAlertController(title: "Choose an option", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.showCameraPicker()
        }))
        
        alert.addAction(UIAlertAction(title: "Select Photo", style: .default, handler: { _ in
            self.showImagePicker()
        }))
        
        alert.addAction(UIAlertAction(title: "Select PDF", style: .default, handler: { _ in
            self.showPDFPicker()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = view
            popoverController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func clickedPassportImage(_ sender: Any) {
        if isUploasPassport == true
        {
            if isUplaodPDF == true
            {
                
            }
            else
            {
                if let img = imgPassportImage.image{
                    let photo = ChatImage()
                    photo.image = img
                    
                    let photosViewController: NYTPhotosViewController = NYTPhotosViewController(photos: [photo])
                    present(photosViewController, animated: true, completion: nil)
                }
            }
        }
        else
        {
            let alert = UIAlertController(title: "Choose an option", message: nil, preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
                self.showCameraPicker()
            }))
            
            alert.addAction(UIAlertAction(title: "Select Photo", style: .default, handler: { _ in
                self.showImagePicker()
            }))
            
            alert.addAction(UIAlertAction(title: "Select PDF", style: .default, handler: { _ in
                self.showPDFPicker()
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = view
                popoverController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
            
            present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func clickdeOtherTraveller(_ sender: Any) {
        if isSwitchImg == true
        {
            self.imgOther.image = UIImage(named: "F_T")
            isSwitchImg = false
        }
        else
        {
            self.imgOther.image = UIImage(named: "B_T")
            isSwitchImg = true
        }
    }
    
    @IBAction func clickedReson(_ sender: Any) {
        dropDownReason.show()
    }
    @IBAction func clickedVisaType(_ sender: Any) {
        dropDownVisa.show()
    }
    @IBAction func viewVisitType(_ sender: Any) {
        dropDownVisit.show()
    }
    
    
    //MARK: - CameraImage select code
    func showCameraPicker() {
        
        checkCameraPermission()
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Camera is not available on this device.")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            // Permission is granted, proceed to use the camera
            print("Camera access granted.")
            // You can add your camera usage code here
            
        case .notDetermined:
            // Permission has not been requested yet, request it
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        // Permission granted
                        print("Camera access granted.")
                        // Proceed with camera usage
                    }
                } else {
                    DispatchQueue.main.async {
                        // Permission denied
                        self.showPermissionDeniedAlert()
                    }
                }
            }
            
        case .denied, .restricted:
            // Permission denied or restricted
            print("Camera access denied.")
            showPermissionDeniedAlert()
            
        @unknown default:
            fatalError("Unexpected authorization status.")
        }
    }
    
    func showPermissionDeniedAlert() {
        let alert = UIAlertController(title: "Camera Access Denied",
                                      message: "Please enable camera access in Settings.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    //MARK: - image select code
    func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - pdf select code
    func showPDFPicker() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    //MARK: -UIImagePickerControllerDelegate methods
    
    // Mark :- Edit Api
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            let imageurl = info[UIImagePickerController.InfoKey.editedImage] as? URL
            selectedImg = imageurl?.lastPathComponent
            DispatchQueue.main.async {
                self.isUplaodPDF = false
                self.isUploasPassport = true
                self.btnChangeDocumenu.isHidden = false
                self.imgPassportImage.image = image
                self.imgPassportImage.isHidden = false
                self.imgPdf.isHidden = true
                self.viewUploadPic.isHidden = true
                self.imgPassportImage.contentMode = .scaleAspectFit
            }
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            let imageurl = info[UIImagePickerController.InfoKey.originalImage] as? URL
            selectedImg = imageurl?.lastPathComponent
            
            if let imageData = image.jpegData(compressionQuality: 0.3) {
                
                if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    // Create a unique filename
                    let filename = UUID().uuidString + ".jpg"
                    // Construct the file URL
                    let fileURL = documentsDirectory.appendingPathComponent(filename)
                    
                    // Write the image data to the file
                    do {
                        try imageData.write(to: fileURL)
                        // Use the fileURL as needed
                        print("Saved image to: \(fileURL)")
                        
                        do {
                            let pdfData = try Data(contentsOf: fileURL)
                            if pdfData.count <= 5 * 1024 * 1024 {
                                
                                self.isUplaodPDF = false
                                self.isUploasPassport = true
                                self.btnChangeDocumenu.isHidden = false
                                self.imgPassportImage.image = image
                                self.imgPassportImage.isHidden = false
                                self.imgPdf.isHidden = true
                                self.viewUploadPic.isHidden = true
                                self.imgPassportImage.contentMode = .scaleAspectFit
                                
                            } else {
                                
                                self.setUpMakeToast(msg: "Image file larger than 5MB")
                            }
                        } catch {
                            // Handle error reading PDF data
                        }
                        
                    } catch {
                        print("Error saving image:", error)
                    }
                }
                
            }
          
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func isImageTooLarge(imageData: Data, maxSizeInBytes: Int) -> Bool {
        let megabyteSize = Double(maxSizeInBytes) / (1024 * 1024) // Convert bytes to megabytes
        let imageSizeInMB = Double(imageData.count) / (1024 * 1024)
        return imageSizeInMB > megabyteSize
    }
    
    //MARK: -UIDocumentPickerDelegate method
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let pdfURL = urls.first {
            // Handle the selected PDF file
            // You can display the PDF, save it, or perform other actions
            print("Selected PDF file: \(pdfURL)")
            
            do {
                let fileSize = try pdfURL.resourceValues(forKeys: [.fileSizeKey]).fileSize ?? 0
                if fileSize <= 1 * 1024 * 1024 {
                    
                    let cico = pdfURL as URL
                    let url_New = URL(string: cico.relativeString)
                    
                    let pdfData = try! Data(contentsOf: url_New!)
                    let data7777 : Data = pdfData
                    
                    self.UploadData = data7777
                    
                    isUplaodPDF = true
                    
                    isUploasPassport = true
                    
                    btnChangeDocumenu.isHidden = false
                    imgPdf.isHidden = false
                    imgPassportImage.isHidden = true
                    viewUploadPic.isHidden = true
                    
                } else {
                    // Inform user that the file is larger than 5MB
                    
                    self.setUpMakeToast(msg: "PDF is too large.")
                }
            } catch {
                // Handle error getting file size
            }
            
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func clickedNoOfDay(_ sender: Any) {
        //        viewDuration.isHidden = false
        //        heightDurationView.constant = 242
    }
    
    @IBAction func clickedNationality(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectPopUpVC") as! SelectPopUpVC
        let home = UINavigationController(rootViewController: vc)
        home.modalPresentationStyle = .overFullScreen
        vc.isDestination = false
        vc.isOpenForm1 = false
        vc.delegateSearch = self
        self.present(home, animated: false)
    }
    
    @IBAction func clickedNext(_ sender: Any) {
        self.setUpHideMakeToast()
        
        if txtEnterName.text == ""
        {
            self.setUpMakeToast(msg: "Enter full name")
        }
        else if txtDOB.text == ""
        {
            self.setUpMakeToast(msg: "Enter DOB")
        }
//        else if txtEnterEmail.text == ""
//        {
//            self.setUpMakeToast(msg: "Enter Email")
//        }
//        else if !AppUtilites.isValidEmail(testStr: txtEnterEmail.text ?? "")
//        {
//            self.setUpMakeToast(msg: "Enter valid email")
//        }
        else if txtNumber.text == ""
        {
            self.setUpMakeToast(msg: "Enter mobile number")
        }
        else if (txtNumber.text?.count ?? 0) < 8
        {
            self.setUpMakeToast(msg: "Please Enter minimum 8 digit mobile number")
        }
        else if txtOptionalMbile.text != "" {
            if (txtOptionalMbile.text?.count ?? 0) < 8
            {
                self.setUpMakeToast(msg: "Please Enter minimum 8 digit optional mobile number")
            }
            else {
                self.arrPInsurance.removeAllObjects()
                
                if isSwitchImg == true
                {
                    let dicInsurance = NSMutableDictionary()
                    dicInsurance.setValue(self.txtEnterName.text ?? "", forKey: "full_name")
                    dicInsurance.setValue(self.txtDOB.text ?? "", forKey: "date_of_birth")
                    dicInsurance.setValue(self.lblGender.text ?? "", forKey: "gender")
                    dicInsurance.setValue(self.txtEnterPassportId.text ?? "", forKey: "passport_number")
                    dicInsurance.setValue(self.lblNationality.text ?? "", forKey: "nationality")

                    if isUplaodPDF == true
                    {
                        dicInsurance.setValue(self.UploadData, forKey: "passport_copy")
                        dicInsurance.setValue(true, forKey: "isPDF")
                    }
                    else
                    {
                        let imgData = self.imgPassportImage.image?.jpegData(compressionQuality: 0.3)
                        
                        dicInsurance.setValue(imgData, forKey: "passport_copy")
                        dicInsurance.setValue(false, forKey: "isPDF")
                    }
                    
                    
                    self.arrPInsurance.add(dicInsurance)
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "InsuranceDetailVC") as! InsuranceDetailVC
                    vc.planid = self.planid
                    vc.arrPInsurance = self.arrPInsurance
                    vc.email = self.txtEnterEmail.text ?? ""
                    vc.phoneNumber = "\(self.txtCountry.text ?? "") \(self.txtNumber.text ?? "")"
                    vc.policySDate = self.txtPolicy.text ?? ""
                    vc.policyEDate = self.txtPolicyEDate.text ?? ""
                    vc.numberDay = "\(self.strPeriod ?? 0)"
                    vc.nationality = self.lblNationality.text ?? ""
                    vc.marital_status = self.txtStatus.text ?? ""
                    vc.address = self.txtAddress.text ?? ""
                    vc.gender = self.lblGender.text ?? ""
                    vc.pagCount = self.pageCount
                    vc.dicPlanDetails = self.dicPlanDetails
                    vc.selectedTraveller = self.selectedTraveller
                    vc.destination = self.strDestination
                    vc.zone = self.strZone
                    vc.optional_country_code = self.lblCountryCodeOptional.text ?? ""
                    vc.optional_mobile_no = self.txtOptionalMbile.text ?? ""
                    vc.residence_no = self.txtRNo.text ?? ""
                    vc.residence_date = self.txtRDate.text ?? ""
                    vc.residence_duration = self.txtRDuration.text ?? ""
                    vc.residence_reason = self.lblReason.text ?? ""
                    vc.border_entry = self.txtBoarderEntry.text ?? ""
                    vc.visa_type = self.txtVisaType.text ?? ""
                    vc.visit_type = self.txtVisitType.text ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else
                {
                    let dicInsurance = NSMutableDictionary()
                    dicInsurance.setValue(self.txtEnterName.text ?? "", forKey: "full_name")
                    dicInsurance.setValue(self.txtDOB.text ?? "", forKey: "date_of_birth")
                    dicInsurance.setValue(self.lblGender.text ?? "", forKey: "gender")
                    dicInsurance.setValue(self.txtEnterPassportId.text ?? "", forKey: "passport_number")
                    dicInsurance.setValue(self.lblNationality.text ?? "", forKey: "nationality")

                    
                    if isUplaodPDF == true
                    {
                        dicInsurance.setValue(self.UploadData, forKey: "passport_copy")
                        dicInsurance.setValue(true, forKey: "isPDF")
                    }
                    else
                    {
                        let imgData = self.imgPassportImage.image?.jpegData(compressionQuality: 0.3)
                        
                        dicInsurance.setValue(imgData, forKey: "passport_copy")
                        dicInsurance.setValue(false, forKey: "isPDF")
                    }
                    
                    self.arrPInsurance.add(dicInsurance)
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Form3thVC") as! Form3thVC
                    vc.planid = self.planid
                    vc.pagCount = self.pageCount - 1
                    vc.arrPInsuranceFirst = self.arrPInsurance
                    vc.email = self.txtEnterEmail.text ?? ""
                    vc.phoneNumber = "\(self.txtCountry.text ?? "") \(self.txtNumber.text ?? "")"
                    vc.policySDate = self.txtPolicy.text ?? ""
                    vc.policyEDate = self.txtPolicyEDate.text ?? ""
                    vc.numberDay = "\(self.strPeriod ?? 0)"
                    vc.nationality = self.lblNationality.text ?? ""
                    vc.marital_status = self.txtStatus.text ?? ""
                    vc.address = self.txtAddress.text ?? ""
                    vc.dicPlanDetails = self.dicPlanDetails
                    vc.selectedTraveller = self.selectedTraveller
                    vc.destination = self.strDestination
                    vc.zone = self.strZone
                    vc.strPeriod = self.strPeriod
                    vc.optional_country_code = self.lblCountryCodeOptional.text ?? ""
                    vc.optional_mobile_no = self.txtOptionalMbile.text ?? ""
                    vc.residence_no = self.txtRNo.text ?? ""
                    vc.residence_date = self.txtRDate.text ?? ""
                    vc.residence_duration = self.txtRDuration.text ?? ""
                    vc.residence_reason = self.lblReason.text ?? ""
                    vc.border_entry = self.txtBoarderEntry.text ?? ""
                    vc.visa_type = self.txtVisaType.text ?? ""
                    vc.visit_type = self.txtVisitType.text ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        
//        else if lblNoOfDays.text == ""
//        {
//            self.setUpMakeToast(msg: "Enter NoOfDays")
//        }
        else if txtPolicy.text == ""
        {
            self.setUpMakeToast(msg: "Select policy effective date")
        }
        else if txtPolicyEDate.text == ""
        {
            self.setUpMakeToast(msg: "Select policy expire date")
        }
        else if lblNationality.text == "Select"
        {
            self.setUpMakeToast(msg: "Enter Nationality")
        }
//        else if txtStatus.text == "Select"
//        {
//            self.setUpMakeToast(msg: "Select marital status")
//        }
//        else if lblGender.text == "Select"
//        {
//            self.setUpMakeToast(msg: "Select gender")
//        }
        else if txtEnterPassportId.text == ""
        {
            self.setUpMakeToast(msg: "Enter PassportID/No")
        }
        else if txtAddress.text == ""
        {
            self.setUpMakeToast(msg: "Enter address")
        }
        else if isUploasPassport == false
        {
            self.setUpMakeToast(msg: "Please select a passport image/pdf")
            
        } else if dicPlanDetails.planTypeCategory.name.contains("Non-visa") == true {
            
            if txtBoarderEntry.text == "" {
                self.setUpMakeToast(msg: "Enter boarder entry")
            }
            
            else {
                self.arrPInsurance.removeAllObjects()
                
                if isSwitchImg == true
                {
                    let dicInsurance = NSMutableDictionary()
                    dicInsurance.setValue(self.txtEnterName.text ?? "", forKey: "full_name")
                    dicInsurance.setValue(self.txtDOB.text ?? "", forKey: "date_of_birth")
                    dicInsurance.setValue(self.lblGender.text ?? "", forKey: "gender")
                    dicInsurance.setValue(self.txtEnterPassportId.text ?? "", forKey: "passport_number")
                    dicInsurance.setValue(self.lblNationality.text ?? "", forKey: "nationality")
                    
                    if isUplaodPDF == true
                    {
                        dicInsurance.setValue(self.UploadData, forKey: "passport_copy")
                        dicInsurance.setValue(true, forKey: "isPDF")
                    }
                    else
                    {
                        let imgData = self.imgPassportImage.image?.jpegData(compressionQuality: 0.3)
                        
                        dicInsurance.setValue(imgData, forKey: "passport_copy")
                        dicInsurance.setValue(false, forKey: "isPDF")
                    }
                    
                    
                    self.arrPInsurance.add(dicInsurance)
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "InsuranceDetailVC") as! InsuranceDetailVC
                    vc.planid = self.planid
                    vc.arrPInsurance = self.arrPInsurance
                    vc.email = self.txtEnterEmail.text ?? ""
                    vc.phoneNumber = "\(self.txtCountry.text ?? "") \(self.txtNumber.text ?? "")"
                    vc.policySDate = self.txtPolicy.text ?? ""
                    vc.policyEDate = self.txtPolicyEDate.text ?? ""
                    vc.numberDay = "\(self.strPeriod ?? 0)"
                    vc.marital_status = self.txtStatus.text ?? ""
                    vc.address = self.txtAddress.text ?? ""
                    vc.pagCount = self.pageCount
                    vc.dicPlanDetails = self.dicPlanDetails
                    vc.selectedTraveller = self.selectedTraveller
                    vc.destination = self.strDestination
                    vc.zone = self.strZone
                    vc.optional_country_code = self.lblCountryCodeOptional.text ?? ""
                    vc.optional_mobile_no = self.txtOptionalMbile.text ?? ""
                    vc.residence_no = self.txtRNo.text ?? ""
                    vc.residence_date = self.txtRDate.text ?? ""
                    vc.residence_duration = self.txtRDuration.text ?? ""
                    vc.residence_reason = self.lblReason.text ?? ""
                    vc.border_entry = self.txtBoarderEntry.text ?? ""
                    vc.visa_type = self.txtVisaType.text ?? ""
                    vc.visit_type = self.txtVisitType.text ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else
                {
                    let dicInsurance = NSMutableDictionary()
                    dicInsurance.setValue(self.txtEnterName.text ?? "", forKey: "full_name")
                    dicInsurance.setValue(self.txtDOB.text ?? "", forKey: "date_of_birth")
                    dicInsurance.setValue(self.lblGender.text ?? "", forKey: "gender")
                    dicInsurance.setValue(self.txtEnterPassportId.text ?? "", forKey: "passport_number")
                    dicInsurance.setValue(self.lblNationality.text ?? "", forKey: "nationality")

                    
                    if isUplaodPDF == true
                    {
                        dicInsurance.setValue(self.UploadData, forKey: "passport_copy")
                        dicInsurance.setValue(true, forKey: "isPDF")
                    }
                    else
                    {
                        let imgData = self.imgPassportImage.image?.jpegData(compressionQuality: 0.3)
                        
                        dicInsurance.setValue(imgData, forKey: "passport_copy")
                        dicInsurance.setValue(false, forKey: "isPDF")
                    }
                    
                    self.arrPInsurance.add(dicInsurance)
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Form3thVC") as! Form3thVC
                    vc.planid = self.planid
                    vc.pagCount = self.pageCount - 1
                    vc.arrPInsuranceFirst = self.arrPInsurance
                    vc.email = self.txtEnterEmail.text ?? ""
                    vc.phoneNumber = "\(self.txtCountry.text ?? "") \(self.txtNumber.text ?? "")"
                    vc.policySDate = self.txtPolicy.text ?? ""
                    vc.policyEDate = self.txtPolicyEDate.text ?? ""
                    vc.numberDay = "\(self.strPeriod ?? 0)"
                    vc.nationality = self.lblNationality.text ?? ""
                    vc.marital_status = self.txtStatus.text ?? ""
                    vc.address = self.txtAddress.text ?? ""
                    vc.dicPlanDetails = self.dicPlanDetails
                    vc.selectedTraveller = self.selectedTraveller
                    vc.destination = self.strDestination
                    vc.zone = self.strZone
                    vc.strPeriod = self.strPeriod
                    vc.optional_country_code = self.lblCountryCodeOptional.text ?? ""
                    vc.optional_mobile_no = self.txtOptionalMbile.text ?? ""
                    vc.residence_no = self.txtRNo.text ?? ""
                    vc.residence_date = self.txtRDate.text ?? ""
                    vc.residence_duration = self.txtRDuration.text ?? ""
                    vc.residence_reason = self.lblReason.text ?? ""
                    vc.border_entry = self.txtBoarderEntry.text ?? ""
                    vc.visa_type = self.txtVisaType.text ?? ""
                    vc.visit_type = self.txtVisitType.text ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        } else if dicPlanDetails.planTypeCategory.name.contains("VISA") == true {
            
            if txtVisaType.text == "" {
                
                self.setUpMakeToast(msg: "Enter visa type")
            } else if txtVisitType.text == "" {
                
                self.setUpMakeToast(msg: "Enter visit type")
            }
            
            else {
                self.arrPInsurance.removeAllObjects()
                
                if isSwitchImg == true
                {
                    let dicInsurance = NSMutableDictionary()
                    dicInsurance.setValue(self.txtEnterName.text ?? "", forKey: "full_name")
                    dicInsurance.setValue(self.txtDOB.text ?? "", forKey: "date_of_birth")
                    dicInsurance.setValue(self.lblGender.text ?? "", forKey: "gender")
                    dicInsurance.setValue(self.txtEnterPassportId.text ?? "", forKey: "passport_number")
                    dicInsurance.setValue(self.lblNationality.text ?? "", forKey: "nationality")

                    
                    if isUplaodPDF == true
                    {
                        dicInsurance.setValue(self.UploadData, forKey: "passport_copy")
                        dicInsurance.setValue(true, forKey: "isPDF")
                    }
                    else
                    {
                        let imgData = self.imgPassportImage.image?.jpegData(compressionQuality: 0.3)
                        
                        dicInsurance.setValue(imgData, forKey: "passport_copy")
                        dicInsurance.setValue(false, forKey: "isPDF")
                    }
                    
                    
                    self.arrPInsurance.add(dicInsurance)
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "InsuranceDetailVC") as! InsuranceDetailVC
                    vc.planid = self.planid
                    vc.arrPInsurance = self.arrPInsurance
                    vc.email = self.txtEnterEmail.text ?? ""
                    vc.phoneNumber = "\(self.txtCountry.text ?? "") \(self.txtNumber.text ?? "")"
                    vc.policySDate = self.txtPolicy.text ?? ""
                    vc.policyEDate = self.txtPolicyEDate.text ?? ""
                    vc.numberDay = "\(self.strPeriod)"
                    vc.nationality = self.lblNationality.text ?? ""
                    vc.marital_status = self.txtStatus.text ?? ""
                    vc.address = self.txtAddress.text ?? ""
                    vc.pagCount = self.pageCount
                    vc.dicPlanDetails = self.dicPlanDetails
                    vc.selectedTraveller = self.selectedTraveller
                    vc.destination = self.strDestination
                    vc.zone = self.strZone
                    vc.optional_country_code = self.lblCountryCodeOptional.text ?? ""
                    vc.optional_mobile_no = self.txtOptionalMbile.text ?? ""
                    vc.residence_no = self.txtRNo.text ?? ""
                    vc.residence_date = self.txtRDate.text ?? ""
                    vc.residence_duration = self.txtRDuration.text ?? ""
                    vc.residence_reason = self.lblReason.text ?? ""
                    vc.border_entry = self.txtBoarderEntry.text ?? ""
                    vc.visa_type = self.txtVisaType.text ?? ""
                    vc.visit_type = self.txtVisitType.text ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else
                {
                    let dicInsurance = NSMutableDictionary()
                    dicInsurance.setValue(self.txtEnterName.text ?? "", forKey: "full_name")
                    dicInsurance.setValue(self.txtDOB.text ?? "", forKey: "date_of_birth")
                    dicInsurance.setValue(self.lblGender.text ?? "", forKey: "gender")
                    dicInsurance.setValue(self.txtEnterPassportId.text ?? "", forKey: "passport_number")
                    dicInsurance.setValue(self.lblNationality.text ?? "", forKey: "nationality")

                    
                    if isUplaodPDF == true
                    {
                        dicInsurance.setValue(self.UploadData, forKey: "passport_copy")
                        dicInsurance.setValue(true, forKey: "isPDF")
                    }
                    else
                    {
                        let imgData = self.imgPassportImage.image?.jpegData(compressionQuality: 0.3)
                        
                        dicInsurance.setValue(imgData, forKey: "passport_copy")
                        dicInsurance.setValue(false, forKey: "isPDF")
                    }
                    
                    self.arrPInsurance.add(dicInsurance)
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Form3thVC") as! Form3thVC
                    vc.planid = self.planid
                    vc.pagCount = self.pageCount - 1
                    vc.arrPInsuranceFirst = self.arrPInsurance
                    vc.email = self.txtEnterEmail.text ?? ""
                    vc.phoneNumber = "\(self.txtCountry.text ?? "") \(self.txtNumber.text ?? "")"
                    vc.policySDate = self.txtPolicy.text ?? ""
                    vc.policyEDate = self.txtPolicyEDate.text ?? ""
                    vc.numberDay = "\(self.strPeriod ?? 0)"
                    vc.nationality = self.lblNationality.text ?? ""
                    vc.marital_status = self.txtStatus.text ?? ""
                    vc.address = self.txtAddress.text ?? ""
                    vc.dicPlanDetails = self.dicPlanDetails
                    vc.selectedTraveller = self.selectedTraveller
                    vc.destination = self.strDestination
                    vc.zone = self.strZone
                    vc.strPeriod = self.strPeriod
                    vc.optional_country_code = self.lblCountryCodeOptional.text ?? ""
                    vc.optional_mobile_no = self.txtOptionalMbile.text ?? ""
                    vc.residence_no = self.txtRNo.text ?? ""
                    vc.residence_date = self.txtRDate.text ?? ""
                    vc.residence_duration = self.txtRDuration.text ?? ""
                    vc.residence_reason = self.lblReason.text ?? ""
                    vc.border_entry = self.txtBoarderEntry.text ?? ""
                    vc.visa_type = self.txtVisaType.text ?? ""
                    vc.visit_type = self.txtVisitType.text ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        } else if dicPlanDetails.planTypeCategory.name.contains("Residents") == true {
            
            if txtRNo.text == "" {
                
                self.setUpMakeToast(msg: "Enter residence number")
            } else if lblReason.text == "" {
                
                self.setUpMakeToast(msg: "Enter residence reason")
            } else if txtRDuration.text == "" {
                
                self.setUpMakeToast(msg: "Enter residence duration")
            } else if txtRDate.text == "" {
                
                self.setUpMakeToast(msg: "Select residence date")
            }
            
            else {
                self.arrPInsurance.removeAllObjects()
                
                if isSwitchImg == true
                {
                    let dicInsurance = NSMutableDictionary()
                    dicInsurance.setValue(self.txtEnterName.text ?? "", forKey: "full_name")
                    dicInsurance.setValue(self.txtDOB.text ?? "", forKey: "date_of_birth")
                    dicInsurance.setValue(self.lblGender.text ?? "", forKey: "gender")
                    dicInsurance.setValue(self.txtEnterPassportId.text ?? "", forKey: "passport_number")
                    dicInsurance.setValue(self.lblNationality.text ?? "", forKey: "nationality")

                    
                    if isUplaodPDF == true
                    {
                        dicInsurance.setValue(self.UploadData, forKey: "passport_copy")
                        dicInsurance.setValue(true, forKey: "isPDF")
                    }
                    else
                    {
                        let imgData = self.imgPassportImage.image?.jpegData(compressionQuality: 0.3)
                        
                        dicInsurance.setValue(imgData, forKey: "passport_copy")
                        dicInsurance.setValue(false, forKey: "isPDF")
                    }
                    
                    
                    self.arrPInsurance.add(dicInsurance)
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "InsuranceDetailVC") as! InsuranceDetailVC
                    vc.planid = self.planid
                    vc.arrPInsurance = self.arrPInsurance
                    vc.email = self.txtEnterEmail.text ?? ""
                    vc.phoneNumber = "\(self.txtCountry.text ?? "") \(self.txtNumber.text ?? "")"
                    vc.policySDate = self.txtPolicy.text ?? ""
                    vc.policyEDate = self.txtPolicyEDate.text ?? ""
                    vc.numberDay = "\(self.strPeriod ?? 0)"
                    vc.nationality = self.lblNationality.text ?? ""
                    vc.marital_status = self.txtStatus.text ?? ""
                    vc.address = self.txtAddress.text ?? ""
                    vc.pagCount = self.pageCount
                    vc.dicPlanDetails = self.dicPlanDetails
                    vc.selectedTraveller = self.selectedTraveller
                    vc.destination = self.strDestination
                    vc.zone = self.strZone
                    vc.optional_country_code = self.lblCountryCodeOptional.text ?? ""
                    vc.optional_mobile_no = self.txtOptionalMbile.text ?? ""
                    vc.residence_no = self.txtRNo.text ?? ""
                    vc.residence_date = self.txtRDate.text ?? ""
                    vc.residence_duration = self.txtRDuration.text ?? ""
                    vc.residence_reason = self.lblReason.text ?? ""
                    vc.border_entry = self.txtBoarderEntry.text ?? ""
                    vc.visa_type = self.txtVisaType.text ?? ""
                    vc.visit_type = self.txtVisitType.text ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else
                {
                    let dicInsurance = NSMutableDictionary()
                    dicInsurance.setValue(self.txtEnterName.text ?? "", forKey: "full_name")
                    dicInsurance.setValue(self.txtDOB.text ?? "", forKey: "date_of_birth")
                    dicInsurance.setValue(self.lblGender.text ?? "", forKey: "gender")
                    dicInsurance.setValue(self.txtEnterPassportId.text ?? "", forKey: "passport_number")
                    dicInsurance.setValue(self.lblNationality.text ?? "", forKey: "nationality")

                    if isUplaodPDF == true
                    {
                        dicInsurance.setValue(self.UploadData, forKey: "passport_copy")
                        dicInsurance.setValue(true, forKey: "isPDF")
                    }
                    else
                    {
                        let imgData = self.imgPassportImage.image?.jpegData(compressionQuality: 0.3)
                        
                        dicInsurance.setValue(imgData, forKey: "passport_copy")
                        dicInsurance.setValue(false, forKey: "isPDF")
                    }
                    
                    self.arrPInsurance.add(dicInsurance)
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Form3thVC") as! Form3thVC
                    vc.planid = self.planid
                    vc.pagCount = self.pageCount - 1
                    vc.arrPInsuranceFirst = self.arrPInsurance
                    vc.email = self.txtEnterEmail.text ?? ""
                    vc.phoneNumber = "\(self.txtCountry.text ?? "") \(self.txtNumber.text ?? "")"
                    vc.policySDate = self.txtPolicy.text ?? ""
                    vc.policyEDate = self.txtPolicyEDate.text ?? ""
                    vc.numberDay = "\(self.strPeriod ?? 0)"
                    vc.nationality = self.lblNationality.text ?? ""
                    vc.marital_status = self.txtStatus.text ?? ""
                    vc.address = self.txtAddress.text ?? ""
                    vc.dicPlanDetails = self.dicPlanDetails
                    vc.selectedTraveller = self.selectedTraveller
                    vc.destination = self.strDestination
                    vc.zone = self.strZone
                    vc.strPeriod = self.strPeriod
                    vc.optional_country_code = self.lblCountryCodeOptional.text ?? ""
                    vc.optional_mobile_no = self.txtOptionalMbile.text ?? ""
                    vc.residence_no = self.txtRNo.text ?? ""
                    vc.residence_date = self.txtRDate.text ?? ""
                    vc.residence_duration = self.txtRDuration.text ?? ""
                    vc.residence_reason = self.lblReason.text ?? ""
                    vc.border_entry = self.txtBoarderEntry.text ?? ""
                    vc.visa_type = self.txtVisaType.text ?? ""
                    vc.visit_type = self.txtVisitType.text ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        } 
        else {
            self.arrPInsurance.removeAllObjects()
            
            if isSwitchImg == true
            {
                let dicInsurance = NSMutableDictionary()
                dicInsurance.setValue(self.txtEnterName.text ?? "", forKey: "full_name")
                dicInsurance.setValue(self.txtDOB.text ?? "", forKey: "date_of_birth")
                dicInsurance.setValue(self.lblGender.text ?? "", forKey: "gender")
                dicInsurance.setValue(self.txtEnterPassportId.text ?? "", forKey: "passport_number")
                dicInsurance.setValue(self.lblNationality.text ?? "", forKey: "nationality")

                
                if isUplaodPDF == true
                {
                    dicInsurance.setValue(self.UploadData, forKey: "passport_copy")
                    dicInsurance.setValue(true, forKey: "isPDF")
                }
                else
                {
                    let imgData = self.imgPassportImage.image?.jpegData(compressionQuality: 0.3)
                    
                    dicInsurance.setValue(imgData, forKey: "passport_copy")
                    dicInsurance.setValue(false, forKey: "isPDF")
                }
                
                
                self.arrPInsurance.add(dicInsurance)
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "InsuranceDetailVC") as! InsuranceDetailVC
                vc.planid = self.planid
                vc.arrPInsurance = self.arrPInsurance
                vc.email = self.txtEnterEmail.text ?? ""
                vc.phoneNumber = "\(self.txtCountry.text ?? "") \(self.txtNumber.text ?? "")"
                vc.policySDate = self.txtPolicy.text ?? ""
                vc.policyEDate = self.txtPolicyEDate.text ?? ""
                vc.numberDay = "\(self.strPeriod ?? 0)"
                vc.nationality = self.lblNationality.text ?? ""
                vc.marital_status = self.txtStatus.text ?? ""
                vc.address = self.txtAddress.text ?? ""
                vc.pagCount = self.pageCount
                vc.dicPlanDetails = self.dicPlanDetails
                vc.selectedTraveller = self.selectedTraveller
                vc.destination = self.strDestination
                vc.zone = self.strZone
                vc.optional_country_code = self.lblCountryCodeOptional.text ?? ""
                vc.optional_mobile_no = self.txtOptionalMbile.text ?? ""
                vc.residence_no = self.txtRNo.text ?? ""
                vc.residence_date = self.txtRDate.text ?? ""
                vc.residence_duration = self.txtRDuration.text ?? ""
                vc.residence_reason = self.lblReason.text ?? ""
                vc.border_entry = self.txtBoarderEntry.text ?? ""
                vc.visa_type = self.txtVisaType.text ?? ""
                vc.visit_type = self.txtVisitType.text ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                let dicInsurance = NSMutableDictionary()
                dicInsurance.setValue(self.txtEnterName.text ?? "", forKey: "full_name")
                dicInsurance.setValue(self.txtDOB.text ?? "", forKey: "date_of_birth")
                dicInsurance.setValue(self.lblGender.text ?? "", forKey: "gender")
                dicInsurance.setValue(self.txtEnterPassportId.text ?? "", forKey: "passport_number")
                dicInsurance.setValue(self.lblNationality.text ?? "", forKey: "nationality")

                
                if isUplaodPDF == true
                {
                    dicInsurance.setValue(self.UploadData, forKey: "passport_copy")
                    dicInsurance.setValue(true, forKey: "isPDF")
                }
                else
                {
                    let imgData = self.imgPassportImage.image?.jpegData(compressionQuality: 0.3)
                    
                    dicInsurance.setValue(imgData, forKey: "passport_copy")
                    dicInsurance.setValue(false, forKey: "isPDF")
                }
                
                self.arrPInsurance.add(dicInsurance)
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Form3thVC") as! Form3thVC
                vc.planid = self.planid
                vc.pagCount = self.pageCount - 1
                vc.arrPInsuranceFirst = self.arrPInsurance
                vc.email = self.txtEnterEmail.text ?? ""
                vc.phoneNumber = "\(self.txtCountry.text ?? "") \(self.txtNumber.text ?? "")"
                vc.policySDate = self.txtPolicy.text ?? ""
                vc.policyEDate = self.txtPolicyEDate.text ?? ""
                vc.numberDay = "\(self.strPeriod ?? 0)"
                vc.nationality = self.lblNationality.text ?? ""
                vc.marital_status = self.txtStatus.text ?? ""
                vc.address = self.txtAddress.text ?? ""
                vc.dicPlanDetails = self.dicPlanDetails
                vc.selectedTraveller = self.selectedTraveller
                vc.destination = self.strDestination
                vc.zone = self.strZone
                vc.strPeriod = self.strPeriod
                vc.optional_country_code = self.lblCountryCodeOptional.text ?? ""
                vc.optional_mobile_no = self.txtOptionalMbile.text ?? ""
                vc.residence_no = self.txtRNo.text ?? ""
                vc.residence_date = self.txtRDate.text ?? ""
                vc.residence_duration = self.txtRDuration.text ?? ""
                vc.residence_reason = self.lblReason.text ?? ""
                vc.border_entry = self.txtBoarderEntry.text ?? ""
                vc.visa_type = self.txtVisaType.text ?? ""
                vc.visit_type = self.txtVisitType.text ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
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
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickedDOB(_ sender: UITextField) {
        strOpenDate = "1"
        datePickerDOB.datePickerMode = .date
        datePickerDOB.preferredDatePickerStyle = .wheels
        
        //ToolBar
        let maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        datePickerDOB.maximumDate = maximumDate
        let minmumDate = Calendar.current.date(byAdding: .year, value: -86, to: Date())
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
    
    @IBAction func clickedPolicy(_ sender: UITextField) {
        strOpenDate = "2"
        datePickerPolicy.datePickerMode = .date
        datePickerPolicy.preferredDatePickerStyle = .wheels
        
        datePickerPolicy.minimumDate = Date()
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "CANCEL", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        sender.inputAccessoryView = toolbar
        sender.inputView = datePickerPolicy
    }
    @IBAction func clickedEDate(_ sender: UITextField) {
        
//        if txtPolicy.text == ""
//        {
//            self.setUpMakeToast(msg: "Please select policy start date first")
//        }
//        else
//        {
//            strOpenDate = "3"
//            datePickerPolicyEndDate.datePickerMode = .date
//            datePickerPolicyEndDate.preferredDatePickerStyle = .wheels
//            
//            //ToolBar
//            
//            let maximumDate = Calendar.current.date(byAdding: .day, value: self.dicPlanDetails.max_days ?? 0, to: datePickerPolicy.date)
//            datePickerPolicyEndDate.maximumDate = maximumDate
//            
//            datePickerPolicyEndDate.minimumDate = datePickerPolicy.date
//            let toolbar = UIToolbar();
//            toolbar.sizeToFit()
//            let doneButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(donedatePicker));
//            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//            let cancelButton = UIBarButtonItem(title: "CANCEL", style: .plain, target: self, action: #selector(cancelDatePicker));
//            toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
//            sender.inputAccessoryView = toolbar
//            sender.inputView = datePickerPolicyEndDate
//        }
        
    }
    
    @objc func donedatePicker(){
        if strOpenDate == "1"
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            txtDOB.text = formatter.string(from: datePickerDOB.date)
            self.view.endEditing(true)
            
            callGetPriceAPI()
        }
        else if strOpenDate == "2"
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            txtPolicy.text = formatter.string(from: datePickerPolicy.date)
            self.view.endEditing(true)
            
            let maximumDate = Calendar.current.date(byAdding: .day, value: self.strPeriod-1, to: datePickerPolicy.date)
            let formatter7 = DateFormatter()
            formatter7.dateFormat = "yyyy-MM-dd"
            txtPolicyEDate.text = formatter7.string(from: maximumDate!)
 
            
            let startDateString = txtPolicy.text ?? ""
            let endDateString = txtPolicyEDate.text ?? ""

            
            let dateFormatter7 = DateFormatter()
            dateFormatter7.dateFormat = "yyyy-MM-dd"
            if let startDate = dateFormatter7.date(from: startDateString),
               let endDate = dateFormatter7.date(from: endDateString) {
                
                let numberOfDays = daysBetweenDates(startDate: startDate, endDate: endDate)
                
            //    self.lblNoOfDays.text = "\(numberOfDays)"
                
                print("Number of days between the two dates: \(numberOfDays)")
            } else {
                print("Invalid date format.")
            }
            
        }
        else if strOpenDate == "3" {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            txtRDate.text = formatter.string(from: datePickerRDate.date)
            self.view.endEditing(true)
        }
        else
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            txtPolicyEDate.text = formatter.string(from: datePickerPolicyEndDate.date)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let startDateString = txtPolicy.text ?? ""
            let endDateString = txtPolicyEDate.text ?? ""
            
            if let startDate = dateFormatter.date(from: startDateString),
               let endDate = dateFormatter.date(from: endDateString) {
                
                let numberOfDays = daysBetweenDates(startDate: startDate, endDate: endDate)
                
           //     self.lblNoOfDays.text = "\(numberOfDays + 1)"
                
                print("Number of days between the two dates: \(numberOfDays)")
            } else {
                print("Invalid date format.")
            }
            
            self.view.endEditing(true)
        }
    }
    
    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }
    
    
}

extension FormVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "NoofDayCell") as! NoofDayCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "NoofDayCell") as! NoofDayCell
        
        viewDuration.isHidden = true
     //   self.lblNoOfDays.text = "Duration:- \(cell.lblName.text ?? "")          Price:-\(cell.lblPrice.text ?? "")"
        
        heightDurationView.constant = 0
    }
    
    
}

extension FormVC: ADCountryPickerDelegate {
    
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String)
    {
        _ = picker.navigationController?.popToRootViewController(animated: true)
        
        if strOpenCounty == "1" {
            self.txtCountry.text = dialCode
            
            let flagImage =  picker.getFlag(countryCode: code)
            self.lblFlag.text = countryFlag(code)
        } else {
            self.lblCountryCodeOptional.text = dialCode
            
            let flagImage =  picker.getFlag(countryCode: code)
            self.lblFlagOptional.text = countryFlag(code)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

class NoofDayCell: UITableViewCell
{
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
}


class ChatImage: NSObject, NYTPhoto {
    
    var image: UIImage?
    var imageData: Data?
    var placeholderImage: UIImage?
    var attributedCaptionTitle: NSAttributedString?
    var attributedCaptionSummary: NSAttributedString?
    var attributedCaptionCredit: NSAttributedString?
    
    init(image: UIImage? = nil, imageData: NSData? = nil) {
        super.init()
        
        self.image = image
        self.imageData = imageData as Data?
    }
    
}

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
