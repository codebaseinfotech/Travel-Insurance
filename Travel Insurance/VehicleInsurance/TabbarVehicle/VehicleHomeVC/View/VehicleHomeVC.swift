//
//  VehicleHomeVC.swift
//  Hamraa Insurance
//
//  Created by Poojagabani on 03/06/25.
//

import UIKit

class VehicleHomeVC: UIViewController {

    @IBOutlet weak var lblUserName: UILabel! {
        didSet {
            lblUserName.text = "\(appDelegate?.dicCurrentUserData.name ?? "") 👋"
        }
    }
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblCountNotification: UILabel!
    
    @IBOutlet weak var imgUserProfile: UIImageView! {
        didSet {
            var media_link_url = appDelegate?.dicCurrentUserData.imagePath ?? ""
            media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            imgUserProfile.sd_setImage(with: URL.init(string: media_link_url), placeholderImage: UIImage(named: "app_logo"), options: [], completed: nil)
        }
    }
    
    @IBOutlet weak var tblViewRecentClaim: UITableView! {
        didSet {
            
            tblViewRecentClaim.register(UINib(nibName: "VehicleRecentClaimTblViewCell", bundle: nil), forCellReuseIdentifier: "VehicleRecentClaimTblViewCell")
            tblViewRecentClaim.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)

            tblViewRecentClaim.delegate = self
            tblViewRecentClaim.dataSource = self
        }
    }
    @IBOutlet weak var heightTblView: NSLayoutConstraint!
    @IBOutlet weak var viewTabbar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewTabbar.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.11), alpha: 1, x: 0, y: 0, blur: 6, spread: 0)

        // Do any additional setup after loading the view.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey] {
                let newsize  = newvalue as! CGSize
                self.heightTblView.constant = newsize.height
            }
        }
    }
    
    @IBAction func btnNotificationAction(_ sender: Any) {
        let vc = VehicleNotificationVC.instantiate("Vehicle") as! VehicleNotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnSearchAction(_ sender: Any) {
    }
    
    @IBAction func btnTravelInsurance(_ sender: Any) {
        if appDelegate?.dicCurrentUserData.roleId == 1
        {
            appDelegate?.setUpHomeCustomer()
        }
        else
        {
            appDelegate?.setUpHomeAgent()
        }
    }
    @IBAction func btnVehicleInsurance(_ sender: Any) {
        let vc = VIProcess1VC.instantiate("Vehicle") as! VIProcess1VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //tabbar Action Method
    @IBAction func btnTMyInsurance(_ sender: Any) {
        let vc = VehicleMyInsuranceVC.instantiate("Vehicle") as! VehicleMyInsuranceVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func btnTProfileAction(_ sender: Any) {
        let vc = VIMyProfileVC.instantiate("Vehicle") as! VIMyProfileVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    

}

// MARK: - tblView Delegate & DataSource
extension VehicleHomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblViewRecentClaim.dequeueReusableCell(withIdentifier: "VehicleRecentClaimTblViewCell") as! VehicleRecentClaimTblViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}
