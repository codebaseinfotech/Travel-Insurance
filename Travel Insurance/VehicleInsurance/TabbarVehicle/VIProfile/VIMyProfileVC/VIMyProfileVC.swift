//
//  VIMyProfileVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 06/06/25.
//

import UIKit

class VIMyProfileVC: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView! {
        didSet {
            var media_link_url = appDelegate?.dicCurrentUserData.imagePath ?? ""
            media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            imgProfile.sd_setImage(with: URL.init(string: media_link_url), placeholderImage: UIImage(named: "app_logo"), options: [], completed: nil) 
        }
    }
    @IBOutlet weak var lblName: UILabel! {
        didSet {
            lblName.text = appDelegate?.dicCurrentUserData.name ?? ""
        }
    }
    
    @IBOutlet weak var viewTabbar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewTabbar.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 6, spread: 0)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
    }
    @IBAction func btnEditProfileAction(_ sender: Any) {
        let vc = VIEditProfileVC.instantiate("Vehicle") as! VIEditProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnPersonalInformationAction(_ sender: Any) {
    }
    @IBAction func btnMyClaimAction(_ sender: Any) {
    }
    @IBAction func btnMyInsuranceAction(_ sender: Any) {
    }
    @IBAction func btnMyEndorsements(_ sender: Any) {
        let vc = VIMyEndorsementsVC.instantiate("Vehicle") as! VIMyEndorsementsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnPrivacyPolicy(_ sender: Any) {
    }
    @IBAction func btnTermsConditionAction(_ sender: Any) {
    }
    @IBAction func btnLogoutAction(_ sender: Any) {
    }
    
    @IBAction func btnTHomeAction(_ sender: Any) {
        let vc = VehicleHomeVC.instantiate("Vehicle") as! VehicleHomeVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func btnTMyInsuranceAction(_ sender: Any) {
        let vc = VehicleMyInsuranceVC.instantiate("Vehicle") as! VehicleMyInsuranceVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}
