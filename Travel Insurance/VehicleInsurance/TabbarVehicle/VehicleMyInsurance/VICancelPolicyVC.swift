//
//  VICancelPolicyVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 05/06/25.
//

import UIKit

class VICancelPolicyVC: UIViewController {

    @IBOutlet weak var viewOtherMessage: UIView!
    @IBOutlet weak var txtOtherMessage: UITextView!
    
    @IBOutlet weak var imgVehilcleSold: UIImageView!
    @IBOutlet weak var imgChangeProvider: UIImageView!
    @IBOutlet weak var imgDuplicatePolicy: UIImageView!
    @IBOutlet weak var imgNoLongerNeed: UIImageView!
    @IBOutlet weak var imgOther: UIImageView!
    
    @IBOutlet weak var imgUploadDocument: UIImageView!
    @IBOutlet weak var stackViewUploadDocument: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnVehicleSoldAction(_ sender: Any) {
        imgVehilcleSold.image = UIImage(named: "ic_selectCard")
        imgChangeProvider.image = UIImage(named: "ic_unSelectCard")
        imgDuplicatePolicy.image = UIImage(named: "ic_unSelectCard")
        imgNoLongerNeed.image = UIImage(named: "ic_unSelectCard")
        imgOther.image = UIImage(named: "ic_unSelectCard")
        
        viewOtherMessage.isHidden = true
    }
    @IBAction func btnChangeProviderAction(_ sender: Any) {
        imgChangeProvider.image = UIImage(named: "ic_selectCard")
        imgVehilcleSold.image = UIImage(named: "ic_unSelectCard")
        imgDuplicatePolicy.image = UIImage(named: "ic_unSelectCard")
        imgNoLongerNeed.image = UIImage(named: "ic_unSelectCard")
        imgOther.image = UIImage(named: "ic_unSelectCard")
        
        viewOtherMessage.isHidden = true
    }
    @IBAction func btnDuplicatePolicy(_ sender: Any) {
        imgDuplicatePolicy.image = UIImage(named: "ic_selectCard")
        imgChangeProvider.image = UIImage(named: "ic_unSelectCard")
        imgVehilcleSold.image = UIImage(named: "ic_unSelectCard")
        imgNoLongerNeed.image = UIImage(named: "ic_unSelectCard")
        imgOther.image = UIImage(named: "ic_unSelectCard")
        
        viewOtherMessage.isHidden = true
    }
    @IBAction func btnNoLongerNeedAction(_ sender: Any) {
        imgNoLongerNeed.image = UIImage(named: "ic_selectCard")
        imgChangeProvider.image = UIImage(named: "ic_unSelectCard")
        imgDuplicatePolicy.image = UIImage(named: "ic_unSelectCard")
        imgVehilcleSold.image = UIImage(named: "ic_unSelectCard")
        imgOther.image = UIImage(named: "ic_unSelectCard")
        
        viewOtherMessage.isHidden = true
    }
    @IBAction func btnOtherAction(_ sender: Any) {
        imgOther.image = UIImage(named: "ic_selectCard")
        imgChangeProvider.image = UIImage(named: "ic_unSelectCard")
        imgDuplicatePolicy.image = UIImage(named: "ic_unSelectCard")
        imgNoLongerNeed.image = UIImage(named: "ic_unSelectCard")
        imgVehilcleSold.image = UIImage(named: "ic_unSelectCard")
        
        viewOtherMessage.isHidden = false
    }
    @IBAction func btnUploadDocumentAction(_ sender: Any) {
    }
    
    @IBAction func btnCancelPolicyAction(_ sender: Any) {
        let vc = VIPolicyCancelSuccessVC.instantiate("Vehicle") as! VIPolicyCancelSuccessVC
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    

}
