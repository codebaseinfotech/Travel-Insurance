//
//  OnboardingVC.swift
//  Hamraa Insurance
//
//  Created by Purv on 07/03/24.
//

import UIKit

class OnboardingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func clickedGetStarted(_ sender: Any) {
        
        UserDefaults.standard.setValue(true, forKey: "isGetStarted")
        UserDefaults.standard.synchronize()

        appDelegate?.setUpLogin()
        
    }
}
