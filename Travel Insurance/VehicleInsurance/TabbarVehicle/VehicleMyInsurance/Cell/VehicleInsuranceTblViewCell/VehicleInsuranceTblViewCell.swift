//
//  VehicleInsuranceTblViewCell.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 05/06/25.
//

import UIKit

class VehicleInsuranceTblViewCell: UITableViewCell {

    @IBOutlet weak var viewCarDetails: UIView!
    @IBOutlet weak var viewBikeDetials: UIView!
    
    @IBOutlet weak var lblCarName: UILabel!
    @IBOutlet weak var lblCarNumber: UILabel!
    
    @IBOutlet weak var lblBikeName: UILabel!
    @IBOutlet weak var lblBikeNumber: UILabel!
    
    @IBOutlet weak var lblPlanName: UILabel!
    @IBOutlet weak var lblPlanType: UILabel!
    @IBOutlet weak var lblPolicyPrice: UILabel!
    
    @IBOutlet weak var tblviewAddOnss: UITableView! {
        didSet {
            tblviewAddOnss.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
            tblviewAddOnss.register(UINib(nibName: "VehiicleAddOnsTblViewCell", bundle: nil), forCellReuseIdentifier: "VehiicleAddOnsTblViewCell")
            
            tblviewAddOnss.delegate = self
            tblviewAddOnss.dataSource = self
        }
    }
    @IBOutlet weak var heightTblView: NSLayoutConstraint!
    
    @IBOutlet weak var viewCancelPolicy: UIView!
    @IBOutlet weak var viewViewDetails: UIView!
        
    @IBOutlet weak var viewMainClaim: UIView!
    @IBOutlet weak var viewPolictStatus: UIView!
    
    @IBOutlet weak var topClaimCon: NSLayoutConstraint!
    @IBOutlet weak var heightClaimCon: NSLayoutConstraint!
    
    var tapOnClaimTrack: (()->Void)?
    var tapOnCancelPolicy: (()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBikeDetials.isHidden = true
        
        // Initialization code
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey] {
                let newsize  = newvalue as! CGSize
                self.heightTblView.constant = newsize.height
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnTrackClaims(_ sender: Any) {
        tapOnClaimTrack?()
    }
    @IBAction func btnViewDetails(_ sender: Any) {
    }
    @IBAction func btnCancelPolicy(_ sender: Any) {
        tapOnCancelPolicy?()
    }
    
}

// MARK: - tblView Delegate & DataSource
extension VehicleInsuranceTblViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VehiicleAddOnsTblViewCell") as! VehiicleAddOnsTblViewCell
        
        return cell
    }
    
    
}
