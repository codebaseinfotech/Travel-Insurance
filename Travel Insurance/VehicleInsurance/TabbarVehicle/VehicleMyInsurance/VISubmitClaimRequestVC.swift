//
//  VISubmitClaimRequestVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 05/06/25.
//

import UIKit
import AVFoundation
import MobileCoreServices
import DropDown

class VISubmitClaimRequestVC: UIViewController {

    @IBOutlet weak var txtSelectClaim: UITextField!
    @IBOutlet weak var txtClaimDaye: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    
    @IBOutlet weak var imgIncident: UIImageView!
    @IBOutlet weak var stackViewIncident: UIStackView!
    
    @IBOutlet weak var imgPolicyReport: UIImageView!
    @IBOutlet weak var stackViewPolicyReport: UIStackView!
    
    var datePickerDOB = UIDatePicker()
    var imagePickerNew = UIImagePickerController()
    
    var strOpenUploadPic = ""
    
    var dropDownClaimType = DropDown()
    
    var isInncident = false
    var isPolicyReport = false
    
    var dicInsuranceDetails = TIVehicleInsuranceDetialsData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDropDownType()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - setUp DropDownType
    func setDropDownType()
    {
        dropDownClaimType.dataSource = ["Accident", "Theft", "Natural", "Disaster"]
        dropDownClaimType.anchorView = txtSelectClaim
        dropDownClaimType.direction = .bottom
        
        dropDownClaimType.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.txtSelectClaim.text = item
        }
        dropDownClaimType.bottomOffset = CGPoint(x: 0, y: txtSelectClaim.bounds.height)
        dropDownClaimType.topOffset = CGPoint(x: 0, y: -txtSelectClaim.bounds.height)
        dropDownClaimType.dismissMode = .onTap
        dropDownClaimType.textColor = .black
        dropDownClaimType.backgroundColor = UIColor.white
        dropDownClaimType.selectionBackgroundColor = UIColor.clear
        dropDownClaimType.reloadAllComponents()
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnClaimTypeAction(_ sender: Any) {
        dropDownClaimType.show()
    }
    @IBAction func btnClaimDate(_ sender: UITextField) {
        datePickerDOB.datePickerMode = .date
        datePickerDOB.preferredDatePickerStyle = .wheels
        
        datePickerDOB.minimumDate = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Adjust format to match your input
        dateFormatter.timeZone = TimeZone.current
        
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
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        txtClaimDaye.text = formatter.string(from: datePickerDOB.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }
    
    @IBAction func btnUploadIncident(_ sender: Any) {
        strOpenUploadPic = "incident"
        let alert1 = UIAlertController(title: nil , message: nil, preferredStyle: .actionSheet)
        
        alert1.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert1.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert1.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert1, animated: true, completion: nil)
    }
    @IBAction func btnUploadPolicyReportAction(_ sender: Any) {
        strOpenUploadPic = "policy_report"
        let alert1 = UIAlertController(title: nil , message: nil, preferredStyle: .actionSheet)
        
        alert1.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert1.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert1.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert1, animated: true, completion: nil)
    }
    @IBAction func btnSubmitClaimAction(_ sender: Any) {
        
        if isValidField() {
            myImageUploadRequest(imgKey: "")
        }
        
        
    }
    
    // MARK: - isValidAllField
    func isValidField() -> Bool {
        guard let type = txtSelectClaim.text, !type.isEmpty else {
            self.setUpMakeToast(msg: "Please select claim type")
            return false
        }
        
        guard let date = txtClaimDaye.text, !date.isEmpty else {
            self.setUpMakeToast(msg: "Please select claim date")
            return false
        }
        
        guard let des = txtDescription.text, !des.isEmpty else {
            self.setUpMakeToast(msg: "Please enter claim description")
            return false
        }
        
        guard isInncident else {
            self.setUpMakeToast(msg: "Please upload incident photo")
            return false
        }
        
        guard isPolicyReport else {
            self.setUpMakeToast(msg: "Please upload policy report photo")
            return false
        }
        
        return true
    }
    
    // MARK: - calling API -
    func myImageUploadRequest(imgKey: String) {
        
        APIClient.sharedInstance.showIndicator()
        
        let token = UserDefaults.standard.value(forKey: "token") as? String
        
        let myUrl = NSURL(string: BASE_URL + CLAIM_VEHICLE_INSURANCE);
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
      
        let vehicle_insurance_id = "\(dicInsuranceDetails.id ?? 0)"
        let claim_type = txtSelectClaim.text ?? ""
        let claim_date = txtClaimDaye.text?.toDisplayDate() ?? ""
        let claim_description = txtDescription.text ?? ""
        
        let params = ["vehicle_insurance_id":vehicle_insurance_id,
                      "claim_type": claim_type,
                      "claim_date": claim_date,
                      "claim_description": claim_description]
      
        print(params)
        
        let boundary = String.generateBoundaryString()
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = createBodyWithParameters(parameters: params, filePathKey: imgKey, boundary: boundary, imgKey: imgKey) as Data
        
        
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
                    
                    // try to read out a string array
                    if let status = json["status"] as? Int
                    {
                        if status == 1
                        {
                            let data = json["data"] as? NSDictionary
                            let claim_id = data?.value(forKey: "claim_id") as? String ?? ""

                            let message = json["message"] as? String ?? ""
                            print(message)
                            DispatchQueue.main.async {
                                let vc = VIPaymentSuccessVC.instantiate("Vehicle") as! VIPaymentSuccessVC
                                vc.modalPresentationStyle = .overFullScreen
                                vc.isCliamRequest = true
                                vc.claim_id = claim_id
                                vc.delegateAction = self
                                self.present(vc, animated: true)
                                
                                
                            }
                        }
                        else
                        {
                            let message = json["message"] as? String ?? ""
                            print(message)
                            DispatchQueue.main.async {
                                self.view.makeToast(message)
                                let window = UIApplication.shared.windows
                                window.last?.makeToast(message)
                            }
                            
                        }
                    }
                }
                
            }catch{
                
            }
            
        }
        
        task.resume()
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, boundary: String, imgKey: String) -> NSData {
        
        let body = NSMutableData()
        
        // Append parameters
        if let params = parameters {
            for (key, value) in params {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        // Image 1
        if let imageData1 = imgIncident.image?.jpegData(compressionQuality: 0.7) {
            let filename1 = "image1.jpg"
            let mimetype1 = "image/jpeg"
            
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"claim_images[0]\"; filename=\"\(filename1)\"\r\n")
            body.appendString(string: "Content-Type: \(mimetype1)\r\n\r\n")
            body.append(imageData1)
            body.appendString(string: "\r\n")
        }
        
        // Image 2
        if let imageData2 = imgPolicyReport.image?.jpegData(compressionQuality: 0.7) {
            let filename2 = "image2.jpg"
            let mimetype2 = "image/jpeg"
            
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"police_report_document\"; filename=\"\(filename2)\"\r\n")
            body.appendString(string: "Content-Type: \(mimetype2)\r\n\r\n")
            body.append(imageData2)
            body.appendString(string: "\r\n")
        }
        
        // End boundary
        body.appendString(string: "--\(boundary)--\r\n")
        
        
        return body
    }
    

}

