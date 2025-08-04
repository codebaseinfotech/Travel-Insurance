//
//  PlanPopupVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 29/07/24.
//

import UIKit

protocol onPlanPeriod
{
    func onPlanPeriod(text: String, isDestintion: Bool, id: Int, days: Int)
}

class PlanPopupVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    var strID = ""
    
    var arrAllPlan: [TIPlanPeriodData] = [TIPlanPeriodData]()
    
    var delegateSearch: onPlanPeriod?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.delegate = self
        tblView.dataSource = self

        callPlanPeriodAPI(id: strID)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedClos(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    
    func callPlanPeriodAPI(id: String) {
        
        APIClient.sharedInstance.showIndicator()
        
        let parm = ["":""]
        
        let _url = "?id=\(id)"
        
        print(parm)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(PLAN_PERIOD + _url, parameters: parm) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200 {
                    
                    if status == 1 {
                        
                        if let arr_response = response?.value(forKey: "data") as? NSArray {
                            
                            for obj in arr_response {
                                let dicData = TIPlanPeriodData(fromDictionary: obj as! NSDictionary)
                                self.arrAllPlan.append(dicData)
                            }
                            
                            self.tblView.reloadData()
                        }
                    } else {
                        self.setUpMakeToast(msg: message ?? "")
                    }
                } else {
                    self.setUpMakeToast(msg: message ?? "")
                }
            } else {
                APIClient.sharedInstance.hideIndicator()
                
                let message = response?.value(forKey: "message") as? String
                self.setUpMakeToast(msg: message ?? "")
            }
        }
        
    }
    
}

extension PlanPopupVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAllPlan.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "SelectPopupCell") as! SelectPopupCell
        
        let dicData = arrAllPlan[indexPath.row]
        
        cell.lblName.text = dicData.insurancePeriod ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dicData = arrAllPlan[indexPath.row]
        
        self.delegateSearch?.onPlanPeriod(text: dicData.insurancePeriod ?? "", isDestintion: true, id: dicData.insurancePeriodId ?? 0, days: dicData.days ?? 0)
        clickedClos(self)
    }
    
    
}
