//
//  VehicleMyInsuranceVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 05/06/25.
//

import UIKit

class VehicleMyInsuranceVC: UIViewController {

    @IBOutlet weak var lblMyInsurance: UILabel!
    @IBOutlet weak var lblClaimInsurance: UILabel!
    
    @IBOutlet weak var viewBMyInsurance: RoundedCornerView!
    @IBOutlet weak var viewBClaimInsurance: RoundedCornerView!
    
    @IBOutlet weak var viewCurrentTop: UIView!
    @IBOutlet weak var viewUpcommingTop: UIView!
    @IBOutlet weak var viewExpiredTop: UIView!
    
    @IBOutlet weak var lblCurrentTitle: UILabel!
    @IBOutlet weak var lblUpcommingTitle: UILabel!
    @IBOutlet weak var lblExpiredTitle: UILabel!
    @IBOutlet weak var viewTabbar: UIView!
    
    @IBOutlet weak var tblViewCurrentVehicle: UITableView! {
        didSet {
            tblViewCurrentVehicle.showsVerticalScrollIndicator = false
            tblViewCurrentVehicle.showsHorizontalScrollIndicator = false

            tblViewCurrentVehicle.isHidden = false
            tblViewCurrentVehicle.register(UINib(nibName: "VehicleInsuranceTblViewCell", bundle: nil), forCellReuseIdentifier: "VehicleInsuranceTblViewCell")
            tblViewCurrentVehicle.register(UINib(nibName: "TravelInsuranceTblViewCell", bundle: nil), forCellReuseIdentifier: "TravelInsuranceTblViewCell")
            
            tblViewCurrentVehicle.delegate = self
            tblViewCurrentVehicle.dataSource = self
        }
    }
    @IBOutlet weak var tblViewUpcommingVehicle: UITableView! {
        didSet {
            tblViewUpcommingVehicle.showsVerticalScrollIndicator = false
            tblViewUpcommingVehicle.showsHorizontalScrollIndicator = false

            tblViewUpcommingVehicle.isHidden = true
            
            tblViewUpcommingVehicle.register(UINib(nibName: "VehicleInsuranceTblViewCell", bundle: nil), forCellReuseIdentifier: "VehicleInsuranceTblViewCell")
            tblViewUpcommingVehicle.register(UINib(nibName: "TravelInsuranceTblViewCell", bundle: nil), forCellReuseIdentifier: "TravelInsuranceTblViewCell")
            
            tblViewUpcommingVehicle.delegate = self
            tblViewUpcommingVehicle.dataSource = self

        }
    }
    @IBOutlet weak var tblViewExpiredVehicle: UITableView! {
        didSet {
            tblViewExpiredVehicle.showsVerticalScrollIndicator = false
            tblViewExpiredVehicle.showsHorizontalScrollIndicator = false

            tblViewExpiredVehicle.isHidden = true
            
            tblViewExpiredVehicle.register(UINib(nibName: "VehicleInsuranceTblViewCell", bundle: nil), forCellReuseIdentifier: "VehicleInsuranceTblViewCell")
            tblViewExpiredVehicle.register(UINib(nibName: "TravelInsuranceTblViewCell", bundle: nil), forCellReuseIdentifier: "TravelInsuranceTblViewCell")
            
            tblViewExpiredVehicle.delegate = self
            tblViewExpiredVehicle.dataSource = self

        }
    }
    @IBOutlet weak var tblViewClaims: UITableView! {
        didSet {
            tblViewClaims.showsVerticalScrollIndicator = false
            tblViewClaims.showsHorizontalScrollIndicator = false
            
            tblViewClaims.register(UINib(nibName: "VehicleInsuranceTblViewCell", bundle: nil), forCellReuseIdentifier: "VehicleInsuranceTblViewCell")
            tblViewClaims.register(UINib(nibName: "TravelInsuranceTblViewCell", bundle: nil), forCellReuseIdentifier: "TravelInsuranceTblViewCell")
            
            tblViewClaims.delegate = self
            tblViewClaims.dataSource = self

        }
    }
    
