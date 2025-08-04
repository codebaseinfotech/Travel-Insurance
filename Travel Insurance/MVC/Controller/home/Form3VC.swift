//
//  Form3VC.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 19/01/24.
//

import UIKit
import MobileCoreServices
import DropDown
import NYTPhotoViewer
import AVFoundation

class Form3VC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate, UITextFieldDelegate, onSeachSelect {
  
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var tblView: UITableView?
    
    @IBOutlet weak var viewTop: UIView!
    
    var arryOfImage = NSMutableArray()
    
    var dropdown = ["Male","Female","Other"]
    
    let datePickerDOB = UIDatePicker()
    var pagCount = 0
    
    var selectIndexImg = -1
    
    var selectedIndex = -1
    
    var arrPInsurance = NSMutableArray()
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
    
    var planid = ""
    
    var isCurrentLiveTag = -1
    
    var isUploadImg = false
    var isUploadPDF = false
    
    var dicPlanDetails = TIPlanDetailsResponse()
    
    var selectedTraveller = 0
    
    var strPeriod = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text = dicPlanDetails.planType ?? ""
       
//        for i in 1...pagCount {
//            let dicInsurance = NSMutableDictionary()
//            dicInsurance.setValue("", forKey: "full_name")
//            dicInsurance.setValue("", forKey: "date_of_birth")
//            dicInsurance.setValue("", forKey: "gender")
//            dicInsurance.setValue("", forKey: "passport_number")
//            dicInsurance.setValue("", forKey: "passport_copy")
//            dicInsurance.setValue(false, forKey: "isPDF")
//            self.arrPInsurance.add(dicInsurance)
//        }
 
        if let swiftArray = self.arrPInsurance as? [Any] {
            // Reverse the Swift array
            let reversedArray = Array(swiftArray.reversed())

            // Convert the reversed array back to an NSMutableArray if needed
            arrPInsurance = NSMutableArray(array: reversedArray)

         } else {
            print("Failed to convert NSMutableArray to Swift array.")
        }
        
        
        tblView?.dataSource = self
        tblView?.delegate = self
        
