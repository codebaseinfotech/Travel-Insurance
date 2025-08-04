//
//  MyPoliciesViewController.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 02/11/23.
//

import UIKit
import Toast_Swift

class MyPoliciesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var lblNodataFond: UILabel!
    
    @IBOutlet weak var viewTop: UIView!
    
    @IBOutlet weak var viewCurrent: UIView!
    @IBOutlet weak var viewUpcomming: UIView!
    @IBOutlet weak var viewExpire: UIView!
    
    @IBOutlet weak var lblCurrent: UILabel!
    @IBOutlet weak var lblUpcomming: UILabel!
    @IBOutlet weak var lblExpire: UILabel!
    @IBOutlet weak var viewExport: UIView!
    
    var arrMyPolicyCurrent: [ITPolicyCurrent] = [ITPolicyCurrent]()
    var arrMyPolicyExpired: [ITPolicyCurrent] = [ITPolicyCurrent]()
    var arrMyPolicyUpcoming: [ITPolicyCurrent] = [ITPolicyCurrent]()

    var isSelectedTitle = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.lblNodataFond.isHidden = true
       
        viewTop.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.05), alpha: 1, x: 0, y: 0, blur: 15, spread: 0)
        viewCurrent.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.05), alpha: 1, x: 0, y: 0, blur: 15, spread: 0)
        viewUpcomming.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.05), alpha: 1, x: 0, y: 0, blur: 15, spread: 0)
        viewExpire.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.05), alpha: 1, x: 0, y: 0, blur: 15, spread: 0)
        
        tblView.dataSource = self
        tblView.delegate = self
        
        self.viewCurrent.backgroundColor = UIColor(hexString: "EE1D23")
        self.lblCurrent.textColor = UIColor.white
        
        self.viewUpcomming.backgroundColor = UIColor.white
        self.lblUpcomming.textColor = UIColor.black

        self.viewExpire.backgroundColor = UIColor.white
        self.lblExpire.textColor = UIColor.black

        stackView.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.08), alpha: 1, x: 0, y: 0, blur: 18, spread: 0)
        
        callMyPlocyAPI()
        
        if appDelegate?.dicCurrentUserData.roleId == 2 {
            viewExport.isHidden = false
        } else {
            viewExport.isHidden = true
        }
        
        // Do any additional setup after loading the view.
    }
  
    @IBAction func clickedExport(_ sender: Any) {
        
        
        print("https://www.alhamraains.com/wayak/all-export-slug/\(appDelegate?.dicCurrentUserData.slug ?? "")")
        
        openSafari(urlString: "https://www.alhamraains.com/wayak/all-export-slug/\(appDelegate?.dicCurrentUserData.slug ?? "")")
    }
    
    func openSafari(urlString: String) {
        // Ensure the string is a valid URL
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Handle the case where the URL cannot be opened
                print("Cannot open URL")
            }
        }
    }
    
    @IBAction func clickedCurrent(_ sender: Any) {
        isSelectedTitle = 1
        self.viewCurrent.backgroundColor = UIColor(hexString: "EE1D23")
        self.lblCurrent.textColor = UIColor.white
        
        self.viewUpcomming.backgroundColor = UIColor.white
        self.lblUpcomming.textColor = UIColor.black

        self.viewExpire.backgroundColor = UIColor.white
        self.lblExpire.textColor = UIColor.black
        
        if self.arrMyPolicyCurrent.count > 0
        {
            self.lblNodataFond.isHidden = true
        }
        else
        {
            self.lblNodataFond.isHidden = false
        }
        
        self.tblView.reloadData()
        
    }
    
    @IBAction func clickedUpcoming(_ sender: Any) {
        isSelectedTitle = 2
        self.viewUpcomming.backgroundColor = UIColor(hexString: "EE1D23")
        self.lblUpcomming.textColor = UIColor.white
        
        self.viewCurrent.backgroundColor = UIColor.white
        self.lblCurrent.textColor = UIColor.black

        self.viewExpire.backgroundColor = UIColor.white
        self.lblExpire.textColor = UIColor.black
        
        if self.arrMyPolicyUpcoming.count > 0
        {
            self.lblNodataFond.isHidden = true
        }
        else
        {
            self.lblNodataFond.isHidden = false
        }
        
        self.tblView.reloadData()
    }
    
    
    @IBAction func clickedExpired(_ sender: Any) {
        isSelectedTitle = 3
        self.viewExpire.backgroundColor = UIColor(hexString: "EE1D23")
        self.lblExpire.textColor = UIColor.white
        
        self.viewUpcomming.backgroundColor = UIColor.white
        self.lblUpcomming.textColor = UIColor.black

        self.viewCurrent.backgroundColor = UIColor.white
        self.lblCurrent.textColor = UIColor.black
        
        if self.arrMyPolicyExpired.count > 0
        {
            self.lblNodataFond.isHidden = true
        }
        else
        {
            self.lblNodataFond.isHidden = false
        }
        
        self.tblView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSelectedTitle == 1
        {
            return arrMyPolicyCurrent.count
        }
        else if isSelectedTitle == 2
        {
            return arrMyPolicyUpcoming.count
        }
        else
        {
            return arrMyPolicyExpired.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "MyPoliciesTablevViewCell") as! MyPoliciesTablevViewCell
        
        if isSelectedTitle == 1
        {
            let dicData = arrMyPolicyCurrent[indexPath.row]
            
            cell.lblPlan.text = "\(dicData.plans.planType ?? "")"
            
            cell.lblValidity.text = "\(dicData.timePeriod ?? "") days"
            
            
            cell.lblTime.text = "\(dicData.currencySymbol ?? "") \(dicData.totalPrice ?? "")"
            
            cell.btnDetalis.tag = indexPath.row
            cell.btnDetalis.addTarget(self, action: #selector(clickedDetail(_:)), for: .touchUpInside)
            
            
            //            cell.lblPolicy.text = "\(dicData.userinsurancedata[indexPath.row].status ?? "")"
            let timeLocal = utcToLocal(dateStr: dicData.userinsurance[0].createdAt ?? "")
            
            let bidAccepted = dicData.transactionDate ?? ""
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US")
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date1 = formatter.date(from: bidAccepted)
            let Dform = DateFormatter()
            Dform.dateFormat = "dd-MM-yyyy"
            let strDate = Dform.string(from: date1!)
            
            cell.lblPrice.text = strDate
            
//            cell.lblPrice.text = timeInterval(timeAgo: timeLocal ?? "")
            
               
            if dicData.transectionStatus.count > 0
            {
                cell.cancelView.isHidden = false
                
                if dicData.transectionStatus[0].status ?? "" == "rejected" {
                    
                    cell.cancelView.isHidden = false
                    
                    cell.lblPolicy.text = "Cancellation rejected"
//                    
                    cell.btnCancelPolicy.tag = indexPath.row
                    cell.btnCancelPolicy.removeTarget(self, action: #selector(clickedCancel(_:)), for: .touchUpInside)
                    
                } else if dicData.transectionStatus[0].status ?? "" == "cancel request" {
                    cell.cancelView.isHidden = false
                    
                    cell.lblPolicy.text = "cancel request sent"
                    
                    cell.btnCancelPolicy.tag = indexPath.row
                    cell.btnCancelPolicy.addTarget(self, action: #selector(clickedCancel(_:)), for: .touchUpInside)
                } else if dicData.transectionStatus[0].status ?? "" == "refund" {
                    cell.cancelView.isHidden = false
                    
                    cell.lblPolicy.text = "Refunded"
                    
                    cell.btnCancelPolicy.tag = indexPath.row
                    cell.btnCancelPolicy.addTarget(self, action: #selector(clickedCancel(_:)), for: .touchUpInside)
                }
                else
                {
                    
                    cell.cancelView.isHidden = true
 
                    cell.lblPolicy.text = "\(dicData.transectionStatus[0].status ?? "")"
 
                    cell.btnCancelPolicy.tag = indexPath.row
                    cell.btnCancelPolicy.addTarget(self, action: #selector(clickedCancel(_:)), for: .touchUpInside)

                }
            }
            else
            {
                cell.cancelView.isHidden = true
            }
            
 
            var media_link_url = dicData.plans.planImage ?? ""
            media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            cell.imgPlan.sd_setImage(with: URL.init(string: media_link_url), placeholderImage: UIImage(named: "app_logo"), options: [], completed: nil)
           
            
        }
        else if isSelectedTitle == 2
        {
            let dicData = arrMyPolicyUpcoming[indexPath.row]
            
            cell.lblPlan.text = "\(dicData.plans.planType ?? "")"
            
            cell.lblValidity.text = "\(dicData.timePeriod ?? "") days"
            
            let timeLocal = utcToLocal(dateStr: dicData.userinsurance[0].createdAt ?? "")
            
            let bidAccepted = dicData.transactionDate ?? ""
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US")
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date1 = formatter.date(from: bidAccepted)
            let Dform = DateFormatter()
            Dform.dateFormat = "dd-MM-yyyy"
            let strDate = Dform.string(from: date1!)
            
            cell.lblValidity.text = "\(dicData.timePeriod ?? "") days"
            
            cell.lblPrice.text = strDate
            
            cell.lblTime.text = "\(dicData.currencySymbol ?? "") \(dicData.totalPrice ?? "")"
            
            cell.btnDetalis.tag = indexPath.row
            cell.btnDetalis.addTarget(self, action: #selector(clickedDetail(_:)), for: .touchUpInside)
            
            if dicData.transectionStatus.count > 0
            {
                cell.cancelView.isHidden = false
                
                if dicData.transectionStatus[0].status ?? "" == "rejected" {
                    
                    cell.cancelView.isHidden = false
                    
                    cell.lblPolicy.text = "Cancellation rejected"
//
                    cell.btnCancelPolicy.tag = indexPath.row
                    cell.btnCancelPolicy.removeTarget(self, action: #selector(clickedCancel(_:)), for: .touchUpInside)
                    
                } else if dicData.transectionStatus[0].status ?? "" == "cancel request" {
                    cell.cancelView.isHidden = false
                    
                    cell.lblPolicy.text = "cancel request sent"
                    
                    cell.btnCancelPolicy.tag = indexPath.row
                    cell.btnCancelPolicy.addTarget(self, action: #selector(clickedCancel(_:)), for: .touchUpInside)
                } else if dicData.transectionStatus[0].status ?? "" == "refund" {
                    cell.cancelView.isHidden = false
                    
                    cell.lblPolicy.text = "Refunded"
                    
                    cell.btnCancelPolicy.tag = indexPath.row
                    cell.btnCancelPolicy.addTarget(self, action: #selector(clickedCancel(_:)), for: .touchUpInside)
                } else if dicData.transectionStatus[0].status ?? "" == "success" {
                    cell.cancelView.isHidden = false
                    
                    cell.lblPolicy.text = "Cancel Policy?"
                    
                    cell.btnCancelPolicy.tag = indexPath.row
                    cell.btnCancelPolicy.addTarget(self, action: #selector(clickedCancel(_:)), for: .touchUpInside)
                }
                else
                {
                    
                    cell.cancelView.isHidden = false
 
                    cell.lblPolicy.text = "\(dicData.transectionStatus[0].status ?? "")"
 
                    cell.btnCancelPolicy.tag = indexPath.row
                    cell.btnCancelPolicy.addTarget(self, action: #selector(clickedCancel(_:)), for: .touchUpInside)
                }
            }
            else
            {
                cell.cancelView.isHidden = true
            }
            
            var media_link_url = dicData.plans.planImage ?? ""
            media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            cell.imgPlan.sd_setImage(with: URL.init(string: media_link_url), placeholderImage: UIImage(named: "app_logo"), options: [], completed: nil)
        }
        else
        {
            let dicData = arrMyPolicyExpired[indexPath.row]
            
            cell.lblPlan.text = "\(dicData.plans.planType ?? "")"
            
            cell.lblValidity.text = "\(dicData.timePeriod ?? "") days"
            
            if dicData.transectionStatus.count > 0
            {
                cell.cancelView.isHidden = false
                
                if dicData.transectionStatus[0].status ?? "" == "rejected" {
                    
                    cell.cancelView.isHidden = false
                    
                    cell.lblPolicy.text = "Cancellation rejected"
//
                    cell.btnCancelPolicy.tag = indexPath.row
                    cell.btnCancelPolicy.removeTarget(self, action: #selector(clickedCancel(_:)), for: .touchUpInside)
                    
                } else if dicData.transectionStatus[0].status ?? "" == "cancel request" {
                    cell.cancelView.isHidden = false
                    
                    cell.lblPolicy.text = "Cancel request sent"
                    
                    cell.btnCancelPolicy.tag = indexPath.row
                    cell.btnCancelPolicy.addTarget(self, action: #selector(clickedCancel(_:)), for: .touchUpInside)
                } else if dicData.transectionStatus[0].status ?? "" == "refund" {
                    cell.cancelView.isHidden = false
                    
                    cell.lblPolicy.text = "Refunded"
                    
                    cell.btnCancelPolicy.tag = indexPath.row
                    cell.btnCancelPolicy.addTarget(self, action: #selector(clickedCancel(_:)), for: .touchUpInside)
                } else if dicData.transectionStatus[0].status ?? "" == "cancelled" {
                    cell.cancelView.isHidden = false
                    
                    cell.lblPolicy.text = "Cancelled"
                    
                    cell.btnCancelPolicy.tag = indexPath.row
                    cell.btnCancelPolicy.addTarget(self, action: #selector(clickedCancel(_:)), for: .touchUpInside)
                }
                else
                {
                    
                    cell.cancelView.isHidden = true
 
                    cell.lblPolicy.text = "\(dicData.transectionStatus[0].status ?? "")"
 
                    cell.btnCancelPolicy.tag = indexPath.row
                    cell.btnCancelPolicy.addTarget(self, action: #selector(clickedCancel(_:)), for: .touchUpInside)
                }
            }
            else
            {
                cell.cancelView.isHidden = true
            }
            
            let timeLocal = utcToLocal(dateStr: dicData.userinsurance[0].createdAt ?? "")
            
            let bidAccepted = dicData.transactionDate ?? ""
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US")
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date1 = formatter.date(from: bidAccepted)
            let Dform = DateFormatter()
            Dform.dateFormat = "dd-MM-yyyy"
            let strDate = Dform.string(from: date1!)
            
            cell.lblPrice.text = strDate
            
            cell.lblTime.text = "\(dicData.currencySymbol ?? "") \(dicData.totalPrice ?? "")"
            
            cell.btnDetalis.tag = indexPath.row
            cell.btnDetalis.addTarget(self, action: #selector(clickedDetail(_:)), for: .touchUpInside)
            var media_link_url = dicData.plans.planImage ?? ""
            media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
            cell.imgPlan.sd_setImage(with: URL.init(string: media_link_url), placeholderImage: UIImage(named: "app_logo"), options: [], completed: nil)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isSelectedTitle == 1
        {
            let dicData = arrMyPolicyCurrent[indexPath.row]
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PolicyDetailViewController") as! PolicyDetailViewController
            vc.strId = dicData.transactionDetailsId ?? 0
            vc.isSelectedTitle = 1
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if isSelectedTitle == 2
        {
            let dicData = arrMyPolicyUpcoming[indexPath.row]
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PolicyDetailViewController") as! PolicyDetailViewController
            vc.strId = dicData.transactionDetailsId ?? 0
            vc.isSelectedTitle = 2
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            let dicData = arrMyPolicyExpired[indexPath.row]
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PolicyDetailViewController") as! PolicyDetailViewController
            vc.strId = dicData.transactionDetailsId ?? 0
            vc.isSelectedTitle = 3
            self.navigationController?.pushViewController(vc, animated: true)
        }
  
    }
    
    func utcToLocal(dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    func timeInterval(timeAgo:String) -> String
    {
        let dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        
        let df = DateFormatter()
        
        df.dateFormat = dateFormat
        let dateWithTime = df.date(from: timeAgo)
        
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateWithTime!, to: Date())
        
        
        if let day = interval.day, day > 0
        {
            
            if day < 7
            {
                if day == 1
                {
                    return "Yesterday"
                }
                else
                {
                    return day == 1 ? "\(day)" + " " + "day ago" : "\(day)" + " " + "days ago"
                }
                
            }
            else
            {
                
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US")
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
                let date1 = formatter.date(from: timeAgo)
                let Dform = DateFormatter()
                Dform.dateFormat = "MMM dd,yyyy"
                let strDate = Dform.string(from: date1!)
                return strDate
                
            }
            
        }
        else if let hour = interval.hour, hour > 0 {
            
            return hour == 1 ? "\(hour)" + " " + "hour ago" : "\(hour)" + " " + "hours ago"
        }
        else if let minute = interval.minute, minute > 0
        {
            return minute == 1 ? "\(minute)" + " " + "minute ago" : "\(minute)" + " " + "minutes ago"
        }
        else if let second = interval.second, second > 0
        {
            return second == 1 ? "\(second)" + " " + "second ago" : "\(second)" + " " + "seconds ago"
        }
        else
        {
            return "a moment ago"
        }
    }
    
    
    @objc func clickedDetail(_ sender: UIButton)
    {
        if isSelectedTitle == 1
        {
            let dicData = arrMyPolicyCurrent[sender.tag]
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PolicyDetailViewController") as! PolicyDetailViewController
            vc.strId = dicData.transactionDetailsId ?? 0
            vc.isSelectedTitle = 1
            if dicData.transectionStatus.count > 0
            {
                if dicData.transectionStatus[0].status ?? "" == "success" {
                    vc.isShowModi = false
                }
                else
                {
                    vc.isShowModi = false
                }
            }
            else
            {
                vc.isShowModi = false
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if isSelectedTitle == 2
        {
            let dicData = arrMyPolicyUpcoming[sender.tag]

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PolicyDetailViewController") as! PolicyDetailViewController
            vc.strId = dicData.transactionDetailsId ?? 0
            vc.isSelectedTitle = 2
            if dicData.transectionStatus.count > 0
            {
                if dicData.transectionStatus[0].status ?? "" == "success" {
                    vc.isShowModi = true
                }
                else
                {
                    vc.isShowModi = false
                }
            }
            else
            {
                vc.isShowModi = false
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            let dicData = arrMyPolicyExpired[sender.tag]
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PolicyDetailViewController") as! PolicyDetailViewController
            vc.strId = dicData.transactionDetailsId ?? 0
            vc.isSelectedTitle = 3
            if dicData.transectionStatus.count > 0
            {
                if dicData.transectionStatus[0].status ?? "" == "success" {
                    vc.isShowModi = false
                }
                else
                {
                    vc.isShowModi = false
                }
            }
            else
            {
                vc.isShowModi = false
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
  
    }
    
    @objc func clickedCancel(_ sender: UIButton)
    {
       
        if isSelectedTitle == 1
        {
            let dicData = arrMyPolicyCurrent[sender.tag]
            
            if dicData.transectionStatus[0].status == "refund" {
                
                self.setUpMakeToast(msg: "If your refund has not been generated yet, it will typically be processed and returned to you within 7-10 business days.")
            } else if dicData.transectionStatus[0].status == "cancel request" {
                
                self.setUpMakeToast(msg: "Your request is currently under review by our administration team. They will carefully evaluate your request and take the necessary actions accordingly")
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CancelPolicyVC") as! CancelPolicyVC
                vc.showImage = 1
                vc.strId = dicData.transectionStatus[0].transactionDetailsId ?? 0
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if isSelectedTitle == 2 {
            let dicData = arrMyPolicyUpcoming[sender.tag]
            
            if dicData.transectionStatus[0].status == "refund" {
                
                self.setUpMakeToast(msg: "If your refund has not been generated yet, it will typically be processed and returned to you within 7-10 business days.")
            } else if dicData.transectionStatus[0].status == "cancel request" {
                
                self.setUpMakeToast(msg: "Your request is currently under review by our administration team. They will carefully evaluate your request and take the necessary actions accordingly")
            } else {
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CancelPolicyVC") as! CancelPolicyVC
                vc.showImage = 2
                vc.strId = dicData.transectionStatus[0].transactionDetailsId ?? 0
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        else
        {
            let dicData = arrMyPolicyExpired[sender.tag]
            
            if dicData.transectionStatus[0].status == "refund" {
                
                self.setUpMakeToast(msg: "If your refund has not been generated yet, it will typically be processed and returned to you within 7-10 business days.")
            } else if dicData.transectionStatus[0].status == "cancel request" {
                
                self.setUpMakeToast(msg: "Your request is currently under review by our administration team. They will carefully evaluate your request and take the necessary actions accordingly")
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CancelPolicyVC") as! CancelPolicyVC
                vc.showImage = 1
                vc.strId = dicData.transectionStatus[0].transactionDetailsId ?? 0
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
  
    }
    
     
    @IBAction func clickedHome(_ sender: Any) {
        if appDelegate?.dicCurrentUserData.roleId == 1
        {
            let mainS = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainS.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(vc, animated: false)
        }
        else
        {
            let mainS = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainS.instantiateViewController(withIdentifier: "HomeAgentViewController") as! HomeAgentViewController
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
    }
    
    @IBAction func clickedProfile(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "ProfileViewController")
        as! ProfileViewController
        self.navigationController?.pushViewController(vc, animated: false)
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
                        self.arrMyPolicyCurrent.removeAll()
                        self.arrMyPolicyExpired.removeAll()
                        self.arrMyPolicyUpcoming.removeAll()
                        
                        let dicResponse = response?.value(forKey: "response") as? NSDictionary
                        
                        if let arrDatacurrent = dicResponse?.value(forKey: "current") as? NSArray
                        {
                            for obj in arrDatacurrent
                            {
                                let dicData = ITPolicyCurrent(fromDictionary: obj as! NSDictionary)
                                self.arrMyPolicyCurrent.append(dicData)
                            }
                        }
                        
                        if let arrDataexpired = dicResponse?.value(forKey: "expired") as? NSArray
                        {
                            for obj in arrDataexpired
                            {
                                let dicData = ITPolicyCurrent(fromDictionary: obj as! NSDictionary)
                                self.arrMyPolicyExpired.append(dicData)
                            }
                        }
                        
                        if let arrDataupcoming = dicResponse?.value(forKey: "upcoming") as? NSArray
                        {
                            for obj in arrDataupcoming
                            {
                                let dicData = ITPolicyCurrent(fromDictionary: obj as! NSDictionary)
                                self.arrMyPolicyUpcoming.append(dicData)
                            }
                        }
                        
                        if self.arrMyPolicyCurrent.count > 0
                        {
                            self.lblNodataFond.isHidden = true
                        }
                        else
                        {
                            self.lblNodataFond.isHidden = false
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

class MyPoliciesTablevViewCell: UITableViewCell {
    
    @IBOutlet weak var imgPlan: UIImageView!
    @IBOutlet weak var lblPlan: UILabel!
    @IBOutlet weak var btnDetalis: UIButton!
    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var btnCancelPolicy: UIButton!
    @IBOutlet weak var lblValidity: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTValidity: UILabel!
    @IBOutlet weak var cancelBGView: UIView!
    @IBOutlet weak var lblPolicy: UILabel!
    
}
