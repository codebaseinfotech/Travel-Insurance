//
//  CancelPolicyVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 21/02/24.
//

import UIKit
import MobileCoreServices
import UIKit
import AVFoundation
import DropDown



class CancelPolicyVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate {
    
    @IBOutlet weak var ImgView: UIView!
    @IBOutlet weak var textViewReason: UITextView!
    
    @IBOutlet weak var imgCancel: UIImageView!
    @IBOutlet weak var imgUpPDF: UIImageView!
    @IBOutlet weak var viewAddU: UIView!
    
    @IBOutlet weak var viewSelectDrop: UIView!
    @IBOutlet weak var lblSelect: UILabel!
    @IBOutlet weak var viewSelect: UIView!
    @IBOutlet weak var viewSelectHeight: NSLayoutConstraint!
    @IBOutlet weak var viewSelectTop: NSLayoutConstraint!
    
    let dropDownSelect = DropDown()
    var arrselct = ["abba","sss"]
    var showImage = 0
    
    var strPolicyNo = ""
    
    var objMyPolocyDetail: [TIPolicyDetailUserinsurancedata] = [TIPolicyDetailUserinsurancedata]()
    
    var delegate:PizzaDelegate?
    var policyNo = ""
    var imagePicker: ImagePicker!
    var selectedImg: String?
    
    var imagePickerNew = UIImagePickerController()
    
    var strId = 0
    
    var isSelectPerson = false
    
    var isUpload = false
    var isUploadPDF = false
    var UploadData = Data()
    var imageDataKey = UIImage()
    
    var isUploadWay = false
    var insuranceId = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDropDown()
        if showImage == 1
        {
            ImgView.isHidden = true
        }
        else
        {
            ImgView.isHidden = false
        }
        if isSelectPerson == true {
            viewSelect.isHidden = false
            viewSelectHeight.constant = 70
            viewSelectTop.constant = 20
        }
        else {
            viewSelect.isHidden = true
            viewSelectHeight.constant = 0
            viewSelectTop.constant = 0
        }
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickedSelectPerson(_ sender: Any) {
        self.dropDownSelect.show()
    }
    
