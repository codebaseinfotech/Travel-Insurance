//
//  ProfileViewController.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 01/11/23.
//

import UIKit
import libPhoneNumber_iOS

class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblnumber: UILabel!
    @IBOutlet weak var tblProfile: UITableView!
    
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var viewBMain: UIView!
    
    @IBOutlet weak var viewWhatapp: UIView!
    @IBOutlet weak var viewMail: UIView!
    
    var arrImgCustomer = ["ic_profile","ic_help","ic_notification","ic_term","ic_lock","ic_lock"]
    var arrNameCustomer = ["My Profile","Contact us","Notifications","Terms & Conditions","Privacy Policy","Compensation Info"]
    
    var arrImgAgent = ["ic_profile","MyRepot","ic_help","ic_notification","ic_term","ic_lock","ic_lock"]
    var arrNameAgent = ["My Profile","My Entitlement Report","Contact us","Notifications","Terms & Conditions","Privacy Policy","Compensation Info"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // appDelegate?.dicCurrentUserData.roleId == 1
        
        viewWhatapp.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 18, spread: 0)

        viewMail.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 18, spread: 0)
        
        tblProfile.dataSource = self
        tblProfile.delegate = self
        
        self.lblName.text = appDelegate?.dicCurrentUserData.name ?? ""
        self.lblEmail.text = appDelegate?.dicCurrentUserData.email ?? ""
        self.lblnumber.text = "\(appDelegate?.dicCurrentUserData.countryCode ?? "") \(appDelegate?.dicCurrentUserData.mobileNumber ?? "")"
        
        var media_link_url = appDelegate?.dicCurrentUserData.imagePath ?? ""
        media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        imgProfile.sd_setImage(with: URL.init(string: media_link_url), placeholderImage: UIImage(named: "app_logo"), options: [], completed: nil)
        
        viewBMain.clipsToBounds = true
        viewBMain.layer.cornerRadius = 30
        viewBMain.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.lblName.text = appDelegate?.dicCurrentUserData.name ?? ""
        self.lblEmail.text = appDelegate?.dicCurrentUserData.email ?? ""
        self.lblnumber.text = "\(appDelegate?.dicCurrentUserData.countryCode ?? "") \(appDelegate?.dicCurrentUserData.mobileNumber ?? "")"
        
        
        
        var media_link_url = appDelegate?.dicCurrentUserData.imagePath ?? ""
        media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        imgProfile.sd_setImage(with: URL.init(string: media_link_url), placeholderImage: UIImage(named: "app_logo"), options: [], completed: nil)
    }
    
    func countryCodeDemo(forCountry country: String) -> String? {
        let locale = Locale(identifier: "en_US")
        let countries = Locale.isoRegionCodes.compactMap { locale.localizedString(forRegionCode: $0) }
        let countryDict = Dictionary(uniqueKeysWithValues: zip(countries.map { $0.uppercased() }, Locale.isoRegionCodes))
        let countryCode = countryDict[country.uppercased()]
        return countryCode
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if appDelegate?.dicCurrentUserData.roleId == 1
        {
            return arrImgCustomer.count
        }
        else
        {
            return arrImgAgent.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblProfile.dequeueReusableCell(withIdentifier: "ProfileTableviewCell") as! ProfileTableviewCell
        if appDelegate?.dicCurrentUserData.roleId == 1
        {
            cell.imgProfile.image = UIImage(named: arrImgCustomer[indexPath.row])
            cell.lblMyProfile.text = arrNameCustomer[indexPath.row]
        }
        else
        {
            cell.imgProfile.image = UIImage(named: arrImgAgent[indexPath.row])
            cell.lblMyProfile.text = arrNameAgent[indexPath.row]
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if appDelegate?.dicCurrentUserData.roleId == 1
        {
            if indexPath.row == 0
            {
                let mainS = UIStoryboard(name: "Main", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 1
            {
//                let mainS = UIStoryboard(name: "Main", bundle: nil)
//                let vc = mainS.instantiateViewController(withIdentifier: "MyPaymentMethodsViewController") as! MyPaymentMethodsViewController
//                self.navigationController?.pushViewController(vc, animated: true)
                
                viewBg.isHidden = false
            }
            else if indexPath.row == 2
            { // Help
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 3
            {// Notification
                let mainS = UIStoryboard(name: "Main", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "WebVC") as! WebVC
                vc.strTitle = "Terms & Conditions"
                vc.strUrl = "https://www.alhamraains.com/wayak/terms_and_condition"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 4
            {
                let mainS = UIStoryboard(name: "Main", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "WebVC") as! WebVC
                vc.strTitle = "Privacy Policy"
                vc.strUrl = "https://www.alhamraains.com/wayak/privacy_policy"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                let mainS = UIStoryboard(name: "Main", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "WebVC") as! WebVC
                vc.strTitle = "Compensation Info"
                vc.strUrl = "https://www.alhamraains.com/wayak/compensation"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else
        {
            if indexPath.row == 0
            {
                let mainS = UIStoryboard(name: "Main", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 1
            {
                let mainS = UIStoryboard(name: "Main", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "CommissionReportVC") as! CommissionReportVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 2
            {
                viewBg.isHidden = false
            }
            else if indexPath.row == 3
            {// Help
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 4
            {// Notification
                let mainS = UIStoryboard(name: "Main", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "WebVC") as! WebVC
                vc.strTitle = "Terms & Conditions"
                vc.strUrl = "https://www.alhamraains.com/wayak/terms_and_condition"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 6
            {
                let mainS = UIStoryboard(name: "Main", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "WebVC") as! WebVC
                vc.strTitle = "Compensation Info"
                vc.strUrl = "https://www.alhamraains.com/wayak/compensation"
                self.navigationController?.pushViewController(vc, animated: true)
            }
//            else
//            {
//                let mainS = UIStoryboard(name: "Main", bundle: nil)
//                let vc = mainS.instantiateViewController(withIdentifier: "WebVC") as! WebVC
//                vc.strTitle = "FAQ"
//                vc.strUrl = "https://techmavedesigns.com/development/hamraa-insurance/faqs"
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
        }
        
        
        
        
    }
    @IBAction func clickedDelete(_ sender: Any) {
        AppUtilites.showAlert(title: "Delete", message: "Are you sure you want to Delete?", actionButtonTitle: "Yes", cancelButtonTitle: "No") {
            
            appDelegate?.objContryCodeConversionRate = ContryCodeConversionRate()

            UserDefaults.standard.set(false, forKey: "isUserLogin")
            UserDefaults.standard.synchronize()
            
            appDelegate?.setUpLogin()
            
        }
    }
    
    @IBAction func clickedLogOut(_ sender: Any) {
        AppUtilites.showAlert(title: "Logout", message: "Are you sure you want to Logout?", actionButtonTitle: "Yes", cancelButtonTitle: "No") {
            
            appDelegate?.objContryCodeConversionRate = ContryCodeConversionRate()
            
            UserDefaults.standard.set(false, forKey: "isUserLogin")
            UserDefaults.standard.synchronize()
            
            appDelegate?.setUpLogin()
            
        }
    }
    @IBAction func clilckedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickedWhatsapp(_ sender: Any) {
        let phoneNumber = "+964 7700 1700 16" // Replace with the recipient's phone number
        
        if let url = URL(string: "https://wa.me/\(phoneNumber)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    @IBAction func clickedEmail(_ sender: Any) {
        let emailAddress = "info@alhamraains.com"
        let subject = ""
        let body = ""
        
        if let emailURL = URL(string: "mailto:\(emailAddress)?subject=\(subject)&body=\(body)") {
            if UIApplication.shared.canOpenURL(emailURL) {
                UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
            } else {
                // Handle case where Mail app is not installed
                print("Mail app is not installed on this device.")
            }
        }
    }
    @IBAction func clickedClose(_ sender: Any) {
        viewBg.isHidden = true
    }
    
    
    
}
class ProfileTableviewCell : UITableViewCell {
    
    @IBOutlet weak var imgProfile:UIImageView!
    @IBOutlet weak var lblMyProfile: UILabel!
    
}
