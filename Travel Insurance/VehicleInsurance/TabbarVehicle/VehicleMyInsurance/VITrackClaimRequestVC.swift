//
//  VITrackClaimRequestVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 05/06/25.
//

import UIKit

class VITrackClaimRequestVC: UIViewController {

    @IBOutlet weak var lblClaimReferanceNo: UILabel!
    @IBOutlet weak var lblDateSubmited: UILabel!
    @IBOutlet weak var lblClaimType: UILabel!
    @IBOutlet weak var lblVehicle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgFirstDoc: UIImageView!
    @IBOutlet weak var imgSecondDoc: UIImageView!
    @IBOutlet weak var viewClaimStatus: UIView!
    @IBOutlet weak var btnClaimStatus: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
    }
    

}
