//
//  HomeTopPopVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 29/07/24.
//

import UIKit

class HomeTopPopVC: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDEs: UILabel!
    
    @IBOutlet weak var viewClos: UIView!
    
    var strOpen = ""
    
    // MARK: - view Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewClos.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 18, spread: 0)

        if strOpen == "In Bound" {
            
            lblName.text = "In Bound"
            lblDEs.text = "This travel insurance policy provides coverage for passengers traveling from their country of departure to Iraq, or between two locations within Iraq, as part of an international journey. It ensures comprehensive protection throughout their travel within the country."
        } else {
            
            lblName.text = "Out Bound"
            lblDEs.text = "This travel insurance plan offers medical coverage for emergency medical expenses that may not be included in your existing health insurance. In addition to medical expenses, the plan also provides coverage for a variety of other travel-related benefits, ensuring broad protection while abroad."
        }

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Action
    @IBAction func clickedClose(_ sender: Any) {
        self.dismiss(animated: false)
    }
    

}
