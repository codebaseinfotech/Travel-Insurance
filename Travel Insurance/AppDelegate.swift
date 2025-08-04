//
//  AppDelegate.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 25/10/23.
//
// https://github.com/kindredgroup/OPPWAMobile
//com.wayak.travelinsurance
import UIKit
import IQKeyboardManagerSwift
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    var dicCurrentUserData = TIUserLoginResponse()
    
    var isBackForm = false
    
    var strSelectedPermissionPurchase = "0"
    
    var objContryCodeConversionRate = ContryCodeConversionRate()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        IQKeyboardManager.shared.enable = true
        
        setupPush()
 
        try? isUpdateAvailable {[self] (update, error) in
            if let error = error {
                print(error)
            } else if update ?? false {
                // show alert
                
                DispatchQueue.main.async {
                    let alertMessage = "An update to the app is required to continue.\nPlease go to the app store and upgrade your application."
                    
                    let alertController = UIAlertController(title: "You have new updates", message: alertMessage, preferredStyle: .alert)
                    
                    let updateButton = UIAlertAction(title: "Update App", style: .default) { (action:UIAlertAction) in
                        guard let url = URL(string: "https://itunes.apple.com/app/id6695731771") else {
                            return
                        }
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(url)
                        }
                    }
                    
                    alertController.addAction(updateButton)
                    self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
                
                
            }
        }
        
        
        if let isGetStarted = UserDefaults.standard.value(forKey: "isGetStarted") as? Bool
        {
            if isGetStarted == true
            {
                
                if let isUserLogin = UserDefaults.standard.value(forKey: "isUserLogin") as? Bool
                {
                    if isUserLogin == true
                    {
                        dicCurrentUserData = getCurrentUserData()
                        
                        setUpHomeVehicle()
                       
                    }
                    else
                    {
                        setUpLogin()
                    }
                }
                else
                {
                    setUpLogin()
                }
                
            }
            else
            {
                let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let home: OnboardingVC = mainStoryboard.instantiateViewController(withIdentifier: "OnboardingVC") as! OnboardingVC
                let OnboardingNavigation = UINavigationController(rootViewController: home)
                OnboardingNavigation.navigationBar.isHidden = true
                self.window?.rootViewController = OnboardingNavigation
                self.window?.makeKeyAndVisible()
            }
            
            
        }
        else
        {
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let home: OnboardingVC = mainStoryboard.instantiateViewController(withIdentifier: "OnboardingVC") as! OnboardingVC
            let OnboardingNavigation = UINavigationController(rootViewController: home)
            OnboardingNavigation.navigationBar.isHidden = true
            self.window?.rootViewController = OnboardingNavigation
            self.window?.makeKeyAndVisible()
        }        
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Make sure that URL scheme is identical to the registered one
        if url.scheme?.localizedCaseInsensitiveCompare("msdk.demo.async") == .orderedSame {
            // Send notification to handle result in the view controller.
            NotificationCenter.default.post(name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
            return true
        }
        return false
    }
    
    func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
        if (extensionPointIdentifier == UIApplication.ExtensionPointIdentifier.keyboard) {
            return false
        }
        return true
    }
    
    func setupPush()
    {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            // Handle user allowing / declining notification permission. Example:
            if (granted) {
                DispatchQueue.main.async(execute: {
                    UIApplication.shared.registerForRemoteNotifications()
                })
            } else {
                print("User declined notification permissions")
            }
        }
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            // UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        
        if #available(iOS 10.0, *) {
            
            let center = UNUserNotificationCenter.current()
            center.delegate  = self
            center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                if (granted)
                {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                    
                }
            }
        }
        else{
            
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
            
        }
        
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        print("Firebase registration token: \(fcmToken ?? "")")
        UserDefaults.standard.set(fcmToken, forKey: "FirebaseToken")
        UserDefaults.standard.synchronize()
        
        let dataDict:[String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        
        if #available(iOS 14.0, *) {
            completionHandler([.list, .banner, .sound])
        } else {
            completionHandler([.alert])
        }
        
        UserDefaults.standard.set(true, forKey: "isNewNoti")
        UserDefaults.standard.synchronize()
        
    }
    
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
        try? isUpdateAvailable {[self] (update, error) in
            if let error = error {
                print(error)
            } else if update ?? false {
                // show alert
                
                DispatchQueue.main.async {
                    let alertMessage = "An update to the app is required to continue.\nPlease go to the app store and upgrade your application."
                    
                    let alertController = UIAlertController(title: "You have new updates", message: alertMessage, preferredStyle: .alert)
                    
                    let updateButton = UIAlertAction(title: "Update App", style: .default) { (action:UIAlertAction) in
                        guard let url = URL(string: "https://itunes.apple.com/app/id6695731771") else {
                            return
                        }
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(url)
                        }
                    }
                    
                    alertController.addAction(updateButton)
                    self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
                
                
            }
        }
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        Messaging.messaging().apnsToken = deviceToken as Data
        Messaging.messaging().delegate = self
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = token {
                print("Remote instance ID token: \(result)")
                
                UserDefaults.standard.set(result, forKey: "FirebaseToken")
                UserDefaults.standard.synchronize()
            }
        }
        
        Messaging.messaging().subscribe(toTopic: "all") { error in
            if let error = error {
                print("Error subscribing to topic: \(error.localizedDescription)")
            } else {
                print("Subscribed to topic successfully.")
            }
        }
        
        Messaging.messaging().subscribe(toTopic: "ios") { error in
            if let error = error {
                print("Error subscribing to topic: \(error.localizedDescription)")
            } else {
                print("Subscribed to topic successfully.")
            }
        }
        
        
        //  self.pushNotifications.registerDeviceToken(deviceToken as Data)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }
    
    func setUpHomeCustomer()
    {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let home: HomeViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let homeNavigation = UINavigationController(rootViewController: home)
        homeNavigation.navigationBar.isHidden = true
        self.window?.rootViewController = homeNavigation
        self.window?.makeKeyAndVisible()
    }
    
    func setUpHomeAgent()
    {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let home: HomeAgentViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeAgentViewController") as! HomeAgentViewController
        let homeNavigation = UINavigationController(rootViewController: home)
        homeNavigation.navigationBar.isHidden = true
        self.window?.rootViewController = homeNavigation
        self.window?.makeKeyAndVisible()
    }
    
    func setUpHomeVehicle()
    {
        let home = VehicleHomeVC.instantiate("Vehicle") as! VehicleHomeVC
        //let home = VIProcess5VC.instantiate("Vehicle") as! VIProcess5VC
        let homeNavigation = UINavigationController(rootViewController: home)
        homeNavigation.navigationBar.isHidden = true
        self.window?.rootViewController = homeNavigation
        self.window?.makeKeyAndVisible()
    }
    
    func setUpLogin()
    {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let home: LoginViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let homeNavigation = UINavigationController(rootViewController: home)
        homeNavigation.navigationBar.isHidden = true
        self.window?.rootViewController = homeNavigation
        self.window?.makeKeyAndVisible()
    }
    
    func saveCurrentUserData(dic: TIUserLoginResponse)
    {
        let data = NSKeyedArchiver.archivedData(withRootObject: dic)
        UserDefaults.standard.setValue(data, forKey: "currentUserDataTI")
        UserDefaults.standard.synchronize()
    }
    
    func getCurrentUserData() -> TIUserLoginResponse
    {
        if let data = UserDefaults.standard.object(forKey: "currentUserDataTI"){
            
            let arrayObjc = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
            return arrayObjc as! TIUserLoginResponse
        }
        return TIUserLoginResponse()
        
    }
    
}


extension UIImageView
{
    //Rotate button 180 degree
    func rotate180()
    {
        //  UIView.animate(withDuration: 0.3) {
        self.transform = CGAffineTransform(rotationAngle: .pi)
        // }
    }
    
    //Back to normal state again
    
    func rotateBack()
    {
        //  UIView.animate(withDuration: 0.3) {
        self.transform = CGAffineTransform.identity
        //  }
    }
    
}

enum VersionError: Error {
    case invalidResponse, invalidBundleInfo
}

@discardableResult
func isUpdateAvailable(completion: @escaping (Bool?, Error?) -> Void) throws -> URLSessionDataTask {
    guard let info = Bundle.main.infoDictionary,
          let currentVersion = info["CFBundleShortVersionString"] as? String,
          let identifier = info["CFBundleIdentifier"] as? String,
          let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
        throw VersionError.invalidBundleInfo
    }
    
    let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData)
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        do {
            if let error = error { throw error }
            
            guard let data = data else { throw VersionError.invalidResponse }
            
            let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
            
            guard let result = (json?["results"] as? [Any])?.first as? [String: Any], let lastVersion = result["version"] as? String else {
                throw VersionError.invalidResponse
            }
            completion(lastVersion > currentVersion, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    task.resume()
    return task
}

