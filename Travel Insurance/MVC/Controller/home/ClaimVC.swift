//
//  ClaimVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 07/05/25.
//

import UIKit
import MobileCoreServices
import AVFoundation
import DropDown

class ClaimVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate {
    
    @IBOutlet weak var lblPolictNumber: UILabel!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtReason: UITextView!
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var viewSelectDrop: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.collectionViewLayout = flowLayout
        }
    }
    @IBOutlet weak var heightUploaddo: NSLayoutConstraint!
    
    let sectionInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    let AitemsPerRow : CGFloat = 3
    var flowLayout: UICollectionViewFlowLayout {
        let _flowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.sectionInsets.left * (self.AitemsPerRow + 1)
            let availableWidth = self.collectionView.frame.width - paddingSpace
            let widthPerItem = availableWidth / self.AitemsPerRow
            
            _flowLayout.itemSize = CGSize(width: 90, height: 90)
            
            _flowLayout.sectionInset = self.sectionInsets
            _flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
            _flowLayout.minimumInteritemSpacing = 10
            _flowLayout.minimumLineSpacing = 10
        }
        
        // edit properties here
        return _flowLayout
    }
    
    var datePickerDOB = UIDatePicker()
    var imagePicker: ImagePicker!
    var selectedImg: String?
    
    var imagePickerNew = UIImagePickerController()
    var isUpload = false
    var isUploadPDF = false
    var UploadData = Data()
    var imageDataKey = UIImage()
    var isUploadWay = false
    
    let dropDownSelect = DropDown()
    var objMyPolocyDetail = TIPolicyDetailUserinsurancedata()
    
    var strAllUploadDocument = 1
    var arrAllDocument = NSMutableArray()
    var delegate:PizzaDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblPolictNumber.text = objMyPolocyDetail.fullName ?? ""
        
