//
//  VINewEndorsementVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 06/06/25.
//

import UIKit
import DropDown
import AVFoundation
import MobileCoreServices

class VINewEndorsementVC: UIViewController {

    @IBOutlet weak var viewTypeMain: UIView!
    @IBOutlet weak var txtEndorsementType: UITextField!
    
    // change of ownership
    @IBOutlet weak var stackViewChangeOwenershipMain: UIStackView!
    
    @IBOutlet weak var txtNOFullName: UITextField!
    @IBOutlet weak var txtNOEmail: UITextField!
    @IBOutlet weak var txtNOPhoneNumber: UITextField!
    @IBOutlet weak var txtNOAddress: UITextView!
    @IBOutlet weak var txtNODetailsEndrostment: UITextView!
    
    @IBOutlet weak var lblNOCountryCode: UILabel!
    @IBOutlet weak var imgNOCountryFlag: UIImageView!
    
    @IBOutlet weak var imgNOUploadProof: UIImageView!
    @IBOutlet weak var stackNOUploadProof: UIStackView!
    
    // other Type
    @IBOutlet weak var stackViewOtherMain: UIStackView!
    
    @IBOutlet weak var txtOSpecifyType: UITextField!
    @IBOutlet weak var txtODescription: UITextView!
    
    @IBOutlet weak var imgOUploadDocument: UIImageView!
    @IBOutlet weak var stackViewOUploadDocument: UIStackView!
    
    // New Vehicle Registration
    @IBOutlet weak var stackViewNewVehicleRegistration: UIStackView!
    
    @IBOutlet weak var txtNVRNumber: UITextField!
    
    @IBOutlet weak var imgNVRUploadRC: UIImageView!
    @IBOutlet weak var stackViewNVRUploadRC: UIStackView!
    
    // Address Update
    @IBOutlet weak var stackViewAddressUpdate: UIStackView!
    
    @IBOutlet weak var txtAUNewAddress: UITextView!
    
    @IBOutlet weak var imgAUUploadAddressProof: UIImageView!
    @IBOutlet weak var stackViewAUUploadAddressProof: UIStackView!
    
    // Name Correction
    @IBOutlet weak var stackViewNameCorrectionMain: UIStackView!
    
    @IBOutlet weak var txtNCCorrectedFullName: UITextField!
    
    @IBOutlet weak var imgNCUploadValidProof: UIImageView!
    @IBOutlet weak var stackViewNCUploadValidProof: UIStackView!
    
    // Engine/Chassis Number Correction
    @IBOutlet weak var stackViewEngineCorrectionMain: UIStackView!
    
    @IBOutlet weak var txtECEngineNumber: UITextField!
    @IBOutlet weak var txtECChassisNumber: UITextField!
    
    @IBOutlet weak var imgECUploadRC: UIImageView!
    @IBOutlet weak var stackViewECUploadRC: UIStackView!
    
    // Add/Remove Accessories
    @IBOutlet weak var stackViewAddAccessoriesMain: UIStackView!
    
    @IBOutlet weak var txtAAccessories: UITextView!
    
    @IBOutlet weak var imgAAUploadInvoice: UIImageView!
    @IBOutlet weak var stackViewAAUploadInvoice: UIStackView!
    
    // MARK: - variable
    
    var dropDownType = DropDown()
    var imagePickerNew = UIImagePickerController()
    
    var selectedIndex = 0
    
