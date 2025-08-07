//
//  VIProcess5VC.swift
//  Hamraa Insurance
//
//  Created by Poojagabani on 04/06/25.
//

import UIKit
import AVFoundation
import MobileCoreServices

struct UploadField {
    let key: String
    let image: UIImage
    let videoUrl: String
}

class VIProcess5VC: UIViewController {
    
    @IBOutlet weak var stackViewRCFrontUpload: UIStackView!
    @IBOutlet weak var imgPicRCFront: UIImageView!
    
    @IBOutlet weak var stackViewRCBackUpload: UIStackView!
    @IBOutlet weak var imgPicRCBack: UIImageView!
    
    @IBOutlet weak var stackViewIDFrontUpload: UIStackView!
    @IBOutlet weak var imgPicIDFront: UIImageView!
    
    @IBOutlet weak var stackViewIDBackUpload: UIStackView!
    @IBOutlet weak var imgPicIDBackUpload: UIImageView!
    
    @IBOutlet weak var stackViewDLFrontUpload: UIStackView!
    @IBOutlet weak var imgPicDLFront: UIImageView!
    
    @IBOutlet weak var stackViewDLBackUpload: UIStackView!
    @IBOutlet weak var imgPicDLBack: UIImageView!
    
    @IBOutlet weak var tblViewVehicleVideo: UITableView! {
        didSet {
            tblViewVehicleVideo.register(UINib(nibName: "VehicleUploadPhotoTblViewCell", bundle: nil), forCellReuseIdentifier: "VehicleUploadPhotoTblViewCell")
            tblViewVehicleVideo.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
            
            tblViewVehicleVideo.delegate = self
            tblViewVehicleVideo.dataSource = self
        }
    }
    @IBOutlet weak var heightTblViewVehicle: NSLayoutConstraint!
    
    @IBOutlet weak var stackVehiclePhotoVideoMain: UIStackView!
    @IBOutlet weak var imgVehiclePhotoVideo: UIImageView!
    
    var imagePickerNew = UIImagePickerController()
    
    var strOpenUploadPic = ""
    var arrAddAllPic: [UploadField] = []
    
