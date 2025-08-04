//
//  ClaimTblViewCell.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 06/05/25.
//

import UIKit

protocol ActionTriggerClaimDelegate: AnyObject {
    func actionTriggerClaim()
}

class ClaimTblViewCell: UITableViewCell {

    @IBOutlet weak var viewClaim: UIView!
    @IBOutlet weak var lblStatus: UILabel!
    
    
    var actionTriggerClaimDelegate: ActionTriggerClaimDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func claimClickedAction(_ sender: Any) {
        actionTriggerClaimDelegate?.actionTriggerClaim()
    }
    
}
