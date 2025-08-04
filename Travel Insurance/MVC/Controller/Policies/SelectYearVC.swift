//
//  SelectYearVC.swift
//  Hamraa Insurance
//
//  Created by Purv on 21/03/24.
//

import UIKit

protocol YearDate {
    func onYear(str: String)
}

class SelectYearVC: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tblView: UITableView!
    
    var arrMonth = ["2024","2025","2026","2027","2028","2029","2030","2031","2032","2033","2034","2035","2036","2037","2038","2039","2040","2041","2042","2043","2044","2045","2046","2047","2048","2049","2050"]
   
    var delegateOn: YearDate?
    
    var isSelect = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.dataSource = self
        tblView.delegate = self
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMonth.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "YearTblViewCell") as! YearTblViewCell
        
        cell.lblMonth.text = arrMonth[indexPath.row]
        
        if isSelect == indexPath.row {
            cell.imgRadio.image = UIImage(named: "radio")
        }
        else
        {
            cell.imgRadio.image = UIImage(named: "radio-button")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        isSelect = indexPath.row
        tblView.reloadData()
        
        self.delegateOn?.onYear(str: arrMonth[indexPath.row])
        self.dismiss(animated: false)
    }

}

class YearTblViewCell: UITableViewCell {
    
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var imgRadio: UIImageView!
    
}
