//
//  VehicleNotificationVC.swift
//  Hamraa Insurance
//
//  Created by Poojagabani on 03/06/25.
//

import UIKit

class VehicleNotificationVC: UIViewController {

    @IBOutlet weak var tblViewNotification: UITableView! {
        didSet {
            tblViewNotification.delegate = self
            tblViewNotification.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
 

}
// MARK: - tblView Delegate & DataSource -
extension VehicleNotificationVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 3 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblViewNotification.dequeueReusableCell(withIdentifier: "VehicleNotificationTblViewCell") as! VehicleNotificationTblViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("VehicleNotificationHeaderView", owner: self, options: [:])?.first as! VehicleNotificationHeaderView

        headerView.btnMarkAllAs.isHidden = section == 0 ? false : true
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    
}

// MARK: - VehicleNotificationTblViewCell -
class VehicleNotificationTblViewCell: UITableViewCell {
    
    @IBOutlet weak var imgNotification: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDEscription: UILabel!
}
