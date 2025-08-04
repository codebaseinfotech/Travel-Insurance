//
//  SelectMonthVC.swift
//  Hamraa Insurance
//
//  Created by Purv on 21/03/24.
//

import UIKit

protocol MonthDate {
    func onMonthYear(str: String)
}

class SelectMonthVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblView: UITableView!
    
    var arrMonth = ["01 (January)","02 (February)","03 (March)","04 (April)","05 (May)","06 (June)","07 (July)","08 (August)","09 (September)","10 (October)","11 (November)","12 (December)"]
    
    var delegateOn: MonthDate?
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
        let cell = tblView.dequeueReusableCell(withIdentifier: "MonthTblViewCell") as! MonthTblViewCell
        
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
        
        self.delegateOn?.onMonthYear(str: arrMonth[indexPath.row])
        self.dismiss(animated: false)
    }

}

class MonthTblViewCell: UITableViewCell {
    
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var imgRadio: UIImageView!
    
}
