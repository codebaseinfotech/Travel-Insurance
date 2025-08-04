//
//  OrderDetailViewController.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 31/10/23.
//

import UIKit

class OrderDetailViewController: UIViewController {

    @IBOutlet weak var lblPlan: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lblPassportNo: UILabel!
    @IBOutlet weak var lblNationality: UILabel!
    @IBOutlet weak var lblTravelPeriod: UILabel!
    @IBOutlet weak var lblDateGuarantee: UILabel!
    @IBOutlet weak var lblDateExpireGurantee: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    
    @IBOutlet weak var viewB: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewB.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.08), alpha: 1, x: 0, y: 0, blur: 18, spread: 0)

        // Do any additional setup after loading the view.
    }
   
    @IBAction func clickedMakePayment(_ sender: Any) {
        if appDelegate?.dicCurrentUserData.roleId == 1
        {
            let mainS = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainS.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(vc, animated: false)
        }
        else
        {
            let mainS = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainS.instantiateViewController(withIdentifier: "HomeAgentViewController") as! HomeAgentViewController
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