    func setDropDown()
    {
        
        let arrName = NSMutableArray()
       
        for objsd in objMyPolocyDetail
        {
            if objsd.policy_status == "success" {
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
            self.lblSelect.text = item
            
            
            for objsd in objMyPolocyDetail
            {
                if objsd.fullName == item
                {
                    self.insuranceId = objsd.insuranceId ?? 0
                    self.strPolicyNo = objsd.policyNo ?? ""
                    print(self.strPolicyNo)
                }
            }
            
        }
        
        // Styling
        dropDownSelect.bottomOffset = CGPoint(x: 0, y: lblSelect.bounds.height)
        dropDownSelect.dismissMode = .onTap
        dropDownSelect.textColor = .black
        dropDownSelect.backgroundColor = .white
        dropDownSelect.selectionBackgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        
    }
    
    @IBAction func clickedCancelPolicy(_ sender: Any) {
        if textViewReason.text == ""
        {
            self.setUpMakeToast(msg: "Please enter reason")
        }
        else
        {
            if isSelectPerson == true
            {
                if self.isUpload == false
                {
                    self.setUpMakeToast(msg: "Please upload document")
                }
                else
                {
                    myImageUploadRequestCancelSelectPerson(imgKey: "cancellation_document")
                }
            }
            else
            {
                if showImage == 1
                {
                    callCacelSelectPersonAPI()
                }
                else
                {
                    if isUploadWay == false
                    {
                        if self.isUpload == false
                        {
                            self.setUpMakeToast(msg: "Please upload document")
                        }
                        else
                        {
                            myImageUploadRequest(imgKey: "cancellation_document")
                        }
                    }
                    else
                    {
                        if isUploadPDF == false
                        {
                            self.setUpMakeToast(msg: "Please upload document")
                        }
                        else
                        {
                            let img = UIImage()
                            myImageUploadRequest(imgKey: "cancellation_document")
                        }
                    }
                    
                }
            }
            
            
        }
    }
    
    @IBAction func ClickedUploadImage(_ sender: Any) {
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
            self.imgUpPDF.isHidden = true
            imgCancel.isHidden = false
            DispatchQueue.main.async {
                self.imageDataKey = image
                self.imgCancel.image = image
                self.viewAddU.isHidden = true
            }
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            let imageurl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            selectedImg = imageurl?.lastPathComponent
            self.isUpload = true
            self.viewAddU.isHidden = true
            imgCancel.isHidden = false
            DispatchQueue.main.async {
                self.imageDataKey = image
                self.imgCancel.image = image
                self.imgUpPDF.isHidden = true
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
                    
                    imgCancel.isHidden = true
                    imgUpPDF.isHidden = false
                    viewAddU.isHidden = true
                    
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
    // MARK: - calling API
    
    func callCacelSelectPersonAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["id":"\(self.insuranceId)","reason":self.textViewReason.text ?? ""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(CANCEL_POLACY, parameters: param) { response, error, statusCode in
            
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
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PolicyCancelledVC") as! PolicyCancelledVC
                        vc.strOpen = "1"
                        self.navigationController?.pushViewController(vc, animated: true)
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
    
    func callCacelPersonalAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["insurance_id":"\(self.strId)","reason":self.textViewReason.text ?? "","policy_no":self.strPolicyNo]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(cancelSingleInsurance, parameters: param) { response, error, statusCode in
            
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
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PolicyCancelledVC") as! PolicyCancelledVC
                        vc.strOpen = "1"
                        self.navigationController?.pushViewController(vc, animated: true)
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
    
    func myImageUploadRequestCancelSelectPerson(imgKey: String) {
        
        APIClient.sharedInstance.showIndicator()
        
        let authorisation = UserDefaults.standard.value(forKey: "token") as? String
        
        let myUrl = NSURL(string: BASE_URL + cancelSingleInsurance);
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        request.addValue("Bearer \(authorisation ?? "")", forHTTPHeaderField: "Authorization")
        
        let boundary = generateBoundaryString()
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let param = ["insurance_id":"\(self.insuranceId)","reason":self.textViewReason.text ?? "","policy_no":self.strPolicyNo]
        
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
                    let success = json["success"] as? Int
                    
                    if success == 1
                    {
                        if let message = json["message"] as? String
                        {
                            DispatchQueue.main.async {
                                
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PolicyCancelledVC") as! PolicyCancelledVC
                                vc.strOpen = "2"
                                self.navigationController?.pushViewController(vc, animated: true)
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
    
    
    func myImageUploadRequest(imgKey: String) {
        
        APIClient.sharedInstance.showIndicator()
        
        let authorisation = UserDefaults.standard.value(forKey: "token") as? String
        
        let myUrl = NSURL(string: BASE_URL + CANCEL_POLACY);
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        request.addValue("Bearer \(authorisation ?? "")", forHTTPHeaderField: "Authorization")
        
        let boundary = generateBoundaryString()
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let param = ["id":"\(self.strId)","reason":self.textViewReason.text ?? ""]
        
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
                    
                    if status == 200
                    {
                        if let message = json["message"] as? String
                        {
                            DispatchQueue.main.async {
                                
//                                self.setUpMakeToast(msg: "Your request is currently under review by our administration team. They will carefully evaluate your request and take the necessary actions accordingly")
                                
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PolicyCancelledVC") as! PolicyCancelledVC
                                vc.strOpen = "2"
                                self.navigationController?.pushViewController(vc, animated: true)
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
        
        if isUploadWay == true {
            let filename = "application.pdf"
            let mimetype = "application/pdf"
            
            let pdfData = UploadData
            
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\("cancellation_document")\"; filename=\"\(filename)\"\r\n")
            body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
            body.append(pdfData)
            body.appendString(string: "\r\n")
            body.appendString(string: "--\(boundary)--\r\n")
        } else {
            let filename = "\(imgKey).jpg"
            let mimetype = "image/jpeg"
            
            let imageData = self.imageDataKey.jpegData(compressionQuality: 0.3)!
            
            
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\("cancellation_document")\"; filename=\"\(filename)\"\r\n")
            body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
            body.append(imageData as Data)
            body.appendString(string: "\r\n")
            body.appendString(string: "--\(boundary)--\r\n")
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
