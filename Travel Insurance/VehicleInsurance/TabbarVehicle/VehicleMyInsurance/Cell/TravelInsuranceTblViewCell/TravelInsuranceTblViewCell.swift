//
//  TravelInsuranceTblViewCell.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 05/06/25.
//

import UIKit

class TravelInsuranceTblViewCell: UITableViewCell {

    @IBOutlet weak var imgPolicy: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStared: UILabel!
    @IBOutlet weak var lblVlidity: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
