//
//  VehicleRecentClaimTblViewCell.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 03/06/25.
//

import UIKit

class VehicleRecentClaimTblViewCell: UITableViewCell {

    @IBOutlet weak var lblInsuranceType: UILabel!
    @IBOutlet weak var lblDEs: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