        viewTop.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 16, spread: 0)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if arrPInsuranceSaving.count != 0
        {
            self.arrPInsurance = arrPInsuranceSaving
            print("arrPInsurance \(arrPInsurance.count)")
        }
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
           
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "InsuranceDetailVC") as! InsuranceDetailVC
            vc.planid = self.planid
            vc.arrPInsurance = arrPInsurance
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
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension Form3VC : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrPInsurance.count - 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView?.dequeueReusableCell(withIdentifier: "OtherPersonCell") as! OtherPersonCell
        
        let dicDataIn = arrPInsurance[indexPath.section] as? NSMutableDictionary
        
        let full_name = dicDataIn?.value(forKey: "full_name") as? String
        let date_of_birth = dicDataIn?.value(forKey: "date_of_birth") as? String
        let gender = dicDataIn?.value(forKey: "gender") as? String
        let passport_number = dicDataIn?.value(forKey: "passport_number") as? String
        let passport_copy = dicDataIn?.value(forKey: "passport_copy") as? Data
        let isPDF = dicDataIn?.value(forKey: "isPDF") as? Bool
        
        cell.strPeriod = strPeriod
        cell.plan_slug = dicPlanDetails.slug ?? ""
        
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
        //cell.txtSelectGender.text = gender ?? ""
        cell.TxtxIdNo.text = passport_number ?? ""

        //MARK: - cell Button Clickd
        cell.btnImg.tag = indexPath.section
        cell.btnImg.addTarget(self, action: #selector(clickdSelcetImage(_:)), for: .touchUpInside)
        
//        cell.btnGender.tag = indexPath.section
//        cell.btnGender.addTarget(self, action: #selector(deopDownButtonClick(_:)), for: .touchUpInside)
        
        cell.viewMain.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1), alpha: 1, x: 0, y: 0, blur: 17, spread: 0)
        
        cell.dateSelected = { [weak self] date in
            guard let self = self else { return }
            // Handle the selected date
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            cell.TxtDate.text = formatter.string(from: date)
        }
        
        //========================================
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
        //========================================
        
        
     
        cell.btnChangeDoc.tag = indexPath.section
        cell.btnChangeDoc.addTarget(self, action: #selector(clickedChangeDoc(_:)), for: .touchUpInside)
        
        cell.txtEnterN.tag = indexPath.section
        cell.txtEnterN.addTarget(self, action: #selector(clickedNameClick(_ :)), for: .editingChanged)
        
        cell.TxtDate.tag = indexPath.section
        cell.TxtDate.addTarget(self, action: #selector(clickedDOBClick(_ :)), for: .editingDidEnd)
        
 
        cell.TxtxIdNo.tag = indexPath.section
        cell.TxtxIdNo.addTarget(self, action: #selector(clickedPAssClick(_ :)), for: .editingChanged)
 
        return cell
    }
    
    @objc func clickedNatinaClick(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectPopUpVC") as! SelectPopUpVC
        let home = UINavigationController(rootViewController: vc)
        home.modalPresentationStyle = .overFullScreen
        vc.isDestination = false
        vc.isOpenForm1 = false
        vc.delegateSearch = self
        self.present(home, animated: false)
    }
    
    func onSelectText(text: String, isDestintion: Bool, id: Int) {
        
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
     //   dicInsurance.setValue(cell.txtSelectGender.text ?? "", forKey: "gender")
        dicInsurance.setValue(cell.TxtxIdNo.text ?? "", forKey: "passport_number")
        dicInsurance.setValue(passport_copy, forKey: "passport_copy")
        dicInsurance.setValue(isPDF, forKey: "isPDF")

        
        self.arrPInsurance[sender.tag] = dicInsurance
    }
    
    @objc func clickedDOBClick(_ sender: UITextField) {
        
        let dicDataIn = arrPInsurance[sender.tag] as? NSMutableDictionary
        let passport_copy = dicDataIn?.value(forKey: "passport_copy") as? Data
        let isPDF = dicDataIn?.value(forKey: "isPDF") as? Bool

        
        let indexPath = IndexPath(row: 0, section: sender.tag)

        if let cell = tblView?.cellForRow(at: indexPath) as? OtherPersonCell
        {
            let dicInsurance = NSMutableDictionary()
            dicInsurance.setValue(cell.txtEnterN.text ?? "", forKey: "full_name")
            dicInsurance.setValue(sender.text ?? "", forKey: "date_of_birth")
       //     dicInsurance.setValue(cell.txtSelectGender.text ?? "", forKey: "gender")
            dicInsurance.setValue(cell.TxtxIdNo.text ?? "", forKey: "passport_number")
            dicInsurance.setValue(passport_copy, forKey: "passport_copy")
            dicInsurance.setValue(isPDF, forKey: "isPDF")

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
        dicInsurance.setValue(sender.text ?? "", forKey: "gender")
        dicInsurance.setValue(cell.TxtxIdNo.text ?? "", forKey: "passport_number")
        dicInsurance.setValue(passport_copy, forKey: "passport_copy")
        dicInsurance.setValue(isPDF, forKey: "isPDF")

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
    //    dicInsurance.setValue(cell.txtSelectGender.text ?? "", forKey: "gender")
        dicInsurance.setValue(sender.text ?? "", forKey: "passport_number")
        dicInsurance.setValue(passport_copy, forKey: "passport_copy")
        dicInsurance.setValue(isPDF, forKey: "isPDF")

        self.arrPInsurance[sender.tag] = dicInsurance
    }
    
    
    @objc func deopDownButtonClick(_ sender: UIButton) {
        let indexPath = IndexPath(row: 0, section: sender.tag)
        
        if let cell = self.tblView?.cellForRow(at: indexPath) as? OtherPersonCell {
            cell.dropDownNumber.show()
        } else {
            print("Cell is nil.")
        }
    }
    
    @objc func clickdSelcetImage(_ sender: UIButton) {
        
        isCurrentLiveTag = sender.tag
        
        let dicDataIn = arrPInsurance[sender.tag] as? NSMutableDictionary
        
        let full_name = dicDataIn?.value(forKey: "full_name") as? String
        let date_of_birth = dicDataIn?.value(forKey: "date_of_birth") as? String
        let gender = dicDataIn?.value(forKey: "gender") as? String
        let passport_number = dicDataIn?.value(forKey: "passport_number") as? String
        let passport_copy = dicDataIn?.value(forKey: "passport_copy") as? Data
        let isPDF = dicDataIn?.value(forKey: "isPDF") as? Bool
        
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

            let cell = tblView?.cellForRow(at: indexPath) as! OtherPersonCell
            
            cell.imgPdf.isHidden = true
            
            let imgData = image.jpegData(compressionQuality: 0.3)

            let dicInsurance = NSMutableDictionary()
            dicInsurance.setValue(cell.txtEnterN.text ?? "", forKey: "full_name")
            dicInsurance.setValue(cell.TxtDate.text ?? "", forKey: "date_of_birth")
      //      dicInsurance.setValue(cell.txtSelectGender.text ?? "", forKey: "gender")
            dicInsurance.setValue(cell.TxtxIdNo.text ?? "", forKey: "passport_number")
            dicInsurance.setValue(imgData, forKey: "passport_copy")
            dicInsurance.setValue(false, forKey: "isPDF")
            self.arrPInsurance[self.isCurrentLiveTag] = dicInsurance
           
        }
        
        
        self.tblView?.reloadData()
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: -UIDocumentPickerDelegate method
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let pdfURL = urls.first {
            // Handle the selected PDF file
            // You can display the PDF, save it, or perform other actions
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
        //    dicInsurance.setValue(cell.txtSelectGender.text ?? "", forKey: "gender")
            dicInsurance.setValue(cell.TxtxIdNo.text ?? "", forKey: "passport_number")
            dicInsurance.setValue(data7777, forKey: "passport_copy")
            dicInsurance.setValue(true, forKey: "isPDF")
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