//        setDropDown()
        // Do any additional setup after loading the view.
    }
    /*
    func setDropDown()
    {
        let arrName = NSMutableArray()
        
        for objsd in objMyPolocyDetail
        {
            if objsd.policy_status == "success" && objsd.is_claim == "" {
                arrName.add(objsd.fullName ?? "")
            }
        }
        
        dropDownSelect.dataSource = arrName as! [String]
        dropDownSelect.anchorView = viewSelectDrop
        dropDownSelect.direction = .bottom
        
        // Selection Action
        dropDownSelect.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else { return }
            print("Selected item: \(item) at index: \(index)")
            self.lblPolictNumber.text = item
            
            
            for objsd in objMyPolocyDetail
            {
                if objsd.fullName == item
                {
                    self.user_insurance_id = "\(objsd.insuranceId ?? 0)"
                    self.policy_number = objsd.policyNo ?? ""
                }
            }
            
        }
        
        // Styling
        dropDownSelect.bottomOffset = CGPoint(x: 0, y: lblPolictNumber.bounds.height)
        dropDownSelect.dismissMode = .onTap
        dropDownSelect.textColor = .black
        dropDownSelect.backgroundColor = .white
        dropDownSelect.selectionBackgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        
    }
     */
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickedSelectPerson(_ sender: Any) {
        dropDownSelect.show()
    }
    
    @IBAction func clickedDate(_ sender: UITextField) {
        datePickerDOB.datePickerMode = .date
        datePickerDOB.preferredDatePickerStyle = .wheels
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Adjust format to match your input
        dateFormatter.timeZone = TimeZone.current
        
        let date = formatter.date(from: self.objMyPolocyDetail.policy_start_date)
        let date23 = formatter.date(from: self.objMyPolocyDetail.policy_end_date)

        let expiryDateString = self.objMyPolocyDetail.policy_end_date ?? "" // Example expiry date string
        if let expiryDate = dateFormatter.date(from: expiryDateString) {
            let today = Date()

            if expiryDate > today {
                print("Expiry date is in the future")
                datePickerDOB.maximumDate = today
            } else {
                print("Expiry date is in the past or today")
                datePickerDOB.maximumDate = date23
            }
        } else {
            print("Invalid date format")
            datePickerDOB.maximumDate = date23
        }
        
        datePickerDOB.minimumDate = date
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "CANCEL", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        sender.inputAccessoryView = toolbar
        sender.inputView = datePickerDOB
    }
    
    
    @IBAction func clickedSubmitClaim(_ sender: Any) {
        if lblPolictNumber.text == "Select Person" {
            self.setUpMakeToast(msg: "Please select person")
        } else if txtDate.text == "" {
            self.setUpMakeToast(msg: "Please select accident date")
        } else if txtReason.text == "" {
            self.setUpMakeToast(msg: "Please enter claim reason")
        } else if arrAllDocument.count == 0 {
            self.setUpMakeToast(msg: "Please upload document")
        } else {
            myImageUploadRequest(imgKey: "claim_documents")
        }
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        txtDate.text = formatter.string(from: datePickerDOB.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }
    
    func openCamera()
    {
        
        checkCameraPermission()
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePickerNew.delegate = self
            imagePickerNew.sourceType = UIImagePickerController.SourceType.camera
            imagePickerNew.allowsEditing = true
            imagePickerNew.mediaTypes = [kUTTypeImage as String]
            self.present(imagePickerNew, animated: true, completion: nil)
        }
        else
        {
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("You don't have camera")
        }
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
    
    func openGallary()
    {
        
        imagePickerNew.delegate = self
        imagePickerNew.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerNew.allowsEditing = true
        imagePickerNew.mediaTypes = ["public.image"]
        self.present(imagePickerNew, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            let imageurl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            selectedImg = imageurl?.lastPathComponent
            self.isUpload = true
            DispatchQueue.main.async {
                self.imageDataKey = image
                
                let imageData = image.jpegData(compressionQuality: 0.8)
                
                var dicMain = NSMutableDictionary()
                dicMain.setValue("image", forKey: "type")
                dicMain.setValue(imageData, forKey: "data")
                
                self.arrAllDocument.add(dicMain)
                
                if self.arrAllDocument.count > 2 {
                    self.heightUploaddo.constant = 100*2
                } else {
                    self.heightUploaddo.constant = 100
                }
                
                self.collectionView.reloadData()
                
            }
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            let imageurl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            selectedImg = imageurl?.lastPathComponent
            self.isUpload = true
            DispatchQueue.main.async {
                self.imageDataKey = image
                
                let imageData = image.jpegData(compressionQuality: 0.8)
                
                var dicMain = NSMutableDictionary()
                dicMain.setValue("image", forKey: "type")
                dicMain.setValue(imageData, forKey: "data")
                
                self.arrAllDocument.add(dicMain)
                
                if self.arrAllDocument.count > 2 {
                    self.heightUploaddo.constant = 100*2
                } else {
                    self.heightUploaddo.constant = 100
                }
                
                self.collectionView.reloadData()
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - pdf select code
    func showPDFPicker() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
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
                    
                    UploadData = data7777
                    isUploadWay = true
                    isUploadPDF = true
                    
                    var dicMain = NSMutableDictionary()
                    dicMain.setValue("pdf", forKey: "type")
                    dicMain.setValue(data7777, forKey: "data")
                    
                    self.arrAllDocument.add(dicMain)
                    
                    if self.arrAllDocument.count > 2 {
                        self.heightUploaddo.constant = 100*2
                    } else {
                        self.heightUploaddo.constant = 100
                    }
                    
                    self.collectionView.reloadData()
                    
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
    
    func myImageUploadRequest(imgKey: String) {
        
        APIClient.sharedInstance.showIndicator()
        
        let authorisation = UserDefaults.standard.value(forKey: "token") as? String
        
        let myUrl = NSURL(string: BASE_URL + GET_CLAIM);
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        request.addValue("Bearer \(authorisation ?? "")", forHTTPHeaderField: "Authorization")
        
        let boundary = generateBoundaryString()
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let param = [
            "policy_no":"\(self.objMyPolocyDetail.policyNo ?? "")",
            "accident_date":"\(self.txtDate.text ?? "")",
            "user_insurance_id":"\(self.objMyPolocyDetail.insuranceId ?? 0)",
            "claim_reason":self.txtReason.text ?? ""]
        
        print(param)
        
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: imgKey, boundary: boundary, imgKey: imgKey) as Data
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            APIClient.sharedInstance.hideIndicator()
            
            if error != nil {
                print("error=\(error!)")
                return
            }
            
            // print reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("response data = \(responseString!)")
            
            do{
                
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    
                    // try to read out a string array+++
                    let status = json["status"] as? Int
                    
                    if status == 1
                    {
                        if let message = json["message"] as? String
                        {
                            DispatchQueue.main.async {
                                self.setUpMakeToast(msg: "Claim Submitted Successfully")
                                self.delegate?.onPizzaReady(type: true, policy_id: self.objMyPolocyDetail.transactionDetailsId ?? 0)
                                self.clickedBack(self)
                            }
                        }
                    }
                    else
                    {
                        DispatchQueue.main.async {
                            APIClient.sharedInstance.hideIndicator()
                            let message = json["message"] as? String
                            self.setUpMakeToast(msg: message ?? "")
                        }
                        
                    }
                    
                    
                }
                
            }catch{
                
            }
            
        }
        
        task.resume()
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, boundary: String, imgKey: String) -> NSData {
        
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        var filename = ""
        var mimetype = ""
        
        for (index,obj) in arrAllDocument.enumerated() {
            let dicData = obj as? NSMutableDictionary
            
            let type = dicData?.value(forKey: "type") as? String ?? ""
            let data = dicData?.value(forKey: "data") as? Data
            
            if type == "pdf" {
                filename = "application.pdf"
                mimetype = "application/pdf"
                
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\("claim_documents[\(index)]")\"; filename=\"\(filename)\"\r\n")
                body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
                body.append(data!)
                body.appendString(string: "\r\n")
                body.appendString(string: "--\(boundary)--\r\n")
            } else {
                filename = "\(imgKey).jpg"
                mimetype = "image/jpeg"
                
                
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\("claim_documents[\(index)]")\"; filename=\"\(filename)\"\r\n")
                body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
                body.append(data!)
                body.appendString(string: "\r\n")
                body.appendString(string: "--\(boundary)--\r\n")
            }

        }
       
        
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func randomString(of length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var s = ""
        for _ in 0 ..< length {
            s.append(letters.randomElement()!)
        }
        return s
    }
    
}