extension VISubmitClaimRequestVC: didTapOnSuccess {
    func didTapOnTrackClaim() {
        
    }
    
    func didTapOnClose() {
        let vc = VehicleMyInsuranceVC.instantiate("Vehicle") as! VehicleMyInsuranceVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
}

// MARK: - uploadpic method
extension VISubmitClaimRequestVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
    
    // Mark :- Edit Api
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            let imageurl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            DispatchQueue.main.async { [self] in
                if strOpenUploadPic == "incident" {
                    isInncident = true
                    stackViewIncident.isHidden = true
                    imgIncident.image = image
                } else if strOpenUploadPic == "policy_report" {
                    isPolicyReport = true
                    stackViewPolicyReport.isHidden = true
                    imgPolicyReport.image = image
                }
            }
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            let imageurl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            DispatchQueue.main.async { [self] in
                if strOpenUploadPic == "incident" {
                    isInncident = true
                    stackViewIncident.isHidden = true
                    imgIncident.image = image
                } else if strOpenUploadPic == "policy_report" {
                    isPolicyReport = true
                    stackViewPolicyReport.isHidden = true
                    imgPolicyReport.image = image
                }
            }
        }
        else if let videoUrl = info[.mediaURL] as? URL {
            if let thumbenil = generateThumbnail(url: videoUrl) {
                
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func generateThumbnail(url: URL) -> UIImage? {
        let asset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        let time = CMTime(seconds: 1.0, preferredTimescale: 600)
        
        do {
            let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: cgImage)
        } catch {
            print("Error generating thumbnail: \(error)")
            return nil
        }
    }
}
