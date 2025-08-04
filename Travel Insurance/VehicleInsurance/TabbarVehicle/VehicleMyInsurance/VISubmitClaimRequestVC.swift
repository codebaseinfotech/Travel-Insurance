//
//  VISubmitClaimRequestVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 05/06/25.
//

import UIKit
import AVFoundation
import MobileCoreServices

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnClaimTypeAction(_ sender: Any) {
    }
    @IBAction func btnClaimDate(_ sender: UITextField) {
        datePickerDOB.datePickerMode = .date
        datePickerDOB.preferredDatePickerStyle = .wheels
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Adjust format to match your input
        dateFormatter.timeZone = TimeZone.current
        
        datePickerDOB.maximumDate = Date()
        
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
        let vc = VIPaymentSuccessVC.instantiate("Vehicle") as! VIPaymentSuccessVC
        vc.modalPresentationStyle = .overFullScreen
        vc.isCliamRequest = true
        self.present(vc, animated: true)
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
                    stackViewIncident.isHidden = true
                    imgIncident.image = image
                } else if strOpenUploadPic == "policy_report" {
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
                    stackViewIncident.isHidden = true
                    imgIncident.image = image
                } else if strOpenUploadPic == "policy_report" {
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
