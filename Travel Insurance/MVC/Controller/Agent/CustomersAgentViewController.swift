//
//  CustomersAgentViewController.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 03/11/23.
//

import UIKit

class CustomersAgentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var StackView: UIStackView!
    @IBOutlet weak var lblNoDta: UILabel!
    
    var arrMyPolicy: [ITPolicyCurrent] = [ITPolicyCurrent]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.dataSource = self
        tblView.dataSource = self
        
        StackView.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.08), alpha: 1, x: 0, y: 0, blur: 18, spread: 0)
        
        callMyPlocyAPI()
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMyPolicy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "MyPoliciesTablevViewCell") as! MyPoliciesTablevViewCell
        
        let dicData = arrMyPolicy[indexPath.row]
        
        cell.lblPlan.text = "\(dicData.plans.planType ?? "")"
        
        cell.lblValidity.text = "\(dicData.timePeriod ?? "")"
        
        cell.lblPrice.text = "\(appDelegate?.objContryCodeConversionRate.abbreviation ?? "") \(dicData.totalPrice ?? "")"
        cell.lblTime.text = "Booked on \(dicData.policyStartDate ?? "")"
        
        cell.btnDetalis.tag = indexPath.row
        cell.btnDetalis.addTarget(self, action: #selector(clickedDetail(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func clickedDetail(_ sender: UIButton)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PolicyDetailAgentViewController") as! PolicyDetailAgentViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func clickedHome(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "HomeAgentViewController") as! HomeAgentViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func clickedProfile(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "ProfileViewController")
        as! ProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - calling API
    
    func callMyPlocyAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(MY_INSURANCE, parameters: [:]) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200
                {
                    if status == 200
                    {
                        if let arrData = response?.value(forKey: "response") as? NSArray
                        {
                            for obj in arrData
                            {
                                let dicData = ITPolicyCurrent(fromDictionary: obj as! NSDictionary)
                                self.arrMyPolicy.append(dicData)
                            }
                        }
                        
                        if self.arrMyPolicy.count > 0
                        {
                            self.lblNoDta.isHidden = true
                        }
                        else
                        {
                            self.lblNoDta.isHidden = false
                        }
                        
                        self.tblView.reloadData()
                    }
                    else
                    {
                        APIClient.sharedInstance.hideIndicator()
                        self.setUpMakeToast(msg: message ?? "")
                    }
                }
                else
                {
                    APIClient.sharedInstance.hideIndicator()
                    
                    self.setUpMakeToast(msg: message ?? "")
                }
            }
            else
            {
                APIClient.sharedInstance.hideIndicator()
            }
            
        }
    }
    
}
