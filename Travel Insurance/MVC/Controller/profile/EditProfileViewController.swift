//
//  EditProfileViewController.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 02/11/23.
//

import UIKit
import MobileCoreServices
import ADCountryPicker
import UIKit
import AVFoundation

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var txtCode: UITextField!
    
    @IBOutlet weak var lblFlag: UILabel!
    
    @IBOutlet weak var txtEnterName: UITextField!
    @IBOutlet weak var txtEnterEmail: UITextField!
    @IBOutlet weak var txtEnterMoblie: UITextField!
    @IBOutlet weak var txtEnterDateOfBirth: UITextField!
    @IBOutlet weak var imgProfile: UIImageView!
    
    var imagePickerNew = UIImagePickerController()
    
    var selectedImg: String?
    var imagePicker: ImagePicker!
    let picker = ADCountryPicker()
    
    let datePikerSDate = UIDatePicker()
    
    var strDOB = ""
    
    var isImgUpload = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtEnterEmail.isUserInteractionEnabled = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.txtEnterName.text = appDelegate?.dicCurrentUserData.name ?? ""
        self.txtEnterEmail.text = appDelegate?.dicCurrentUserData.email ?? ""
        self.txtEnterDateOfBirth.text = appDelegate?.dicCurrentUserData.dateOfBirth ?? ""
        self.strDOB = appDelegate?.dicCurrentUserData.dateOfBirth ?? ""
        
        if let arrSpit = appDelegate?.dicCurrentUserData.mobileNumber.components(separatedBy: " ")
        {
            if arrSpit.count > 0
            {
                if arrSpit.count == 1
                {
                    self.txtEnterMoblie.text = arrSpit[0] as? String
                }
                else if arrSpit.count == 2
                {
                    self.txtCode.text = arrSpit[0] as? String
 
                    self.txtEnterMoblie.text = arrSpit[1] as? String
                }
            }
        }
        
        var media_link_url = appDelegate?.dicCurrentUserData.imagePath ?? ""
        media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        imgProfile.sd_setImage(with: URL.init(string: media_link_url), placeholderImage: UIImage(named: "app_logo"), options: [], completed: nil)
        
    }
 
    
    @IBAction func clicked(_ sender: UITextField) {
        
        datePikerSDate.datePickerMode = .date
        datePikerSDate.maximumDate = Date()
        datePikerSDate.preferredDatePickerStyle = .wheels
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(donedatePickerSDate));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePickerSdate));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        sender.inputAccessoryView = toolbar
        sender.inputView = datePikerSDate
        
    }
    
    @objc func donedatePickerSDate(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        txtEnterDateOfBirth.text = formatter.string(from: datePikerSDate.date)
        
        let formatterAPI = DateFormatter()
        formatterAPI.dateFormat = "yyyy-MM-dd"
        self.strDOB = formatterAPI.string(from: datePikerSDate.date)
        self.view.endEditing(true)
        
    }
    
    @objc func cancelDatePickerSdate(){
        self.view.endEditing(true)
    }
    
    @IBAction func clickedCode(_ sender: Any) {
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
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func ClikedProfileEdit(_ sender: Any) {
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
    @IBAction func clickedSaveChanges(_ sender: Any) {
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        if txtEnterName.text == ""
        {
            self.view.makeToast("Please enter name")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please enter name")
        }
        else if txtEnterEmail.text == ""
        {
            self.view.makeToast("Please enter Email")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please enter Email")
        }
        else if txtEnterMoblie.text == ""
        {
            self.view.makeToast("Please enter mobile number")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please enter mobile number")
        }
        else if (txtEnterMoblie.text?.count ?? 0) < 8
        {
            self.setUpMakeToast(msg: "Please enter minimum 8 digit mobile number")
        }
        else if txtEnterDateOfBirth.text == ""
        {
            self.view.makeToast("Please enter DOB")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please enter DOB")
        }
        else
        {
            if self.isImgUpload == true
            {
                self.myImageUploadRequest(imageToUpload: imgProfile.image!, imgKey: "image_path")
            }
            else
            {
                self.callProfileAPI()
            }
           
        }
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
    
    // Mark :- Edit Api
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            let imageurl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            selectedImg = imageurl?.lastPathComponent
            //self.isUploadImg = true
            
            self.isImgUpload = true
            
            DispatchQueue.main.async {
                self.imgProfile.image = image
            }
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            let imageurl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            selectedImg = imageurl?.lastPathComponent
            //self.isUploadImg = true
            
            self.isImgUpload = true
            
            DispatchQueue.main.async {
                self.imgProfile.image = image
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func myImageUploadRequest(imageToUpload: UIImage, imgKey: String) {
        
        APIClient.sharedInstance.showIndicator()
 
        let token = UserDefaults.standard.value(forKey: "token") as? String
        
        let myUrl = NSURL(string: BASE_URL + PROFILE_UPDATE);
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        
        let name = self.txtEnterName.text ?? ""

        let email = self.txtEnterEmail.text ?? ""
        
        let mobile_number = "\(self.txtEnterMoblie.text ?? "")"
                
        var params = ["name":name,"mobile_number":mobile_number,"email":email,"date_of_birth":self.strDOB]
      
        print(params)
        
        let boundary = generateBoundaryString()
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = imageToUpload.jpegData(compressionQuality: 0.3)
        if imageData == nil  {
            return
        }
        
        request.httpBody = createBodyWithParameters(parameters: params, filePathKey: imgKey, imageDataKey: imageData! as NSData, boundary: boundary, imgKey: imgKey) as Data
        
        
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
                    if var status = json["status"] as? Int
                    {
                        if status == 201
                        {
                            let message = json["message"] as? String
                            
                            DispatchQueue.main.async {
                                
                                self.view.makeToast(message)
                                let window = UIApplication.shared.windows
                                window.last?.makeToast(message)
                                
                                if let dicResponse = json["response"] as? NSDictionary
                                {
                                    let dicData = TIUserLoginResponse(fromDictionary: dicResponse)
                                    
                                    appDelegate?.saveCurrentUserData(dic: dicData)
                                    appDelegate?.dicCurrentUserData = dicData
                                }
                                
                                self.clickedBack(self)
                                
                            }
                        }
                        else
                        {
                            let message = json["message"] as? String
                            
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
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String, imgKey: String) -> NSData {
        
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let filenameImageBOL = "image.jpg"
        let mimetypeImageBOL = "image/jpg"
        
        let imageData =  imgProfile.image?.jpegData(compressionQuality: 0.3)
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"image_path\"; filename=\"\(filenameImageBOL)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetypeImageBOL)\r\n\r\n")
        body.append(imageData! as Data)
        body.appendString(string: "\r\n")
        body.appendString(string: "--\(boundary)--\r\n")
         
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
    
    //MARK: - API Calling
    
    func callProfileAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["name":self.txtEnterName.text ?? "","mobile_number": "\(self.txtEnterMoblie.text ?? "")", "date_of_birth": self.txtEnterDateOfBirth.text ?? ""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(PROFILE_UPDATE, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200
                {
                    if status == 201
                    {
                        if let dicResponse = response?.value(forKey: "response") as? NSDictionary
                        {
                            let dicData = TIUserLoginResponse(fromDictionary: dicResponse)
                            
                            appDelegate?.saveCurrentUserData(dic: dicData)
                            appDelegate?.dicCurrentUserData = dicData
                        }
                        
                        self.clickedBack(self)
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
                    
                    self.setUpMakeToast(msg: message ?? "")
                }
            }
            else
            {
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
}

extension EditProfileViewController: ADCountryPickerDelegate {
    
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String)
    {
        _ = picker.navigationController?.popToRootViewController(animated: true)
        
        self.txtCode.text = dialCode
        
        let flagImage =  picker.getFlag(countryCode: code)
        self.lblFlag.text = countryFlag(code)
        
        self.dismiss(animated: true, completion: nil)
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
    
}
