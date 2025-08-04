//
//  HomeDetailVC.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 06/11/23.
//

import UIKit

class HomeDetailVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var viewB: UIView!
    
    var isOpenAgent = false
    
    var strId = ""
    
    var dicPlanDetails = TIPlanDetailsResponse()
    
    var arrContaianObjc = NSMutableArray()
    
    var isAPICall = false
    
    var isDirectNextPage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.showsVerticalScrollIndicator = false

        tblView.delegate = self
        tblView.dataSource = self
        
        viewB.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.08), alpha: 1, x: 0, y: 0, blur: 18, spread: 0)
        
        callPlanDetailsAPI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onNotificationForm1(notification:)), name: Notification.Name.myNotificationForm1, object: nil)

        
        // Do any additional setup after loading the view.
    }
    
    @objc func onNotificationForm1(notification:Notification)
    {
        isDirectNextPage = true
        
        callPlanDetailsAPI()
    }
    
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickedProceed(_ sender: Any) {
        if let isUserLogin = UserDefaults.standard.value(forKey: "isUserLogin") as? Bool
        {
            if isUserLogin == true
            {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Form2VC") as! Form2VC
                vc.planid = self.strId
                vc.dicPlanDetails = self.dicPlanDetails
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            else
            {
              
                let mainS = UIStoryboard(name: "Main", bundle: nil)
                let vc = mainS.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                vc.isFromHome = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else
        {
            let mainS = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainS.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            vc.isFromHome = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    
    // MARK: - calling API
    
    func callPlanDetailsAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let parm = ["id":"\(self.strId)"]
        
        print(parm)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(PLAN_TYPE, parameters: parm) { response, error, statusCode in
            
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
                        if let dicresponse = response?.value(forKey: "response") as? NSDictionary
                        {
                            let dicData = TIPlanDetailsResponse(fromDictionary: dicresponse)
                            self.dicPlanDetails = dicData
                        }
                        self.isAPICall = true
                        self.tblView.reloadData()
                        
                        if self.isDirectNextPage == true
                        {
                            self.isDirectNextPage = false
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Form2VC") as! Form2VC
                            vc.planid = self.strId
                            vc.dicPlanDetails = self.dicPlanDetails
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        
                    }
                    else
                    {
                        APIClient.sharedInstance.hideIndicator()
                    }
                }
                else
                {
                    APIClient.sharedInstance.hideIndicator()
                }
            }
            else
            {
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }

}

extension HomeDetailVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.isAPICall == true
        {
            return 1 + dicPlanDetails.planTitles.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        else
        {
            if arrContaianObjc.contains(section){
                
                if dicPlanDetails.planTitles.count > 0
                {
                    return dicPlanDetails.planTitles[section-1].planBenefits.count
                }
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "HomeDetailFirstCell") as! HomeDetailFirstCell
            
            if self.isAPICall == true
            {
                var media_link_url = self.dicPlanDetails.planImage ?? ""
                media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                cell.imgPic.sd_setImage(with: URL.init(string: media_link_url), placeholderImage: nil, options: [], completed: nil)
                
                cell.lblName.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1), alpha: 1, x: 1, y: 4, blur: 9, spread: 0)
                
                cell.lblName.layer.shadowColor = UIColor.black.cgColor
                cell.lblName.layer.shadowOpacity = 0.7 // Adjust opacity (0.0 to 1.0)
                cell.lblName.layer.shadowOffset = CGSize(width: 2, height: 2) // Adjust shadow offset
                cell.lblName.layer.shadowRadius = 3 // Adjust shadow blur radius
                cell.lblName.layer.masksToBounds = false
                
                cell.lblSubName.layer.shadowColor = UIColor.black.cgColor
                cell.lblSubName.layer.shadowOpacity = 0.5 // Adjust opacity (0.0 to 1.0)
                cell.lblSubName.layer.shadowOffset = CGSize(width: 2, height: 2) // Adjust shadow offset
                cell.lblSubName.layer.shadowRadius = 3 // Adjust shadow blur radius
                cell.lblSubName.layer.masksToBounds = false
                
                cell.lblName.text = "\(self.dicPlanDetails.planTypeCategory.name ?? "")"
                
                cell.lblSubName.text = "\(self.dicPlanDetails.planType ?? "")"
                
                cell.lblDesc.text = self.dicPlanDetails.planTypeDescription.convertHTMLToPlainText() ?? ""
                
                if dicPlanDetails.categoryArr.count > 0
                {
                    cell.lblFeatures.isHidden = false
                    cell.heightColle.constant = 50
                    cell.topViewC.constant = 20
                    cell.topFeature.constant = 17
                    cell.topColl.constant = 11
                    
                    cell.arrPlan_F = dicPlanDetails.categoryArr
                    
                    cell.collectionViewFeatures.reloadData()
                }
                else
                {
                    cell.lblFeatures.isHidden = true
                    cell.heightColle.constant = 0
                    cell.topViewC.constant = 0
                    cell.topViewC.constant = 0
                    cell.topFeature.constant = 0
                    cell.topColl.constant = 0
                }
            }
            
            return cell
        }
        else
        {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "HomeDetailSecondCell") as! HomeDetailSecondCell
            
            let dicData = dicPlanDetails.planTitles[indexPath.section-1].planBenefits[indexPath.row]
            
            cell.viewMain.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1), alpha: 1, x: 0, y: 0, blur: 17, spread: 0)
            
            cell.lblDes.text = "\(dicData.planDescription ?? "")"
            cell.lblPrice.text = "\(dicData.planCoverage ?? "")"
            
            let lastSection = tableView.numberOfSections - 1
            let lastRowIndex = tableView.numberOfRows(inSection: lastSection) - 1

            if let lastCell = tableView.cellForRow(at: IndexPath(row: lastRowIndex, section: lastSection)) {
                // Do something with the last cell
                print("Last cell: \(lastCell)")
                
                cell.viewMain.layer.cornerRadius = 10
                cell.viewMain.layer.maskedCorners = [.layerMinXMaxYCorner, . layerMaxXMaxYCorner] // Bottom Corner
            } else {
                print("Failed to retrieve last cell.")
                cell.viewMain.layer.cornerRadius = 0
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0.5
        }else{
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            return UIView()
        }else{
            let headerView = Bundle.main.loadNibNamed("HomeDetailView", owner: self, options: [:])?.first as! HomeDetailView
            
            let dicData = dicPlanDetails.planTitles[section-1]
            
            headerView.viewMain.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 17, spread: 0)
            
