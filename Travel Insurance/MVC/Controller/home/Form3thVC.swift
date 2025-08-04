//
//  Form3thVC.swift
//  Hamraa Insurance
//
//  Created by Purv on 13/03/24.
//

import UIKit
import MobileCoreServices
import DropDown
import NYTPhotoViewer
import AVFoundation


class Form3thVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate, UITextFieldDelegate, onSeachSelect {
   
    @IBOutlet weak var lblCurrency: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var tblView: UITableView?
    
    @IBOutlet weak var viewTop: UIView!
    
    @IBOutlet weak var viewGender: UIView!
    @IBOutlet weak var lblGender: UILabel!
    
    var arrHederCell = 1
    var arryOfImage = NSMutableArray()
    
    var dropdown = ["Male","Female"]
    
    let datePickerDOB = UIDatePicker()
    var pagCount = 0
    
    var selectIndexImg = -1
    
    var selectedIndex = -1
    var isSwitchImg = true
    var arrPInsurance = NSMutableArray()
    var arrPInsuranceFirst = NSMutableArray()
    
    var arrPInsuranceNew = NSMutableArray()
    
    var email = ""
    var phoneNumber = ""
    var policySDate = ""
    var policyEDate = ""
    var numberDay = ""
    var nationality = ""
    var marital_status = ""
    var destination = ""
    var zone = ""
    var address = ""
    var optional_country_code = ""
    var optional_mobile_no = ""
    var residence_no = ""
    var residence_date = ""
    var residence_duration = ""
    var residence_reason = ""
    var border_entry = ""
    var visa_type = ""
    var visit_type = ""
    
    var planid = ""
    
    var isCurrentLiveTag = -1
    
    var isUploadImg = false
    var isUploadPDF = false
    
    var dicPlanDetails = TIPlanDetailsResponse()
    
    var selectedTraveller = 0
    var addNewMenber = 0
    var arr = 0
    
    let dropDownContry = DropDown()
    var arrContry: [ContryCodeConversionRate] = [ContryCodeConversionRate]()
    
    var strPeriod = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        lblTitle.text = dicPlanDetails.planType ?? ""
        
        let dicInsurance = NSMutableDictionary()
        dicInsurance.setValue("", forKey: "full_name")
        dicInsurance.setValue("", forKey: "date_of_birth")
        dicInsurance.setValue("", forKey: "passport_number")
        dicInsurance.setValue("", forKey: "passport_copy")
        dicInsurance.setValue(false, forKey: "isPDF")
        dicInsurance.setValue("", forKey: "price")
        dicInsurance.setValue("", forKey: "gender")
        dicInsurance.setValue("", forKey: "nationality")

        
        self.arrPInsurance.add(dicInsurance)
        
        tblView?.dataSource = self
        tblView?.delegate = self
        