    // MARK: - view Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setDropDownType()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - setUp DropDownType
    func setDropDownType()
    {
        dropDownType.dataSource = ["New Vehicle Registration", "Change of Ownership", "Address Update", "Name Correction", "Engine/Chassis Number Correction", "Add/Remove Accessories", "Others"]
        dropDownType.anchorView = viewTypeMain
        dropDownType.direction = .bottom
        
        dropDownType.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.txtEndorsementType.text = item
            
            if item == "New Vehicle Registration" {
                stackViewNewVehicleRegistration.isHidden = false
                stackViewChangeOwenershipMain.isHidden = true
                stackViewAddressUpdate.isHidden = true
                stackViewNameCorrectionMain.isHidden = true
                stackViewEngineCorrectionMain.isHidden = true
                stackViewAddAccessoriesMain.isHidden = true
                stackViewOtherMain.isHidden = true
                
            } else if item == "Change of Ownership" {
                stackViewChangeOwenershipMain.isHidden = false
                stackViewNewVehicleRegistration.isHidden = true
                stackViewAddressUpdate.isHidden = true
                stackViewNameCorrectionMain.isHidden = true
                stackViewEngineCorrectionMain.isHidden = true
                stackViewAddAccessoriesMain.isHidden = true
                stackViewOtherMain.isHidden = true
                
            } else if item == "Address Update" {
                stackViewAddressUpdate.isHidden = false
                stackViewChangeOwenershipMain.isHidden = true
                stackViewNewVehicleRegistration.isHidden = true
                stackViewNameCorrectionMain.isHidden = true
                stackViewEngineCorrectionMain.isHidden = true
                stackViewAddAccessoriesMain.isHidden = true
                stackViewOtherMain.isHidden = true
                
            } else if item == "Name Correction" {
                stackViewNameCorrectionMain.isHidden = false
                stackViewChangeOwenershipMain.isHidden = true
                stackViewAddressUpdate.isHidden = true
                stackViewNewVehicleRegistration.isHidden = true
                stackViewEngineCorrectionMain.isHidden = true
                stackViewAddAccessoriesMain.isHidden = true
                stackViewOtherMain.isHidden = true
                
            } else if item == "Engine/Chassis Number Correction" {
                stackViewEngineCorrectionMain.isHidden = false
                stackViewChangeOwenershipMain.isHidden = true
                stackViewAddressUpdate.isHidden = true
                stackViewNameCorrectionMain.isHidden = true
                stackViewNewVehicleRegistration.isHidden = true
                stackViewAddAccessoriesMain.isHidden = true
                stackViewOtherMain.isHidden = true
                
            } else if item == "Add/Remove Accessories" {
                stackViewAddAccessoriesMain.isHidden = false
                stackViewChangeOwenershipMain.isHidden = true
                stackViewAddressUpdate.isHidden = true
                stackViewNameCorrectionMain.isHidden = true
                stackViewEngineCorrectionMain.isHidden = true
                stackViewNewVehicleRegistration.isHidden = true
                stackViewOtherMain.isHidden = true
                
            } else if item == "Others" {
                stackViewOtherMain.isHidden = false
                stackViewChangeOwenershipMain.isHidden = true
                stackViewAddressUpdate.isHidden = true
                stackViewNameCorrectionMain.isHidden = true
                stackViewEngineCorrectionMain.isHidden = true
                stackViewAddAccessoriesMain.isHidden = true
                stackViewNewVehicleRegistration.isHidden = true
                
            }
        }
        
        dropDownType.bottomOffset = CGPoint(x: 0, y: viewTypeMain.bounds.height)
        dropDownType.topOffset = CGPoint(x: 0, y: -viewTypeMain.bounds.height)
        dropDownType.dismissMode = .onTap
        dropDownType.textColor = .black
        dropDownType.backgroundColor = UIColor.white
        dropDownType.selectionBackgroundColor = UIColor.clear
        dropDownType.reloadAllComponents()
    }
    
    // MARK: - Action Method
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnEndrosmentAction(_ sender: Any) {
        dropDownType.show()
    }
    @IBAction func btnUploadDocument(_ sender: UIButton) {
        selectedIndex = sender.tag
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
    @IBAction func btnSubmitRquestAction(_ sender: Any) {
        let vc = VIEndrostmentSuccessVC.instantiate("Vehicle") as! VIEndrostmentSuccessVC
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
    
    

}

// MARK: - uploadpic method
extension VINewEndorsementVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
                if selectedIndex == 1 {
                    imgNVRUploadRC.image = image
                    stackViewNVRUploadRC.isHidden = true
                } else if selectedIndex == 2 {
                    imgNOUploadProof.image = image
                    stackNOUploadProof.isHidden = true
                } else if selectedIndex == 3 {
                    imgAUUploadAddressProof.image = image
                    stackViewAUUploadAddressProof.isHidden = true
                } else if selectedIndex == 4 {
                    imgNCUploadValidProof.image = image
                    stackViewNCUploadValidProof.isHidden = true
                } else if selectedIndex == 5 {
                    imgECUploadRC.image = image
                    stackViewECUploadRC.isHidden = true
                } else if selectedIndex == 6 {
                    imgAAUploadInvoice.image = image
                    stackViewAAUploadInvoice.isHidden = true
                } else if selectedIndex == 7 {
                    imgOUploadDocument.image = image
                    stackViewOUploadDocument.isHidden = true
                }
            }
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            let imageurl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            DispatchQueue.main.async { [self] in
                if selectedIndex == 1 {
                    imgNVRUploadRC.image = image
                    stackViewNVRUploadRC.isHidden = true
                } else if selectedIndex == 2 {
                    imgNOUploadProof.image = image
                    stackNOUploadProof.isHidden = true
                } else if selectedIndex == 3 {
                    imgAUUploadAddressProof.image = image
                    stackViewAUUploadAddressProof.isHidden = true
                } else if selectedIndex == 4 {
                    imgNCUploadValidProof.image = image
                    stackViewNCUploadValidProof.isHidden = true
                } else if selectedIndex == 5 {
                    imgECUploadRC.image = image
                    stackViewECUploadRC.isHidden = true
                } else if selectedIndex == 6 {
                    imgAAUploadInvoice.image = image
                    stackViewAAUploadInvoice.isHidden = true
                } else if selectedIndex == 7 {
                    imgOUploadDocument.image = image
                    stackViewOUploadDocument.isHidden = true
                }
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
