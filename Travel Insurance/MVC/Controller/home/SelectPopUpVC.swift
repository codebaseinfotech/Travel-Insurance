//
//  SelectPopUpVC.swift
//  Hamraa Insurance
//
//  Created by Purv on 16/02/24.
//

import UIKit

protocol onSeachSelect
{
    func onSelectText(text: String, isDestintion: Bool, id: Int)
}

class SelectPopUpVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblView: UITableView!
    
    var isDestination = false
    
    var arrDestination = ["Afghanistan","Albania","Algeria","Andorra","Angola","Anguilla","Antigua &amp; Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia &amp; Herzegovina","Botswana","Brazil","British Virgin Islands","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Cape Verde","Cayman Islands","Chad","Chile","China","Colombia","Congo","Cook Islands","Costa Rica","Cote D Ivoire","Croatia","Cruise Ship","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Estonia","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Polynesia","French West Indies","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guam","Guatemala","Guernsey","Guinea","Guinea Bissau","Guyana","Haiti","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Isle of Man","Israel","Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kuwait","Kyrgyz Republic","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macau","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Mauritania","Mauritius","Mexico","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Namibia","Nepal","Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Palestine","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russia","Rwanda","Saint Pierre &amp; Miquelon","Samoa","San Marino","Satellite","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","South Africa","South Korea","Spain","Sri Lanka","St Kitts &amp; Nevis","St Lucia","St Vincent","St. Lucia","Sudan","Suriname","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Timor L'Este","Togo","Tonga","Trinidad &amp; Tobago","Tunisia","Turkey","Turkmenistan","Turks &amp; Caicos","Uganda","Ukraine","United Arab Emirates","United Kingdom","Uruguay","Uzbekistan","Venezuela","Vietnam","Virgin Islands (US)","Yemen","Zambia","Zimbabwe"]
    
    var isSearching = false
    
    var arrSearchData = [String]()
    
    var delegateSearch: onSeachSelect?
    
    var arrAllCountry: [TICountryCodeResponse] = [TICountryCodeResponse]()
    var arrAllCountrySearch: [TICountryCodeResponse] = [TICountryCodeResponse]()
    
    var zone_id = 0
    
    var indexPathID = 0
    
    var isOpenForm1 = false
    
    
    var isOpenForm3 = false

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.delegate = self
        tblView.dataSource = self
        
        self.txtSearch.delegate = self
        self.txtSearch.addTarget(self, action: #selector(searchWorkersAsPerText(_ :)), for: .editingChanged)

        if isOpenForm1 == true {
            callCountyCodeAPI(zone_id: zone_id)
        }
        
        // Do any additional setup after loading the view.
    }
    
    @objc func searchWorkersAsPerText(_ textfield:UITextField) {
        
        if isOpenForm1 == true {
            self.arrAllCountrySearch.removeAll()
            if textfield.text?.count != 0 {
                isSearching = true
                for dicData in self.arrAllCountry {

                    let isMachingWorker : NSString = (dicData.name ?? "") as NSString
                    let range = isMachingWorker.lowercased.range(of: textfield.text!, options: NSString.CompareOptions.caseInsensitive, range: nil,   locale: nil)
                    if range != nil {
                        arrAllCountrySearch.append(dicData)
                    }
                }
            } else {
                isSearching = false
                self.arrAllCountrySearch.removeAll()
                
            }
            self.tblView.reloadData()
        } else {
            if textfield.text == ""
            {
                self.isSearching = false
                
                tblView.reloadData()
            }
            else
            {
                self.isSearching = true
                
                self.arrSearchData.removeAll(keepingCapacity: false)
                
                arrSearchData = arrDestination.filter({$0.lowercased().contains((textfield.text?.lowercased())!)})
                
                tblView.reloadData()
            }
        }
        
    }
    
    @IBAction func clickedclose(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    func callCountyCodeAPI(zone_id: Int) {
        
        APIClient.sharedInstance.showIndicator()
        
        let parm = ["zone_id":"\(zone_id)"]
        
        print(parm)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(COUNTRY_LIST, parameters: parm) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200 {
                    
                    if status == 200 {
                        
                        if let arr_response = response?.value(forKey: "response") as? NSArray {
                            
                            for obj in arr_response {
                                let dicData = TICountryCodeResponse(fromDictionary: obj as! NSDictionary)
                                self.arrAllCountry.append(dicData)
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

extension SelectPopUpVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isOpenForm1 == true {
            if isSearching == true
            {
                return arrAllCountrySearch.count
            }
            else
            {
                return arrAllCountry.count
            }
        } else {
            if isSearching == true
            {
                return arrSearchData.count
            }
            else
            {
                return arrDestination.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "SelectPopupCell") as! SelectPopupCell
        
        if isOpenForm1 == true {
            var dicData = TICountryCodeResponse()
            
            if isSearching == true
            {
                dicData = arrAllCountrySearch[indexPath.row]
                
                cell.lblName.text = dicData.name ?? ""
            }
            else
            {
                dicData = arrAllCountry[indexPath.row]
                
                cell.lblName.text = dicData.name ?? ""
            }
        } else {
            if isSearching == true
            {
                cell.lblName.text = arrSearchData[indexPath.row]
            }
            else
            {
                cell.lblName.text = arrDestination[indexPath.row]
            }
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isOpenForm1 == true {
            var dicData = TICountryCodeResponse()
            
            if isDestination == true
            {
                if isSearching == true
                {
                    dicData = arrAllCountrySearch[indexPath.row]
                    
                    delegateSearch?.onSelectText(text: dicData.name ?? "", isDestintion: true, id: dicData.id ?? 0)
                    
                }
                else
                {
                    dicData = arrAllCountry[indexPath.row]
                    
                    delegateSearch?.onSelectText(text: dicData.name ?? "", isDestintion: true, id: dicData.id ?? 0)
                }
            }
            else
            {
                if isSearching == true
                {
                    dicData = arrAllCountrySearch[indexPath.row]
                    
                    delegateSearch?.onSelectText(text: dicData.name ?? "", isDestintion: false, id: dicData.id ?? 0)
                    
                }
                else
                {
                    dicData = arrAllCountry[indexPath.row]
                    
                    delegateSearch?.onSelectText(text: dicData.name ?? "", isDestintion: false, id: dicData.id ?? 0)
                }
            }
        } else {
            if isDestination == true
            {
                if isSearching == true
                {
                    delegateSearch?.onSelectText(text: arrSearchData[indexPath.row], isDestintion: true, id: 0)
                    
                }
                else
                {
                    delegateSearch?.onSelectText(text: arrDestination[indexPath.row], isDestintion: true, id: 0)
                }
            }
            else
            {
                if isSearching == true
                {
                    delegateSearch?.onSelectText(text: arrSearchData[indexPath.row], isDestintion: false, id: 0)
                    
                }
                else
                {
                    if isOpenForm3 == true {
                        delegateSearch?.onSelectText(text: arrDestination[indexPath.row], isDestintion: false, id: indexPathID)
                    }
                    else {
                        delegateSearch?.onSelectText(text: arrDestination[indexPath.row], isDestintion: false, id: 0)
                    }
                    
                    
                    
                }
            }
        }
        
        
        
        clickedclose(self)
    }
    
    
}

class SelectPopupCell: UITableViewCell
{
    @IBOutlet weak var lblName: UILabel!
    
}
