//
//  VehicleUploadPhotoTblViewCell.swift
//  Hamraa Insurance
//
//  Created by Poojagabani on 04/06/25.
//

import UIKit

class VehicleUploadPhotoTblViewCell: UITableViewCell {

    @IBOutlet weak var stackViewUploadImg: UIStackView!
    @IBOutlet weak var imgPicVehicle: UIImageView!
    
    var tapOnUploadPic: (()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnUploadPhotoAction(_ sender: Any) {
        tapOnUploadPic?()
    }
    
}