    @IBOutlet weak var viewMainInsurance: UIView!
    @IBOutlet weak var viewMainClaim: UIView!
    
    var dicMyVehicleInsurance = TIMyVehicleInsuranceResponse()
    var isAPICall = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callMyInsuranceAPI()
        viewTabbar.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07), alpha: 1, x: 0, y: 0, blur: 6, spread: 0)

        lblMyInsurance.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        lblClaimInsurance.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        lblMyInsurance.textColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
        lblClaimInsurance.textColor = #colorLiteral(red: 0.4196078431, green: 0.4470588235, blue: 0.5019607843, alpha: 1)
        
        viewBMyInsurance.isHidden = false
        viewBClaimInsurance.isHidden = true
        
        viewMainInsurance.isHidden = false
        viewMainClaim.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnMyInsuranceAction(_ sender: Any) {
        lblMyInsurance.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        lblClaimInsurance.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        lblMyInsurance.textColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
        lblClaimInsurance.textColor = #colorLiteral(red: 0.4196078431, green: 0.4470588235, blue: 0.5019607843, alpha: 1)
        
        viewBMyInsurance.isHidden = false
        viewBClaimInsurance.isHidden = true
        
        viewMainInsurance.isHidden = false
        viewMainClaim.isHidden = true
    }
    @IBAction func btnClaimInsuranceAction(_ sender: Any) {
        lblClaimInsurance.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        lblMyInsurance.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        lblClaimInsurance.textColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
        lblMyInsurance.textColor = #colorLiteral(red: 0.4196078431, green: 0.4470588235, blue: 0.5019607843, alpha: 1)
        
        viewBClaimInsurance.isHidden = false
        viewBMyInsurance.isHidden = true
        
        viewMainClaim.isHidden = false
        viewMainInsurance.isHidden = true
    }
    
    @IBAction func btnCurrentVehicleAction(_ sender: Any) {
        viewCurrentTop.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.1137254902, blue: 0.137254902, alpha: 1)
        viewUpcommingTop.backgroundColor = UIColor(hexString: "#F2EEEE").withAlphaComponent(0.72)
        viewExpiredTop.backgroundColor = UIColor(hexString: "#F2EEEE").withAlphaComponent(0.72)
        
        lblCurrentTitle.textColor = .white
        lblUpcommingTitle.textColor = .black
        lblExpiredTitle.textColor = .black
        
        tblViewCurrentVehicle.isHidden = false
        tblViewUpcommingVehicle.isHidden = true
        tblViewExpiredVehicle.isHidden = true
    }
    @IBAction func btnUpcommingAction(_ sender: Any) {
        viewUpcommingTop.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.1137254902, blue: 0.137254902, alpha: 1)
        viewCurrentTop.backgroundColor = UIColor(hexString: "#F2EEEE").withAlphaComponent(0.72)
        viewExpiredTop.backgroundColor = UIColor(hexString: "#F2EEEE").withAlphaComponent(0.72)
        
        lblUpcommingTitle.textColor = .white
        lblCurrentTitle.textColor = .black
        lblExpiredTitle.textColor = .black
        
        tblViewUpcommingVehicle.isHidden = false
        tblViewCurrentVehicle.isHidden = true
        tblViewExpiredVehicle.isHidden = true
    }
    @IBAction func btnExpiredAction(_ sender: Any) {
        viewExpiredTop.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.1137254902, blue: 0.137254902, alpha: 1)
        viewUpcommingTop.backgroundColor = UIColor(hexString: "#F2EEEE").withAlphaComponent(0.72)
        viewCurrentTop.backgroundColor = UIColor(hexString: "#F2EEEE").withAlphaComponent(0.72)
        
        lblExpiredTitle.textColor = .white
        lblUpcommingTitle.textColor = .black
        lblCurrentTitle.textColor = .black
        
        tblViewExpiredVehicle.isHidden = false
        tblViewUpcommingVehicle.isHidden = true
        tblViewCurrentVehicle.isHidden = true
    }
    
    
    @IBAction func btnTHomeAction(_ sender: Any) {
        let vc = VehicleHomeVC.instantiate("Vehicle") as! VehicleHomeVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func btnTProfileActio(_ sender: Any) {
        let vc = VIMyProfileVC.instantiate("Vehicle") as! VIMyProfileVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    // MARK: - calling API
    func callMyInsuranceAPI() {
        APIClient.sharedInstance.showIndicator()
        
        let parm = ["":""]
        
        print(parm)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(MY_VEHICLE_INSURANCE, parameters: [:]) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                let NotificationCOunt = response?.value(forKey: "NotificationCOunt") as? Int

                if statusCode == 200
                {
                    if status == 200 {
                        if let dicResponse = response?.value(forKey: "response") as? NSDictionary {
                            let newResponse = TIMyVehicleInsuranceResponse(fromDictionary: dicResponse)
                            self.dicMyVehicleInsurance = newResponse
                        }
                        self.isAPICall = true
                        self.tblViewClaims.reloadData()
                        self.tblViewCurrentVehicle.reloadData()
                        self.tblViewUpcommingVehicle.reloadData()
                        self.tblViewExpiredVehicle.reloadData()
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

// MARK: - tblView Delegate & DataSource
extension VehicleMyInsuranceVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tblViewCurrentVehicle {
            return 2
        } else if tableView == tblViewUpcommingVehicle {
            return 2
        } else if tableView == tblViewExpiredVehicle {
            return 2
        }
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isAPICall == true {
            if tableView == tblViewCurrentVehicle {
                return section == 0 ? dicMyVehicleInsurance.vehicleInsurance.current.count : dicMyVehicleInsurance.userOrder.current.count
            } else if tableView == tblViewUpcommingVehicle {
                return section == 0 ? dicMyVehicleInsurance.vehicleInsurance.upcoming.count : dicMyVehicleInsurance.userOrder.upcoming.count
            } else if tableView == tblViewExpiredVehicle {
                return section == 0 ? dicMyVehicleInsurance.vehicleInsurance.expired.count : dicMyVehicleInsurance.userOrder.expired.count
            } else if tableView == tblViewClaims {
                return dicMyVehicleInsurance.vehicleClaim.vehicle.count
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblViewCurrentVehicle {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "VehicleInsuranceTblViewCell") as! VehicleInsuranceTblViewCell
                
                let dicData = dicMyVehicleInsurance.vehicleInsurance.current[indexPath.row]
                
                if dicData.vehiclePlanId == 1 {
                    cell.viewBikeDetials.isHidden = false
                    cell.viewCarDetails.isHidden = true
                } else {
                    cell.viewBikeDetials.isHidden = true
                    cell.viewCarDetails.isHidden = false
                }
                
                cell.lblCarName.text = "\(dicData.vehicleModel ?? "") (\(dicData.engineSize ?? "") cc)"
                cell.lblBikeName.text = "\(dicData.vehicleModel ?? "") (\(dicData.engineSize ?? "") cc)"
                
                cell.lblCarNumber.text = "\(dicData.vehicleNo ?? "") | \(dicData.modelYear ?? "") registered"
                cell.lblBikeNumber.text = "\(dicData.vehicleNo ?? "") | \(dicData.modelYear ?? "") registered"
                
                cell.lblPolicyPrice.text = "IQD \(dicData.totalPremium ?? "")/ year"
                
                if dicData.vehicleInsuranceOptionalAddOn.count > 0 {
                    cell.arrAddons = dicData.vehicleInsuranceOptionalAddOn
                    cell.tblviewAddOnss.reloadData()
                }
                
                cell.tapOnCancelPolicy = {
                    let vc = VICancelPolicyVC.instantiate("Vehicle") as! VICancelPolicyVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TravelInsuranceTblViewCell") as! TravelInsuranceTblViewCell
                
                let dicData = dicMyVehicleInsurance.userOrder.current[indexPath.row]

                
                cell.lblName.text = "\(dicData.plans.planType ?? "")"
                
                cell.lblVlidity.text = "\(dicData.timePeriod ?? "") days"
                
                
                cell.lblPrice.text = "\(dicData.currencySymbol ?? "") \(dicData.totalPrice ?? "")"
                
                let bidAccepted = dicData.transactionDate ?? ""
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US")
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date1 = formatter.date(from: bidAccepted)
                let Dform = DateFormatter()
                Dform.dateFormat = "dd-MM-yyyy"
                let strDate = Dform.string(from: date1!)
                
                cell.lblStared.text = "Started on: " + strDate
                
                var media_link_url = dicData.plans.planImage ?? ""
                media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                cell.imgPolicy.sd_setImage(with: URL.init(string: media_link_url), placeholderImage: UIImage(named: "app_logo"), options: [], completed: nil)
                
                return cell
            }
            
        } else if tableView == tblViewUpcommingVehicle {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "VehicleInsuranceTblViewCell") as! VehicleInsuranceTblViewCell
                
                let dicData = dicMyVehicleInsurance.vehicleInsurance.upcoming[indexPath.row]
                
                if dicData.vehiclePlanId == 1 {
                    cell.viewBikeDetials.isHidden = false
                    cell.viewCarDetails.isHidden = true
                } else {
                    cell.viewBikeDetials.isHidden = true
                    cell.viewCarDetails.isHidden = false
                }
                
                cell.lblCarName.text = "\(dicData.vehicleModel ?? "") (\(dicData.engineSize ?? "") cc)"
                cell.lblBikeName.text = "\(dicData.vehicleModel ?? "") (\(dicData.engineSize ?? "") cc)"
                
                cell.lblCarNumber.text = "\(dicData.vehicleNo ?? "") | \(dicData.modelYear ?? "") registered"
                cell.lblBikeNumber.text = "\(dicData.vehicleNo ?? "") | \(dicData.modelYear ?? "") registered"
                
                cell.lblPolicyPrice.text = "IQD \(dicData.totalPremium ?? "")/ year"
                
                if dicData.vehicleInsuranceOptionalAddOn.count > 0 {
                    cell.arrAddons = dicData.vehicleInsuranceOptionalAddOn
                    cell.tblviewAddOnss.reloadData()
                }
                
                cell.tapOnCancelPolicy = {
                    let vc = VICancelPolicyVC.instantiate("Vehicle") as! VICancelPolicyVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TravelInsuranceTblViewCell") as! TravelInsuranceTblViewCell
                
                let dicData = dicMyVehicleInsurance.userOrder.current[indexPath.row]

                
                cell.lblName.text = "\(dicData.plans.planType ?? "")"
                
                cell.lblVlidity.text = "\(dicData.timePeriod ?? "") days"
                
                
                cell.lblPrice.text = "\(dicData.currencySymbol ?? "") \(dicData.totalPrice ?? "")"
                
                let bidAccepted = dicData.transactionDate ?? ""
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US")
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date1 = formatter.date(from: bidAccepted)
                let Dform = DateFormatter()
                Dform.dateFormat = "dd-MM-yyyy"
                let strDate = Dform.string(from: date1!)
                
                cell.lblStared.text = "Started on: " + strDate
                
                var media_link_url = dicData.plans.planImage ?? ""
                media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                cell.imgPolicy.sd_setImage(with: URL.init(string: media_link_url), placeholderImage: UIImage(named: "app_logo"), options: [], completed: nil)
                
                return cell
            }
            
        } else if tableView == tblViewExpiredVehicle {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "VehicleInsuranceTblViewCell") as! VehicleInsuranceTblViewCell
                
                let dicData = dicMyVehicleInsurance.vehicleInsurance.upcoming[indexPath.row]
                
                if dicData.vehiclePlanId == 1 {
                    cell.viewBikeDetials.isHidden = false
                    cell.viewCarDetails.isHidden = true
                } else {
                    cell.viewBikeDetials.isHidden = true
                    cell.viewCarDetails.isHidden = false
                }
                
                cell.lblCarName.text = "\(dicData.vehicleModel ?? "") (\(dicData.engineSize ?? "") cc)"
                cell.lblBikeName.text = "\(dicData.vehicleModel ?? "") (\(dicData.engineSize ?? "") cc)"
                
                cell.lblCarNumber.text = "\(dicData.vehicleNo ?? "") | \(dicData.modelYear ?? "") registered"
                cell.lblBikeNumber.text = "\(dicData.vehicleNo ?? "") | \(dicData.modelYear ?? "") registered"
                
                cell.lblPolicyPrice.text = "IQD \(dicData.totalPremium ?? "")/ year"
                
                if dicData.vehicleInsuranceOptionalAddOn.count > 0 {
                    cell.arrAddons = dicData.vehicleInsuranceOptionalAddOn
                    cell.tblviewAddOnss.reloadData()
                }
                
                cell.tapOnCancelPolicy = {
                    let vc = VICancelPolicyVC.instantiate("Vehicle") as! VICancelPolicyVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TravelInsuranceTblViewCell") as! TravelInsuranceTblViewCell
                
                let dicData = dicMyVehicleInsurance.userOrder.expired[indexPath.row]

                cell.lblName.text = "\(dicData.plans.planType ?? "")"
                
                cell.lblVlidity.text = "\(dicData.timePeriod ?? "") days"
                
                cell.lblPrice.text = "\(dicData.currencySymbol ?? "") \(dicData.totalPrice ?? "")"
                
                let bidAccepted = dicData.transactionDate ?? ""
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US")
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date1 = formatter.date(from: bidAccepted)
                let Dform = DateFormatter()
                Dform.dateFormat = "dd-MM-yyyy"
                let strDate = Dform.string(from: date1!)
                
                cell.lblStared.text = "Started on: " + strDate
                
                var media_link_url = dicData.plans.planImage ?? ""
                media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
                cell.imgPolicy.sd_setImage(with: URL.init(string: media_link_url), placeholderImage: UIImage(named: "app_logo"), options: [], completed: nil)
                
                return cell
            }
            
        } else if tableView == tblViewClaims {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VehicleInsuranceTblViewCell") as! VehicleInsuranceTblViewCell
            
            cell.tapOnClaimTrack = {
                let vc = VITrackClaimRequestVC.instantiate("Vehicle") as! VITrackClaimRequestVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            cell.tapOnCancelPolicy = {
                let vc = VICancelPolicyVC.instantiate("Vehicle") as! VICancelPolicyVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            cell.viewMainClaim.isHidden = false
            cell.heightClaimCon.constant = 26
            cell.topClaimCon.constant = 10
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblViewCurrentVehicle {
            let dicData = dicMyVehicleInsurance.vehicleInsurance.current[indexPath.row]

            let vc = VIPolicyDetailsVC.instantiate("Vehicle") as! VIPolicyDetailsVC
            vc.planId = dicData.id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        } else if tableView == tblViewUpcommingVehicle {
            let dicData = dicMyVehicleInsurance.vehicleInsurance.upcoming[indexPath.row]

            let vc = VIPolicyDetailsVC.instantiate("Vehicle") as! VIPolicyDetailsVC
            vc.planId = dicData.id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        } else if tableView == tblViewExpiredVehicle {
            let dicData = dicMyVehicleInsurance.vehicleInsurance.expired[indexPath.row]

            let vc = VIPolicyDetailsVC.instantiate("Vehicle") as! VIPolicyDetailsVC
            vc.planId = dicData.id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        } else if tableView == tblViewClaims {
            
            let vc = VIPolicyDetailsVC.instantiate("Vehicle") as! VIPolicyDetailsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
