//
//  VICancelPolicyVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 05/06/25.
//

import UIKit
import AVFoundation
import MobileCoreServices

class VICancelPolicyVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var viewOtherMessage: UIView!
    @IBOutlet weak var txtOtherMessage: UITextView!
    
    @IBOutlet weak var imgVehilcleSold: UIImageView!
    @IBOutlet weak var imgChangeProvider: UIImageView!
    @IBOutlet weak var imgDuplicatePolicy: UIImageView!
    @IBOutlet weak var imgNoLongerNeed: UIImageView!
    @IBOutlet weak var imgOther: UIImageView!
    
    @IBOutlet weak var imgUploadDocument: UIImageView!
    @IBOutlet weak var stackViewUploadDocument: UIStackView!
    
    var cancel_reason = ""
    var isUploadImg = false
    
    var imagePicker: ImagePicker!
    var selectedImg: String?
    
    var imagePickerNew = UIImagePickerController()
    
    var vehicle_insurance_id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnVehicleSoldAction(_ sender: Any) {
        cancel_reason = "Vehicle Sold"
        imgVehilcleSold.image = UIImage(named: "ic_selectCard")
        imgChangeProvider.image = UIImage(named: "ic_unSelectCard")
        imgDuplicatePolicy.image = UIImage(named: "ic_unSelectCard")
        imgNoLongerNeed.image = UIImage(named: "ic_unSelectCard")
        imgOther.image = UIImage(named: "ic_unSelectCard")
        
        viewOtherMessage.isHidden = true
    }
    @IBAction func btnChangeProviderAction(_ sender: Any) {
        cancel_reason = "Change in Insurance Provider"
        imgChangeProvider.image = UIImage(named: "ic_selectCard")
        imgVehilcleSold.image = UIImage(named: "ic_unSelectCard")
        imgDuplicatePolicy.image = UIImage(named: "ic_unSelectCard")
        imgNoLongerNeed.image = UIImage(named: "ic_unSelectCard")
        imgOther.image = UIImage(named: "ic_unSelectCard")
        
        viewOtherMessage.isHidden = true
    }
    @IBAction func btnDuplicatePolicy(_ sender: Any) {
        cancel_reason = "Duplicate Policy"
        imgDuplicatePolicy.image = UIImage(named: "ic_selectCard")
        imgChangeProvider.image = UIImage(named: "ic_unSelectCard")
        imgVehilcleSold.image = UIImage(named: "ic_unSelectCard")
        imgNoLongerNeed.image = UIImage(named: "ic_unSelectCard")
        imgOther.image = UIImage(named: "ic_unSelectCard")
        
        viewOtherMessage.isHidden = true
    }
    @IBAction func btnNoLongerNeedAction(_ sender: Any) {
        cancel_reason = "No Longer Needed"
        imgNoLongerNeed.image = UIImage(named: "ic_selectCard")
        imgChangeProvider.image = UIImage(named: "ic_unSelectCard")
        imgDuplicatePolicy.image = UIImage(named: "ic_unSelectCard")
        imgVehilcleSold.image = UIImage(named: "ic_unSelectCard")
        imgOther.image = UIImage(named: "ic_unSelectCard")
        
        viewOtherMessage.isHidden = true
    }
    @IBAction func btnOtherAction(_ sender: Any) {
        cancel_reason = "Other"
        imgOther.image = UIImage(named: "ic_selectCard")
        imgChangeProvider.image = UIImage(named: "ic_unSelectCard")
        imgDuplicatePolicy.image = UIImage(named: "ic_unSelectCard")
        imgNoLongerNeed.image = UIImage(named: "ic_unSelectCard")
        imgVehilcleSold.image = UIImage(named: "ic_unSelectCard")
        
        viewOtherMessage.isHidden = false
    }
    @IBAction func btnUploadDocumentAction(_ sender: Any) {
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
    
    @IBAction func btnCancelPolicyAction(_ sender: Any) {
        if isVlaidField() {
            if isUploadImg == true {
                myImageUploadRequest(imgKey: "cancel_document")
            } else {
                callCancelPolicyAPI()
            }
        }
    }
    
    
    // MARK: - isValid
    func isVlaidField() -> Bool {
        
        guard !cancel_reason.isEmpty else {
            self.setUpMakeToast(msg: "Please select reason cancellation")
            return false
        }

        if cancel_reason == "Other" {
            guard let msg = txtOtherMessage.text, !msg.trimmingCharacters(in: .whitespaces).isEmpty else {
                self.setUpMakeToast(msg: "Please enter reason")
                return false
            }
        }
        
        return true
    }
    // MARK: - isAPICall
    
    func callCancelPolicyAPI() {
        APIClient.sharedInstance.showIndicator()
        
        var cancel_reason = ""
        
        if self.cancel_reason == "Other" {
            cancel_reason = self.txtOtherMessage.text ?? ""
        } else {
            cancel_reason = self.cancel_reason
        }
        
        let param = [
            "cancel_reason": cancel_reason,
            "vehicle_insurance_id": "\(vehicle_insurance_id)"
        ]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(CANCEL_VEHICLE_POLICY, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                let NotificationCOunt = response?.value(forKey: "NotificationCOunt") as? Int

                if statusCode == 200
                {
                    if status == 1 {
                        DispatchQueue.main.async {
                            let vc = VIPolicyCancelSuccessVC.instantiate("Vehicle") as! VIPolicyCancelSuccessVC
                            vc.modalPresentationStyle = .overFullScreen
                            self.present(vc, animated: true)
                        }
                    } else {
                        DispatchQueue.main.async {
                            APIClient.sharedInstance.hideIndicator()
                            self.setUpMakeToast(msg: message ?? "")
                        }
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
    
    func myImageUploadRequest(imgKey: String) {
        
        APIClient.sharedInstance.showIndicator()
        
        let authorisation = UserDefaults.standard.value(forKey: "token") as? String
        
        let myUrl = NSURL(string: BASE_URL + CANCEL_VEHICLE_POLICY);
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        request.addValue("Bearer \(authorisation ?? "")", forHTTPHeaderField: "Authorization")
        
        let boundary = String.generateBoundaryString()
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var cancel_reason = ""
        
        if self.cancel_reason == "Other" {
            cancel_reason = self.txtOtherMessage.text ?? ""
        } else {
            cancel_reason = self.cancel_reason
        }
        
        let param = [
            "cancel_reason": cancel_reason,
            "vehicle_insurance_id": "\(vehicle_insurance_id)"
        ]
        
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
                    if let status = json["status"] as? Int, status == 1 {
                        DispatchQueue.main.async {
                            let vc = VIPolicyCancelSuccessVC.instantiate("Vehicle") as! VIPolicyCancelSuccessVC
                            vc.modalPresentationStyle = .overFullScreen
                            self.present(vc, animated: true)
                        }
                    } else {
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
        
        let filename = "\(imgKey).jpg"
        let mimetype = "image/jpeg"
        
        let data = imgOther.image?.jpegData(compressionQuality: 0.3)
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\("cancel_document")\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(data!)
        body.appendString(string: "\r\n")
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    
    // MARK: - openCamera
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
            self.isUploadImg = true
            DispatchQueue.main.async {
                self.stackViewUploadDocument.isHidden = true
                self.imgUploadDocument.image = image
            }
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            let imageurl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            selectedImg = imageurl?.lastPathComponent
            self.isUploadImg = true
            DispatchQueue.main.async {
                self.stackViewUploadDocument.isHidden = true
                self.imgUploadDocument.image = image
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }

}