        viewTop.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 16, spread: 0)
        
        
    }
    
    func onSelectText(text: String, isDestintion: Bool, id: Int) {
        let dicDataIn = arrPInsurance[id] as? NSMutableDictionary
        let passport_copy = dicDataIn?.value(forKey: "passport_copy") as? Data
        let isPDF = dicDataIn?.value(forKey: "isPDF") as? Bool
        
        
        let indexPath = IndexPath(row: 0, section: id)
        let cell = tblView?.cellForRow(at: indexPath) as! OtherPersonCell
        cell.lblNatinality.text = text

        let dicInsurance = NSMutableDictionary()
        dicInsurance.setValue(cell.txtEnterN.text ?? "", forKey: "full_name")
        dicInsurance.setValue(cell.TxtDate.text ?? "", forKey: "date_of_birth")
        dicInsurance.setValue(cell.TxtxIdNo.text ?? "", forKey: "passport_number")
        dicInsurance.setValue(passport_copy, forKey: "passport_copy")
        dicInsurance.setValue(isPDF, forKey: "isPDF")
        dicInsurance.setValue(cell.txtEnterPrice.text ?? "", forKey: "price")
        dicInsurance.setValue(text, forKey: "nationality")
        dicInsurance.setValue(cell.lblGender.text ?? "", forKey: "gender")

        self.arrPInsurance[id] = dicInsurance
    }
     
    override func viewWillAppear(_ animated: Bool) {
        callGetAllConversionRateAPI()
        arrPInsuranceNew.removeAllObjects()
        
        for obj in arrPInsuranceFirst {
            arrPInsuranceNew.add(obj)
        }
    }
    
    
    @IBAction func clickedCurreyc(_ sender: Any) {
        dropDownContry.show()
    }
    
    @IBAction func clickedNext(_ sender: UIButton) {
        
        
        var allPerfect = false
        
        for objData in arrPInsurance
        {
            allPerfect = false
            
            let dicDataIn = objData as! NSMutableDictionary
            
            let full_name = dicDataIn.value(forKey: "full_name") as? String
            let date_of_birth = dicDataIn.value(forKey: "date_of_birth") as? String
            let gender = dicDataIn.value(forKey: "gender") as? String
            let passport_number = dicDataIn.value(forKey: "passport_number") as? String
            let passport_copy = dicDataIn.value(forKey: "passport_copy") as? Data
            let isPDF = dicDataIn.value(forKey: "isPDF") as? Bool
            let price = dicDataIn.value(forKey: "price") as? Bool
            let nationality_other = dicDataIn.value(forKey: "nationality") as? String

            if full_name == ""
            {
                self.setUpMakeToast(msg: "Please enter name")
                
                break
            }
            else if date_of_birth == ""
            {
                self.setUpMakeToast(msg: "Please enter DOB")
                
                break
            }
            else if gender == ""
            {
                self.setUpMakeToast(msg: "Please enter gender")
                
                break
            }
            if nationality_other == "" || nationality_other == "Select"
            {
                self.setUpMakeToast(msg: "Please select nationality")
                
                break
            }
            else if passport_number == ""
            {
                self.setUpMakeToast(msg: "Please enter passportId")
                
                break
            }
            else if passport_copy == nil
            {
                self.setUpMakeToast(msg: "Please select a passport image/pdf")
                break
            }
            else if passport_copy?.count == 0
            {
                self.setUpMakeToast(msg: "Please select a passport image/pdf")
                break
            }
            else
            {
                allPerfect = true
            }
        }
        
        if allPerfect == true
        {
            
            for obj in arrPInsurance {
                arrPInsuranceNew.add(obj)
            }
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "InsuranceDetailVC") as! InsuranceDetailVC
            vc.planid = self.planid
            vc.arrPInsurance = arrPInsuranceNew
            vc.email = self.email
            vc.phoneNumber = self.phoneNumber
            vc.policySDate = self.policySDate
            vc.policyEDate = self.policyEDate
            vc.numberDay = self.numberDay
            vc.nationality = self.nationality
            vc.marital_status = self.marital_status
            vc.destination = self.destination
            vc.zone = self.zone
            vc.address = self.address
            vc.pagCount = pagCount
            vc.dicPlanDetails = self.dicPlanDetails
            vc.selectedTraveller = self.selectedTraveller
            vc.destination = self.destination
            vc.zone = self.zone
            vc.optional_country_code = self.optional_country_code
            vc.optional_mobile_no = self.optional_mobile_no
            vc.residence_no = self.residence_no
            vc.residence_date = self.residence_date
            vc.residence_duration = self.residence_duration
            vc.residence_reason = self.residence_reason
            vc.border_entry = self.border_entry
            vc.visa_type = self.visa_type
            vc.visit_type = self.visit_type
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension Form3thVC : UITableViewDelegate,UITableViewDataSource {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrPInsurance.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView?.dequeueReusableCell(withIdentifier: "OtherPersonCell") as! OtherPersonCell
        
        let dicDataIn = arrPInsurance[indexPath.section] as? NSMutableDictionary
        
        let full_name = dicDataIn?.value(forKey: "full_name") as? String
        let date_of_birth = dicDataIn?.value(forKey: "date_of_birth") as? String
        let passport_number = dicDataIn?.value(forKey: "passport_number") as? String
        let passport_copy = dicDataIn?.value(forKey: "passport_copy") as? Data
        let isPDF = dicDataIn?.value(forKey: "isPDF") as? Bool
        let price = dicDataIn?.value(forKey: "price") as? String
        let nationality_other = dicDataIn?.value(forKey: "nationality") as? String
        let gender = dicDataIn?.value(forKey: "gender") as? String

        cell.strPeriod = self.strPeriod
        cell.plan_slug = self.dicPlanDetails.slug ?? ""
        
        if isPDF == true
        {
            cell.btnChangeDoc.isHidden = false
            cell.imgPdf.isHidden = false
            cell.viewUploadPic.isHidden = true
            cell.imgPassportImage.isHidden = true
        }
        else
        {
            cell.imgPdf.isHidden = true
            cell.imgPassportImage.isHidden = false
            
            if (passport_copy?.count ?? 0) > 0
            {
                cell.viewUploadPic.isHidden = true
                cell.btnChangeDoc.isHidden = false
                cell.imgPassportImage.isHidden = false
                cell.imgPassportImage.image = UIImage(data: passport_copy!)
            }
            else
            {
                cell.imgPassportImage.isHidden = true
                
                cell.viewUploadPic.isHidden = false
                cell.btnChangeDoc.isHidden = true
            }
            
            cell.imgPassportImage.contentMode = .scaleAspectFit
        }
        
        cell.datePicker.date = Date()
        
        cell.txtEnterN.text = full_name ?? ""
        cell.TxtDate.text = date_of_birth ?? ""
        cell.TxtxIdNo.text = passport_number ?? ""
        cell.txtEnterPrice.text = price ?? ""
        
        
        cell.viewMain.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1), alpha: 1, x: 0, y: 0, blur: 17, spread: 0)
        
        cell.dateSelected = { [weak self] date in
            guard let self = self else { return }
            // Handle the selected date
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            cell.TxtDate.text = formatter.string(from: date)
        }
        
        
        if isSwitchImg == true
        {
            cell.imgOther.image = UIImage(named: "B_T")
        }
        else
        {
            cell.imgOther.image = UIImage(named: "F_T")
            isSwitchImg = true
        }
        
        let lastSectionIndex = tableView.numberOfSections - 1
        
        // Get the index of the last row in the last section
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        // Construct the IndexPath for the last cell
        let lastCellIndexPath = IndexPath(row: lastRowIndex, section: lastSectionIndex)
        
        
        if lastSectionIndex == indexPath.section
        {
            
            if arrPInsurance.count == 9
            {
                cell.imgOther.isHidden = true
                cell.lblOther.isHidden = true
                cell.btnOther.isHidden = true
                self.setUpMakeToast(msg: "Enter max 10 traveller")
            }
            else
            {
                if arrPInsurance.count == 1 {
                    cell.lblRrmove.isHidden = true
                    cell.btnRemove.isHidden = true
                } else {
                    cell.imgOther.isHidden = false
                    cell.lblOther.isHidden = false
                    cell.btnOther.isHidden = false
                    cell.btnRemove.isHidden = false
                    cell.lblRrmove.isHidden = false
                    cell.btnRemove.tag = indexPath.section
                    cell.btnRemove.addTarget(self, action: #selector(clickedRemove(_:)), for: .touchUpInside)
                }
            }
        }
        else
        {
            cell.lblOther.isHidden = true
            cell.lblRrmove.isHidden = true
            cell.btnOther.isHidden = true
            cell.btnRemove.isHidden = true
            cell.imgOther.isHidden = true
        }
        
        //MARK: - Gender DropDown Code
        cell.dropDownNumber.dataSource = dropdown
        cell.dropDownNumber.anchorView = cell.lblGender
        cell.dropDownNumber.direction = .bottom
        cell.dropDownNumber.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            cell.lblGender.text = item
        }
        cell.dropDownNumber.bottomOffset = CGPoint(x: 0, y: cell.lblGender.bounds.height - 30)
        cell.dropDownNumber.topOffset = CGPoint(x: 0, y: cell.lblGender.bounds.height - 30)
        cell.dropDownNumber.dismissMode = .onTap
        cell.dropDownNumber.textColor = UIColor.darkGray
        cell.dropDownNumber.backgroundColor = UIColor.white
        cell.dropDownNumber.selectionBackgroundColor = UIColor.clear
        cell.dropDownNumber.reloadAllComponents()
        
        cell.btnNatinalty.tag = indexPath.section
        cell.btnNatinalty.addTarget(self, action: #selector(clickedNationality(_:)), for: .touchUpInside)
 
 
        cell.btnGender.tag = indexPath.section
        cell.btnGender.addTarget(self, action: #selector(deopDownButtonClick(_:)), for: .touchUpInside)
        
        cell.btnImg.tag = indexPath.section
        cell.btnImg.addTarget(self, action: #selector(clickdSelcetImage(_:)), for: .touchUpInside)
        
        cell.btnChangeDoc.tag = indexPath.section
        cell.btnChangeDoc.addTarget(self, action: #selector(clickedChangeDoc(_:)), for: .touchUpInside)
        
        cell.btnOther.tag = indexPath.section
        cell.btnOther.addTarget(self, action: #selector(clickedOther(_:)), for: .touchUpInside)
        
        cell.txtEnterN.tag = indexPath.section
        cell.txtEnterN.addTarget(self, action: #selector(clickedNameClick(_ :)), for: .editingChanged)
        
        cell.TxtDate.tag = indexPath.section
        cell.TxtDate.addTarget(self, action: #selector(clickedDOBClick(_ :)), for: .editingDidEnd)
        
        cell.txtEnterPrice.tag = indexPath.section
        cell.txtEnterPrice.addTarget(self, action: #selector(clickedPriceClick(_ :)), for: .editingChanged)
        
        
        cell.TxtxIdNo.tag = indexPath.section
        cell.TxtxIdNo.addTarget(self, action: #selector(clickedPAssClick(_ :)), for: .editingChanged)
        
        return cell
    }
    
    @objc func clickedNationality(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectPopUpVC") as! SelectPopUpVC
        let home = UINavigationController(rootViewController: vc)
        home.modalPresentationStyle = .overFullScreen
        vc.indexPathID = sender.tag
        vc.isDestination = false
        vc.isOpenForm1 = false
        vc.isOpenForm3 = true
        vc.delegateSearch = self
        self.present(home, animated: false)
    }
    
    @objc func clickedOther(_ sender: UIButton) {
        if isSwitchImg == true
        {
            isSwitchImg = false
            addNewMenber = addNewMenber + 1
            
            let dicInsurance = NSMutableDictionary()
            dicInsurance.setValue("", forKey: "full_name")
            dicInsurance.setValue("", forKey: "date_of_birth")
            dicInsurance.setValue("", forKey: "passport_number")
            dicInsurance.setValue("", forKey: "passport_copy")
            dicInsurance.setValue(false, forKey: "isPDF")
            dicInsurance.setValue("", forKey: "price")
            dicInsurance.setValue("", forKey: "nationality")
            dicInsurance.setValue("", forKey: "gender")

            self.arrPInsurance.add(dicInsurance)
            
        }
        else
        {
            isSwitchImg = true
        }
        tblView?.reloadData()
    }
    
    @objc func deopDownButtonClick(_ sender: UIButton) {
        let indexPath = IndexPath(row: 0, section: sender.tag)
        
        if let cell = self.tblView?.cellForRow(at: indexPath) as? OtherPersonCell {
            cell.dropDownNumber.show()
        } else {
            print("Cell is nil.")
        }
    }
    
    @objc func clickedNameClick(_ sender: UITextField) {
        
        let dicDataIn = arrPInsurance[sender.tag] as? NSMutableDictionary
        let passport_copy = dicDataIn?.value(forKey: "passport_copy") as? Data
        let isPDF = dicDataIn?.value(forKey: "isPDF") as? Bool
        
        
        let indexPath = IndexPath(row: 0, section: sender.tag)
        let cell = tblView?.cellForRow(at: indexPath) as! OtherPersonCell
        
        let dicInsurance = NSMutableDictionary()
        dicInsurance.setValue(sender.text ?? "", forKey: "full_name")
        dicInsurance.setValue(cell.TxtDate.text ?? "", forKey: "date_of_birth")
        dicInsurance.setValue(cell.TxtxIdNo.text ?? "", forKey: "passport_number")
        dicInsurance.setValue(passport_copy, forKey: "passport_copy")
        dicInsurance.setValue(isPDF, forKey: "isPDF")
        dicInsurance.setValue(cell.txtEnterPrice.text ?? "", forKey: "price")
        dicInsurance.setValue(cell.lblNatinality.text ?? "", forKey: "nationality")
        dicInsurance.setValue(cell.lblGender.text ?? "", forKey: "gender")

        self.arrPInsurance[sender.tag] = dicInsurance
    }
 
    @objc func clickedDOBClick(_ sender: UITextField) {
        
        selectedIndex = sender.tag
        
        let dicDataIn = arrPInsurance[sender.tag] as? NSMutableDictionary
        let passport_copy = dicDataIn?.value(forKey: "passport_copy") as? Data
        let isPDF = dicDataIn?.value(forKey: "isPDF") as? Bool
        
        
        let indexPath = IndexPath(row: 0, section: sender.tag)
        
        if let cell = tblView?.cellForRow(at: indexPath) as? OtherPersonCell
        {
            let dicInsurance = NSMutableDictionary()
            dicInsurance.setValue(cell.txtEnterN.text ?? "", forKey: "full_name")
            dicInsurance.setValue(sender.text ?? "", forKey: "date_of_birth")
            dicInsurance.setValue(cell.TxtxIdNo.text ?? "", forKey: "passport_number")
            dicInsurance.setValue(passport_copy, forKey: "passport_copy")
            dicInsurance.setValue(isPDF, forKey: "isPDF")
            dicInsurance.setValue(cell.txtEnterPrice.text ?? "", forKey: "price")
            dicInsurance.setValue(cell.lblGender.text ?? "", forKey: "gender")
            dicInsurance.setValue(cell.lblNatinality.text ?? "", forKey: "nationality")

            
            self.arrPInsurance[sender.tag] = dicInsurance
        }
    }
    
    @objc func clickedGenderClick(_ sender: UITextField) {
        
        let dicDataIn = arrPInsurance[sender.tag] as? NSMutableDictionary
        let passport_copy = dicDataIn?.value(forKey: "passport_copy") as? Data
        let isPDF = dicDataIn?.value(forKey: "isPDF") as? Bool
        
        let indexPath = IndexPath(row: 0, section: sender.tag)
        
        let cell = tblView?.cellForRow(at: indexPath) as! OtherPersonCell
        
        let dicInsurance = NSMutableDictionary()
        dicInsurance.setValue(cell.txtEnterN.text ?? "", forKey: "full_name")
        dicInsurance.setValue(cell.TxtDate.text ?? "", forKey: "date_of_birth")
        dicInsurance.setValue(cell.TxtxIdNo.text ?? "", forKey: "passport_number")
        dicInsurance.setValue(passport_copy, forKey: "passport_copy")
        dicInsurance.setValue(isPDF, forKey: "isPDF")
        dicInsurance.setValue(cell.txtEnterPrice.text ?? "", forKey: "price")
        dicInsurance.setValue(cell.lblGender.text ?? "", forKey: "gender")
        dicInsurance.setValue(cell.lblNatinality.text ?? "", forKey: "nationality")

        self.arrPInsurance[sender.tag] = dicInsurance
    }
    
    @objc func clickedPAssClick(_ sender: UITextField) {
        
        let dicDataIn = arrPInsurance[sender.tag] as? NSMutableDictionary
        let passport_copy = dicDataIn?.value(forKey: "passport_copy") as? Data
        let isPDF = dicDataIn?.value(forKey: "isPDF") as? Bool
        
        
        let indexPath = IndexPath(row: 0, section: sender.tag)
        
        let cell = tblView?.cellForRow(at: indexPath) as! OtherPersonCell
        
        let dicInsurance = NSMutableDictionary()
        dicInsurance.setValue(cell.txtEnterN.text ?? "", forKey: "full_name")
        dicInsurance.setValue(cell.TxtDate.text ?? "", forKey: "date_of_birth")
        dicInsurance.setValue(sender.text ?? "", forKey: "passport_number")
        dicInsurance.setValue(passport_copy, forKey: "passport_copy")
        dicInsurance.setValue(isPDF, forKey: "isPDF")
        dicInsurance.setValue(cell.txtEnterPrice.text ?? "", forKey: "price")
        dicInsurance.setValue(cell.lblGender.text ?? "", forKey: "gender")
        dicInsurance.setValue(cell.lblNatinality.text ?? "", forKey: "nationality")

        self.arrPInsurance[sender.tag] = dicInsurance
    }
    
    
    @objc func clickedPriceClick(_ sender: UITextField) {
        
        let dicDataIn = arrPInsurance[sender.tag] as? NSMutableDictionary
        let passport_copy = dicDataIn?.value(forKey: "passport_copy") as? Data
        let isPDF = dicDataIn?.value(forKey: "isPDF") as? Bool
        
        let indexPath = IndexPath(row: 0, section: sender.tag)
        
        let cell = tblView?.cellForRow(at: indexPath) as! OtherPersonCell
        
        let dicInsurance = NSMutableDictionary()
        dicInsurance.setValue(cell.txtEnterN.text ?? "", forKey: "full_name")
        dicInsurance.setValue(cell.TxtDate.text ?? "", forKey: "date_of_birth")
        dicInsurance.setValue(cell.TxtxIdNo.text ?? "", forKey: "passport_number")
        dicInsurance.setValue(passport_copy, forKey: "passport_copy")
        dicInsurance.setValue(isPDF, forKey: "isPDF")
        dicInsurance.setValue(sender.text ?? "", forKey: "price")
        dicInsurance.setValue(cell.lblGender.text ?? "", forKey: "gender")
        dicInsurance.setValue(cell.lblNatinality.text ?? "", forKey: "nationality")

        self.arrPInsurance[sender.tag] = dicInsurance
    }
    
    
    @objc func clickdSelcetImage(_ sender: UIButton) {
        
        isCurrentLiveTag = sender.tag
        
        let dicDataIn = arrPInsurance[sender.tag] as? NSMutableDictionary
        
        let full_name = dicDataIn?.value(forKey: "full_name") as? String
        let date_of_birth = dicDataIn?.value(forKey: "date_of_birth") as? String
        let passport_number = dicDataIn?.value(forKey: "passport_number") as? String
        let nationality_other = dicDataIn?.value(forKey: "nationality") as? String
        let gender = dicDataIn?.value(forKey: "gender") as? String
        let passport_copy = dicDataIn?.value(forKey: "passport_copy") as? Data
        let isPDF = dicDataIn?.value(forKey: "isPDF") as? Bool
        let price = dicDataIn?.value(forKey: "price") as? Bool
        
        if isPDF == true
        {
            
        }
        else
        {
            if (passport_copy?.count ?? 0) > 0
            {
                let indexPath = IndexPath(row: 0, section: self.isCurrentLiveTag)
                
                let cell = tblView?.cellForRow(at: indexPath) as! OtherPersonCell
                
                if let img = cell.imgPassportImage.image{
                    let photo = ChatImage()
                    photo.image = img
                    
                    let photosViewController: NYTPhotosViewController = NYTPhotosViewController(photos: [photo])
                    present(photosViewController, animated: true, completion: nil)
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
        
        
    }
    
    @objc func clickedRemove(_ sender: UIButton)
    {
        
        self.arrPInsurance.removeLastObject()
        
        tblView?.reloadData()
    }
    
    
    
    @objc func clickedChangeDoc(_ sender: UIButton)
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        isUploadImg = true
        
        if let image = info[.originalImage] as? UIImage {
            let indexPath = IndexPath(row: 0, section: self.isCurrentLiveTag)
            
            // Check if the indexPath is valid for the table view
            if indexPath.section < tblView?.numberOfSections ?? 0 && indexPath.row < tblView?.numberOfRows(inSection: indexPath.section) ?? 0,
               let cell = tblView?.cellForRow(at: indexPath) as? OtherPersonCell {
                
                cell.imgPdf.isHidden = true
                let imgData = image.jpegData(compressionQuality: 0.3)
                
                let dicInsurance = NSMutableDictionary()
                dicInsurance.setValue(cell.txtEnterN.text ?? "", forKey: "full_name")
                dicInsurance.setValue(cell.TxtDate.text ?? "", forKey: "date_of_birth")
                dicInsurance.setValue(cell.lblGender.text ?? "", forKey: "gender")
                dicInsurance.setValue(cell.lblNatinality.text ?? "", forKey: "nationality")

                dicInsurance.setValue(cell.TxtxIdNo.text ?? "", forKey: "passport_number")
                dicInsurance.setValue(imgData, forKey: "passport_copy")
                dicInsurance.setValue(false, forKey: "isPDF")
                dicInsurance.setValue(cell.txtEnterPrice.text ?? "", forKey: "price")
                
                self.arrPInsurance[self.isCurrentLiveTag] = dicInsurance
                self.tblView?.reloadData()
            } else {
                print("Error: Cell is nil or indexPath is invalid.")
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: -UIDocumentPickerDelegate method
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let pdfURL = urls.first {
            
            print("Selected PDF file: \(pdfURL)")
            
            isUploadImg = true
            isUploadPDF = true
            
            let cico = pdfURL as URL
            let url_New = URL(string: cico.relativeString)
            
            let pdfData = try! Data(contentsOf: url_New!)
            let data7777 : Data = pdfData
            
            let indexPath = IndexPath(row: 0, section: self.isCurrentLiveTag)
            
            let cell = tblView?.cellForRow(at: indexPath) as! OtherPersonCell
            
            let dicInsurance = NSMutableDictionary()
            dicInsurance.setValue(cell.txtEnterN.text ?? "", forKey: "full_name")
            dicInsurance.setValue(cell.TxtDate.text ?? "", forKey: "date_of_birth")
            dicInsurance.setValue(cell.lblGender.text ?? "", forKey: "gender")
            dicInsurance.setValue(cell.lblNatinality.text ?? "", forKey: "nationality")
            dicInsurance.setValue(cell.TxtxIdNo.text ?? "", forKey: "passport_number")
            dicInsurance.setValue(data7777, forKey: "passport_copy")
            dicInsurance.setValue(true, forKey: "isPDF")
            dicInsurance.setValue(cell.txtEnterPrice.text ?? "", forKey: "price")
            
            self.arrPInsurance[self.isCurrentLiveTag] = dicInsurance
            
            self.tblView?.reloadData()
            
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = self.tblView?.dequeueReusableCell(withIdentifier: "OtherPersonCell") as! OtherPersonCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("headerView", owner: self, options: [:])?.first as! headerView
        
        headerView.lblPerson.text = "Traveler \(section+2)"
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    
}

//MARK: - UITableView Cell File
class OtherPersonCell : UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var btnGender: UIButton!
    
    @IBOutlet weak var lblNatinality: UILabel!
    @IBOutlet weak var btnNatinalty: UIButton!
 
    
    @IBOutlet weak var txtEnterN: UITextField!
    @IBOutlet weak var TxtDate: UITextField!
    @IBOutlet weak var txtEnterPrice: UITextField!
    //  @IBOutlet weak var txtSelectGender: UITextField!
    @IBOutlet weak var TxtxIdNo: UITextField!
    @IBOutlet weak var btnImg: UIButton!
    //  @IBOutlet weak var btnGender: UIButton!
    @IBOutlet weak var dobButton: UIButton!
    @IBOutlet weak var imgPassportImage: UIImageView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imgPdf: UIImageView!
    @IBOutlet weak var viewUploadPic: UIView!
    @IBOutlet weak var btnChangeDoc: UIButton!
    @IBOutlet weak var btnOther: UIButton!
    @IBOutlet weak var imgOther: UIImageView!
    @IBOutlet weak var lblOther: UILabel!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var lblRrmove: UILabel!
    let dropDownNumber = DropDown()
    let datePicker = UIDatePicker()
    
    var dateSelected: ((Date) -> Void)?
    
    var selectedIndex = -1
    
    var strPeriod = 0
    
    var plan_slug = ""
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        datePicker.date = Date()
        
        // Set up date picker properties
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(donedatePickerSDate), for: .valueChanged)
        
        let maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        let minmumDate = Calendar.current.date(byAdding: .year, value: -86, to: Date())
        datePicker.minimumDate = minmumDate
        datePicker.maximumDate = maximumDate
        TxtDate.inputView = datePicker
    }
    
    @objc func donedatePickerSDate(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        TxtDate.text = formatter.string(from: datePicker.date)
        //        self.view.endEditing(true)
        
        callGetPriceAPI()
        //  delegatePrice?.onPizzaReady(type: TxtDate.text ?? "", strPeriod: "\(strPeriod)", plan_slug: plan_slug)
    }
    
    @objc func datePickerValueChanged() {
        // dateSelected?(datePicker.date)
    }
    
    func callGetPriceAPI()
    {
        //  APIClient.sharedInstance.showIndicator()
        
        let parm = ["date_of_birth":self.TxtDate.text ?? "","no_of_days":"\(strPeriod)","plan_slug":plan_slug]
        
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
                        
                        self.txtEnterPrice.text = "\(appDelegate?.objContryCodeConversionRate.abbreviation ?? "") \(formattedString)"
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