extension ClaimVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrAllDocument.count < 5 ? arrAllDocument.count + 1 : 5 // Show "Add" cell if < 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddClaimDocument", for: indexPath) as! AddClaimDocument
        
        if indexPath.item < arrAllDocument.count {
            
            let dicData = arrAllDocument[indexPath.item] as? NSMutableDictionary
            
            let type = dicData?.value(forKey: "type") as? String ?? ""
            let data = dicData?.value(forKey: "data") as? Data

            cell.imgPic.image = type == "image" ? UIImage(data: data!) : UIImage(named: "pdf")
        } else {
            cell.imgPic.image = UIImage(named: "new-page")
        }
        
        return cell
    }
    // MARK: - UICollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == arrAllDocument.count && arrAllDocument.count < 5 {
            let alert1 = UIAlertController(title: nil , message: nil, preferredStyle: .actionSheet)
            
            alert1.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.openCamera()
            }))
            
            alert1.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                self.openGallary()
            }))
            
            alert1.addAction(UIAlertAction(title: "Select PDF", style: .default, handler: { _ in
                self.showPDFPicker()
            }))
            
            alert1.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert1, animated: true, completion: nil)
        }
    }
    
}

class AddClaimDocument: UICollectionViewCell {
    
    @IBOutlet weak var imgPic: UIImageView!
}
