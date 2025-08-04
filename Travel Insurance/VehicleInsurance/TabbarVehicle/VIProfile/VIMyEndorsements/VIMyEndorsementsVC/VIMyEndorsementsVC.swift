//
//  VIMyEndorsementsVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 06/06/25.
//

import UIKit

class VIMyEndorsementsVC: UIViewController {

    @IBOutlet weak var tblViewEndro: UITableView! {
        didSet {
            tblViewEndro.delegate = self
            tblViewEndro.dataSource = self
        }
    }
    @IBOutlet weak var viewNoDataFounf: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCreateAction(_ sender: Any) {
        let vc = VINewEndorsementVC.instantiate("Vehicle") as! VINewEndorsementVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - tblView Delegate & DataSource
extension VIMyEndorsementsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VIEndrosementTblViewCell") as! VIEndrosementTblViewCell
        
        cell.tapOnDetails = {
            let vc = VIMyEndrosementDetailsVC.instantiate("Vehicle") as! VIMyEndrosementDetailsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return cell
    }
    
    
}

// MARK: - VIEndrosementTblViewCell
class VIEndrosementTblViewCell: UITableViewCell {
    
    @IBOutlet weak var lblRquestOn: UILabel!
    @IBOutlet weak var lblRefernceNumber: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    var tapOnDetails: (()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBAction func btnViewDetailsAction(_ sender: Any) {
        tapOnDetails?()
    }
}
