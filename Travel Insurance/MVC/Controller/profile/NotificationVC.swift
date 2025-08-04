//
//  NotificationVC.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 05/02/24.
//

import UIKit

class NotificationVC: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblNoData: UILabel!
    
    var arrNotificationList: [TINotificationListData] = [TINotificationListData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callNotiReafAll()
        
        tblView.delegate = self
        tblView.dataSource = self
        
        callNotificationAPI()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - callNotiReafAll
    func callNotiReafAll()
    {
        APIClient.sharedInstance.showIndicator()
        
        let parm = ["":""]
        
        print(parm)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(NOTIFICATIONS_READALL, parameters: [:]) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200
                {
                    if status == 1 {
                       // self.setUpMakeToast(msg: message ?? "")
                    }
                    else
                    {
                        APIClient.sharedInstance.hideIndicator()
                      //  self.setUpMakeToast(msg: message ?? "")
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
    
    // MARK: - calling API
    
    func callNotificationAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["email":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderGet(NOTIFICATION_LIST, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200
                {
                    if status == 1
                    {
                        if let arrData = response?.value(forKey: "data") as? NSArray
                        {
                            for obj in arrData
                            {
                                let dicData = TINotificationListData(fromDictionary: obj as! NSDictionary)
                                self.arrNotificationList.append(dicData)
                            }
                        }
                        
                        if self.arrNotificationList.count > 0
                        {
                            self.lblNoData.isHidden = true
                            self.tblView.isHidden = false
                        }
                        else
                        {
                            self.lblNoData.isHidden = false
                            self.tblView.isHidden = true
                        }
                        
                        self.tblView.reloadData()
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

extension NotificationVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrNotificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "NotificationListCell") as! NotificationListCell
        
        let dicData = self.arrNotificationList[indexPath.row]
        
        cell.lblTitel.text = dicData.title ?? ""
        cell.lblName.text = dicData.msg ?? ""
        
      //  let timeLocal = utcToLocal(dateStr: dicData.createdAt ?? "")
        
        let timeLocal = convertIraqTimeToIndiaTime(dateString: dicData.createdAt ?? "")
        
        cell.lblTime.text =  timeInterval(timeAgo: timeLocal ?? "")
 
        return cell
    }
    
    func convertIraqTimeToIndiaTime(dateString: String) -> String? {
        // Create a DateFormatter for the input (Iraq time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"  // Adjust the format to match your input date
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Baghdad") // Iraq time zone (AST)
        
        // Convert the input string to a Date object
        guard let dateInIraq = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        // Create a DateFormatter for the output (India time)
        let localFormatter = DateFormatter()
        localFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        localFormatter.timeZone = TimeZone.current  // Local time zone
        
        // Convert the Date object to a string in India time zone
        let localTimeString = localFormatter.string(from: dateInIraq)
        return localTimeString
    }

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40
//    }
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = Bundle.main.loadNibNamed("headerView", owner: self, options: [:])?.first as! headerView
//        
//        headerView.lblPerson.text = "Today"
//        headerView.lblPerson.font = UIFont(name: "Poppins-Regular", size: 12)
//        
//        return headerView
//    }
//    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0.5
//    }
    
    func utcToLocal(dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    func timeInterval(timeAgo:String) -> String
    {
        let dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let df = DateFormatter()
        
        df.dateFormat = dateFormat
        let dateWithTime = df.date(from: timeAgo)!.toLocalTime()
        
        let currentUTCDate = Date()

        // Step 2: Define the time zone for India (Asia/Kolkata)
        let indiaTimeZone = TimeZone(identifier: "Asia/Kolkata")!

        // Step 3: Create a date formatter to convert the date
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = indiaTimeZone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        // Convert UTC date to India time zone string
        let indiaTime = dateFormatter.string(from: currentUTCDate)
        let dateWithTime77 = dateFormatter.date(from: indiaTime)!.toLocalTime()
 
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateWithTime, to: dateWithTime77)
        
        
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
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
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
}

class NotificationListCell: UITableViewCell
{
    
    @IBOutlet weak var lblTitel: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
}


extension String {
    
    //MARK:- Convert UTC To Local Date by passing date formats value
    func UTCToLocal(incomingFormat: String, outGoingFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = outGoingFormat
        
        return dateFormatter.string(from: dt ?? Date())
    }
    
    //MARK:- Convert Local To UTC Date by passing date formats value
    func localToUTC(incomingFormat: String, outGoingFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = outGoingFormat
        
        return dateFormatter.string(from: dt ?? Date())
    }
}

extension Date {

    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }

    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        
        // 1) Get the current TimeZone's seconds from GMT. Since I am in Chicago this will be: 60*60*5 (18000)
        let timezoneOffset = TimeZone.current.secondsFromGMT()
        
        // 2) Get the current date (GMT) in seconds since 1970. Epoch datetime.
        let epochDate = self.timeIntervalSince1970
        
        // 3) Perform a calculation with timezoneOffset + epochDate to get the total seconds for the
        //    local date since 1970.
        //    This may look a bit strange, but since timezoneOffset is given as -18000.0, adding epochDate and timezoneOffset
        //    calculates correctly.
        let timezoneEpochOffset = (epochDate + Double(timezoneOffset))
        
        
        // 4) Finally, create a date using the seconds offset since 1970 for the local date.
        return Date(timeIntervalSince1970: timezoneEpochOffset)
    }

}