//            headerView.viewMain.clipsToBounds = true
            headerView.viewMain.layer.cornerRadius = 10
            headerView.viewMain.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner
            
            if arrContaianObjc.contains(section){
                headerView.imgArrow.image = UIImage(named: "arrow-up")
            }
            else
            {
                headerView.imgArrow.image = UIImage(named: "Vector 1")
            }
            
            headerView.lblName.text = dicData.planTitle ?? ""
            
            let button = UIButton(type: .custom)
            button.frame = headerView.bounds
            button.tag = section // Assign section tag to this button
            button.addTarget(self, action: #selector(tapSection(sender:)), for: .touchUpInside)
          //  button.setTitle("Section: \(section)", for: .normal)
            headerView.addSubview(button)//
            
            return headerView
        }
    }
    
    @objc func tapSection(sender: UIButton) {
        
        let section = sender.tag
        
        if arrContaianObjc.contains(section){
            
            arrContaianObjc.remove(section)
            
            self.tblView.beginUpdates()
            
            for index in 0..<dicPlanDetails.planTitles[section-1].planBenefits.count
            {
                let indexPath = IndexPath.init(row: index, section: section)
                self.tblView.deleteRows(at: [indexPath], with: .none)
                
            }
            
            self.tblView.endUpdates()
            
        } else{
            
            arrContaianObjc.add(section)
            
            self.tblView.beginUpdates()
            
            for index in 0..<dicPlanDetails.planTitles[section-1].planBenefits.count
            {
                let indexPath = IndexPath.init(row: index, section: section)
                self.tblView.insertRows(at: [indexPath], with: .none)
                
            }
            
            self.tblView.endUpdates()
            
            
        }
        
        tblView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       
        let lastSection = tblView.numberOfSections - 1
        
        if section == 0{
            return 0.5
        }else if lastSection == section{
            
            if dicPlanDetails.planTypeCategory.type.uppercased().contains("OUTBOUND") == true {
                return 120
            }
            
            return 60
            
        }else{
            return 0.5
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let lastSection = tblView.numberOfSections - 1
        
        if section == 0{
            return UIView()
        }else if lastSection == section{
            let footerView = Bundle.main.loadNibNamed("HomeDetailFooterView", owner: self, options: [:])?.first as! HomeDetailFooterView
            
            footerView.btnTC.tag = section
            footerView.btnTC.addTarget(self, action: #selector(clickedTC(_:)), for: .touchUpInside)
            
            footerView.btnMedicalNetwork.tag = section
            footerView.btnMedicalNetwork.addTarget(self, action: #selector(clickedMedicalNetwork(_:)), for: .touchUpInside)
            
            footerView.viewMainTC.isHidden = dicPlanDetails.planTypeCategory.type.uppercased().contains("OUTBOUND") == true ? false : true
            
            footerView.lblTitleMedical.text = dicPlanDetails.planTypeCategory.type.uppercased().contains("OUTBOUND") == true ? "View Medical Network Outbound" : "View Medical Network Inbound"
            
            return footerView
            
        }else{
            return UIView()
        }
    }
    
    @objc func clickedMedicalNetwork(_ sender: UIButton) {
        
        var urlString = ""
        
        if appDelegate?.strSelectedPermissionPurchase == "1" {
            urlString = "https://www.alhamraains.com/wayak/public/insurance_documnet/medical-network-inbound.pdf"
        } else {
            urlString = "https://www.alhamraains.com/wayak/public/insurance_documnet/medical-network-outbound.pdf"
        }
        
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc func clickedTC(_ sender: UIButton)
    {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "WebVC") as! WebVC
        vc.strTitle = "Terms & Conditions"
        vc.strUrl = "https://www.alhamraains.com/wayak/terms_and_condition"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

class HomeDetailFirstCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource
{
    
    @IBOutlet weak var imgPic: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var collectionViewFeatures: UICollectionView!
    
    @IBOutlet weak var lblFeatures: UILabel!
    @IBOutlet weak var heightColle: NSLayoutConstraint! // 50
    
    @IBOutlet weak var topViewC: NSLayoutConstraint!// 20
    @IBOutlet weak var topFeature: NSLayoutConstraint! // 17
    @IBOutlet weak var topColl: NSLayoutConstraint! // 11
    
    @IBOutlet weak var lblSubName: UILabel!
    
    var arrPlan_F: [TIPlanDetailsCategoryArr] = [TIPlanDetailsCategoryArr]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionViewFeatures.delegate = self
        collectionViewFeatures.dataSource = self

        // Initialization code
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrPlan_F.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionViewFeatures.dequeueReusableCell(withReuseIdentifier: "FeaturesHomeCell", for: indexPath) as! FeaturesHomeCell
        
        cell.lblNAm.text = arrPlan_F[indexPath.row].name
        
        return cell
    }
    
}

class HomeDetailSecondCell: UITableViewCell
{
    @IBOutlet weak var lblDes: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTop: UILabel!
    
    @IBOutlet weak var viewMain: UIView!
}

class FeaturesHomeCell: UICollectionViewCell
{
    @IBOutlet weak var lblNAm: UILabel!
    
}

extension String {
    func convertHTMLToPlainText() -> String {
        guard let data = self.data(using: .utf8) else {
            return self
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        do {
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            return attributedString.string
        } catch {
            print("Error converting HTML to plain text: \(error)")
            return self
        }
    }
}

