//
//  VIEndrostmentSuccessVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 06/06/25.
//

import UIKit

class VIEndrostmentSuccessVC: UIViewController {

    @IBOutlet weak var lblRefernceNumber: UILabel!
    @IBOutlet weak var lblTrackThis: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fullText = "You can track this under “My Endorsements”"
        let linkText = "My Endorsements"
        let attributedString = NSMutableAttributedString(string: fullText)

        if let range = fullText.range(of: linkText) {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: #colorLiteral(red: 0.9333333333, green: 0.1137254902, blue: 0.137254902, alpha: 1), range: nsRange)
        }

        lblTrackThis.attributedText = attributedString

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCloseAction(_ sender: Any) {
        self.dismiss(animated: false)
    }
    @IBAction func btnViewEndorstmentStausAction(_ sender: Any) {
        btnCloseAction(self)
    }
    
     

}