    //MARK: - view Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Action Method
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnContinueAction(_ sender: Any) {
        let requiredKeys = [
            "registration[front]",
            "registration[back]",
            "id_proof[front]",
            "id_proof[back]",
            "driving_license[front]",
            "driving_license[back]",
            "vehicle[media]"
        ]
        let uploadedKeys = Set(arrAddAllPic.map { $0.key })
        let missingKeys = requiredKeys.filter { !uploadedKeys.contains($0) }
        if !missingKeys.isEmpty {
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please upload all required documents.")
            return
        } else {
            print("\(arrAddAllPic)")
            AppManger.shared.arrAddAllPic = arrAddAllPic
            let vc = VIProcess6VC.instantiate("Vehicle") as! VIProcess6VC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // RegistrationCard
    @IBAction func btnRCFrontAction(_ sender: Any) {
        strOpenUploadPic = "rc_front"
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
    @IBAction func btnRCBackAction(_ sender: Any) {
        strOpenUploadPic = "rc_back"
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
    
    // ID Proof
    @IBAction func btnIDProofFrontAction(_ sender: Any) {
        strOpenUploadPic = "id_front"
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
    @IBAction func btnIDProofBackActioin(_ sender: Any) {
        strOpenUploadPic = "id_back"
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
    
    // Driving License
    @IBAction func btnDLFrontAction(_ sender: Any) {
        strOpenUploadPic = "dl_front"
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
    @IBAction func btnDLBackAction(_ sender: Any) {
        strOpenUploadPic = "dl_back"
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
    @IBAction func clickedUploadVideoPhotoVehicl(_ sender: Any) {
        self.strOpenUploadPic = "vehicle_pic"
        let alert1 = UIAlertController(title: nil , message: nil, preferredStyle: .actionSheet)
        
        alert1.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert1.addAction(UIAlertAction(title: "Video", style: .default, handler: { _ in
            self.openVideoCamera()
        }))
        
        alert1.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert1, animated: true, completion: nil)
    }
   
    
    
}

// MARK: - tblViewDelegate & DataSource
extension VIProcess5VC: UITableViewDelegate, UITableViewDataSource {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey] {
                let newsize  = newvalue as! CGSize
                self.heightTblViewVehicle.constant = newsize.height
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblViewVehicleVideo.dequeueReusableCell(withIdentifier: "VehicleUploadPhotoTblViewCell") as! VehicleUploadPhotoTblViewCell
        
        cell.tapOnUploadPic = {
            self.strOpenUploadPic = "vehicle_pic"
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

// MARK: - uploadpic method
extension VIProcess5VC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
    
    func openVideoCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Camera not available")
            return
        }

        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.mediaTypes = ["public.movie"] // Only allow video recording
        picker.cameraCaptureMode = .video
        picker.videoQuality = .typeMedium // or .typeHigh
        picker.delegate = self
        picker.allowsEditing = false

        present(picker, animated: true, completion: nil)
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
        imagePickerNew.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
        self.present(imagePickerNew, animated: true, completion: nil)
    }
    
    func openGallaryVideo()
    {
        imagePickerNew.delegate = self
        imagePickerNew.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerNew.allowsEditing = true
        imagePickerNew.mediaTypes = [kUTTypeMovie as String]
        self.present(imagePickerNew, animated: true, completion: nil)
    }
    
    
    // Mark :- Edit Api
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            let imageurl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            DispatchQueue.main.async { [self] in
                if strOpenUploadPic == "rc_front" {
                    stackViewRCFrontUpload.isHidden = true
                    imgPicRCFront.image = image
                    self.arrAddAllPic.append(UploadField(key: "registration[front]", image: image, videoUrl: ""))
                } else if strOpenUploadPic == "rc_back" {
                    stackViewRCBackUpload.isHidden = true
                    imgPicRCBack.image = image
                    self.arrAddAllPic.append(UploadField(key: "registration[back]", image: image, videoUrl: ""))
                } else if strOpenUploadPic == "id_front" {
                    stackViewIDFrontUpload.isHidden = true
                    imgPicIDFront.image = image
                    self.arrAddAllPic.append(UploadField(key: "id_proof[front]", image: image, videoUrl: ""))
                } else if strOpenUploadPic == "id_back" {
                    stackViewIDBackUpload.isHidden = true
                    imgPicIDBackUpload.image = image
                    self.arrAddAllPic.append(UploadField(key: "id_proof[back]", image: image, videoUrl: ""))
                } else if strOpenUploadPic == "dl_front" {
                    stackViewDLFrontUpload.isHidden = true
                    imgPicDLFront.image = image
                    self.arrAddAllPic.append(UploadField(key: "driving_license[front]", image: image, videoUrl: ""))
                } else if strOpenUploadPic == "dl_back" {
                    stackViewDLBackUpload.isHidden = true
                    imgPicDLBack.image = image
                    self.arrAddAllPic.append(UploadField(key: "driving_license[back]", image: image, videoUrl: ""))
                } else if strOpenUploadPic == "vehicle_pic" {
                    stackVehiclePhotoVideoMain.isHidden = true
                    imgVehiclePhotoVideo.image = image
                    self.arrAddAllPic.append(UploadField(key: "vehicle[media]", image: image, videoUrl: ""))
                }
            }
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            let imageurl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            DispatchQueue.main.async { [self] in
                if strOpenUploadPic == "rc_front" {
                    stackViewRCFrontUpload.isHidden = true
                    imgPicRCFront.image = image
                    self.arrAddAllPic.append(UploadField(key: "registration[front]", image: image, videoUrl: ""))
                } else if strOpenUploadPic == "rc_back" {
                    stackViewRCBackUpload.isHidden = true
                    imgPicRCBack.image = image
                    self.arrAddAllPic.append(UploadField(key: "registration[back]", image: image, videoUrl: ""))
                } else if strOpenUploadPic == "id_front" {
                    stackViewIDFrontUpload.isHidden = true
                    imgPicIDFront.image = image
                    self.arrAddAllPic.append(UploadField(key: "id_proof[front]", image: image, videoUrl: ""))
                } else if strOpenUploadPic == "id_back" {
                    stackViewIDBackUpload.isHidden = true
                    imgPicIDBackUpload.image = image
                    self.arrAddAllPic.append(UploadField(key: "id_proof[back]", image: image, videoUrl: ""))
                } else if strOpenUploadPic == "dl_front" {
                    stackViewDLFrontUpload.isHidden = true
                    imgPicDLFront.image = image
                    self.arrAddAllPic.append(UploadField(key: "driving_license[front]", image: image, videoUrl: ""))
                } else if strOpenUploadPic == "dl_back" {
                    stackViewDLBackUpload.isHidden = true
                    imgPicDLBack.image = image
                    self.arrAddAllPic.append(UploadField(key: "driving_license[back]", image: image, videoUrl: ""))
                } else if strOpenUploadPic == "vehicle_pic" {
                    stackVehiclePhotoVideoMain.isHidden = true
                    imgVehiclePhotoVideo.image = image
                    self.arrAddAllPic.append(UploadField(key: "vehicle[media]", image: image, videoUrl: ""))
                }
            }
        }
        else if let videoUrl = info[.mediaURL] as? URL {
            if let image = generateThumbnail(url: videoUrl) {
                DispatchQueue.main.async { [self] in
                    stackVehiclePhotoVideoMain.isHidden = true
                    imgVehiclePhotoVideo.image = image
                    self.arrAddAllPic.append(UploadField(key: "vehicle[media]", image: image, videoUrl: "\(videoUrl)"))
                }
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
