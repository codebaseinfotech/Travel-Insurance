//
//  PolicyDetailAgentViewController.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 03/11/23.
//

import UIKit

class PolicyDetailAgentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var lblInsuranceType: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblPlus: UILabel!
    @IBOutlet weak var lblDateOfGuarantee: UILabel!
    @IBOutlet weak var lblExpireOfGurantee: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var StackView: UIStackView!
    
  var arrName = ["Medical Benefits","Emergency Cash Advance","Missed Flight Connection","No medical test for travelling","Lost baggage cover","25% discount with plus"]
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tblView.dataSource = self
        tblView.delegate = self
        
        StackView.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.08), alpha: 1, x: 0, y: 0, blur: 18, spread: 0)
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "PolicyDetailTblcell") as! PolicyDetailTblcell
        cell.lblBenefits.text = arrName[indexPath.row]
        return cell
    }
    
    
    
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickedHome(_ sender: Any) {
    }
    
    @IBAction func clickedProfile(_ sender: Any) {
    }
    
    @IBAction func clickedPlan(_ sender: Any) {
    }
}
