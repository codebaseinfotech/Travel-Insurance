//
//  APIClient.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 12/01/24.
//

import Foundation
import Alamofire
import SVProgressHUD
import UIKit

class APIClient: NSObject {
    
    var almofireManager = Alamofire.Session.default
    
    class var sharedInstance: APIClient {
        
        struct Static {
            static let instance: APIClient = APIClient()
        }
        return Static.instance
    }
    
    var responseData: NSMutableData!
    
    func showLogoutAlert(completion:@escaping ((_ tapped:Bool)->Void))
    {
        
    }
    
    func MakeAPICallWithOutAuthHeaderPost(_ url: String, parameters: [String: Any], completionHandler:@escaping (NSDictionary?, Error?, Int?) -> Void) {
        
        print("url = \(BASE_URL + url)")
        print(parameters)
        
        if NetConnection.isConnectedToNetwork() == true
        {
            
            AF.request(BASE_URL + url, method: .post, parameters: parameters, encoding: URLEncoding(destination: .methodDependent), headers: nil).responseJSON { response in
                
                switch(response.result) {
                    
                case .success:
                    if response.data != nil
                    {
                        if let responseDict = ((response.value as AnyObject) as? NSDictionary) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                    
                case .failure:
                    print(response.error!)
                    print("Http Status Code: \(String(describing: response.response?.statusCode))")
                    completionHandler(nil, response.error, response.response?.statusCode )
                }
            }
        }
        else
        {
            print("No Network Found!")
            showLogoutAlert { (true) in
                
            }
            // pushNetworkErrorVC()
            SVProgressHUD.dismiss()
        }
    }
    
    
    func MakeAPICallWithAuthHeaderPost(_ url: String, parameters: [String: Any], completionHandler:@escaping (NSDictionary?, Error?, Int?) -> Void) {
        
        print("url = \(BASE_URL + url)")
        
        if NetConnection.isConnectedToNetwork() == true
        {
            let token = UserDefaults.standard.value(forKey: "token") as? String
            
            let headers: HTTPHeaders = ["Authorization": "Bearer \(token ?? "")"]
            
            let rawString = BASE_URL + url
            
            let cleanedString = rawString.trimmingCharacters(in: .whitespacesAndNewlines)
                .components(separatedBy: .controlCharacters).joined()
            
            AF.request(cleanedString, method:.post, parameters: parameters,encoding: URLEncoding(destination: .methodDependent), headers: headers) .responseJSON { (response) in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? NSDictionary) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                    
                case .failure:
                    print(response.error!)
                    print("Http Status Code: \(String(describing: response.response?.statusCode))")
                    completionHandler(nil, response.error, response.response?.statusCode )
                }
            }
        }
        else
        {
            print("No Network Found!")
            SVProgressHUD.dismiss()
        }
    }
    
    
    func MakeAPICallWithAuthHeaderPostPaymentGetway(_ url: String, parameters: [String: Any], completionHandler:@escaping (NSDictionary?, Error?, Int?) -> Void) {
        
        print("url = \(url)")
        
        if NetConnection.isConnectedToNetwork() == true
        {
            let token = UserDefaults.standard.value(forKey: "token") as? String
            
            let headers: HTTPHeaders = ["Authorization": "Bearer \(PAYMENT_TOKEN)"]
            
            AF.request("\(PAYMENT_URL)/v1/checkouts", method:.post, parameters: parameters,encoding: URLEncoding(destination: .methodDependent), headers: headers) .responseJSON { (response) in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? NSDictionary) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                    
                case .failure:
                    print(response.error!)
                    print("Http Status Code: \(String(describing: response.response?.statusCode))")
                    completionHandler(nil, response.error, response.response?.statusCode )
                }
            }
        }
        else
        {
            print("No Network Found!")
            SVProgressHUD.dismiss()
        }
    }
    
    func MakeAPICallWithAuthOutHeaderPostArray(_ url: String, parameters: [String: Any], completionHandler:@escaping (NSArray?, Error?, Int?) -> Void) {
        
        print("url = \(BASE_URL + url)")
        
        if NetConnection.isConnectedToNetwork() == true
        {
            
            AF.request(BASE_URL + url, method:.post, parameters: parameters,encoding: URLEncoding(destination: .methodDependent), headers: [:]) .responseJSON { (response) in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? NSArray) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                    
                case .failure:
                    print(response.error!)
                    print("Http Status Code: \(String(describing: response.response?.statusCode))")
                    completionHandler(nil, response.error, response.response?.statusCode )
                }
            }
        }
        else
        {
            print("No Network Found!")
            SVProgressHUD.dismiss()
        }
    }
    
    func MakeAPICallWithoutAuthHeaderGet(_ url: String, parameters: [String: Any], completionHandler:@escaping (NSDictionary?, Error?, Int?) -> Void) {
        
        print("url = \(BASE_URL + url)")
        
        if NetConnection.isConnectedToNetwork() == true
        {
            AF.request(BASE_URL + url, method: .get, encoding: URLEncoding(destination: .methodDependent), headers: [:]).responseJSON { response in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? NSDictionary) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                case .failure:
                    print(response.error!)
                    completionHandler(nil, response.error, response.response?.statusCode)
                }
            }
        }
        else
        {
            print("No Network Found!")
            showLogoutAlert { (true) in
                
            }
            //pushNetworkErrorVC()
            SVProgressHUD.dismiss()
        }
    }
    
    
    
    func MakeAPICallWithAuthHeaderGetCheckOut(_ url: String, parameters: [String: Any], completionHandler:@escaping (NSDictionary?, Error?, Int?) -> Void) {
        
        print("url = \("\(PAYMENT_URL)/v1/checkouts?amount=1000&currency=EUR&paymentType=DB")")
        
        if NetConnection.isConnectedToNetwork() == true
        {
            let token = UserDefaults.standard.value(forKey: "token") as? String

            let headers: HTTPHeaders = ["Authorization": "Bearer \(PAYMENT_TOKEN)"]
            
            AF.request("\(PAYMENT_URL)/v1/checkouts", method:.post, parameters: parameters,encoding: URLEncoding(destination: .methodDependent), headers: headers) .responseJSON { (response) in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? NSDictionary) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                    
                case .failure:
                    print(response.error!)
                    print("Http Status Code: \(String(describing: response.response?.statusCode))")
                    completionHandler(nil, response.error, response.response?.statusCode )
                }
            }
        }
        else
        {
            print("No Network Found!")
            SVProgressHUD.dismiss()
        }
    }
    
    func MakeAPICallWithAuthHeaderGet(_ url: String, parameters: [String: Any], completionHandler:@escaping (NSDictionary?, Error?, Int?) -> Void) {
        
        if NetConnection.isConnectedToNetwork() == true
        {
            let token = UserDefaults.standard.value(forKey: "token") as? String
            
            let headers: HTTPHeaders = ["Authorization": "Bearer \(token ?? "")"]
            
            print("url = \(BASE_URL + url)\nheaders = \(headers)")
            
            AF.request(BASE_URL + url, method:.get, parameters: parameters,encoding: URLEncoding(destination: .methodDependent), headers: headers) .responseJSON { (response) in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? NSDictionary) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                    
                case .failure:
                    print(response.error!)
                    print("Http Status Code: \(String(describing: response.response?.statusCode))")
                    completionHandler(nil, response.error, response.response?.statusCode )
                }
            }
        }
        else
        {
            print("No Network Found!")
            SVProgressHUD.dismiss()
        }
    }
    
    func MakeAPICallWithoutAuthHeaderBaseGet(_ url: String, parameters: [String: Any], completionHandler:@escaping (NSArray?, Error?, Int?) -> Void) {
        
        print("url = \(url)")
        
        if NetConnection.isConnectedToNetwork() == true
        {
            AF.request(url, method: .get, encoding: URLEncoding(destination: .methodDependent), headers: [:]).responseJSON { response in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? NSArray) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                case .failure:
                    print(response.error!)
                    completionHandler(nil, response.error, response.response?.statusCode)
                }
            }
        }
        else
        {
            print("No Network Found!")
            showLogoutAlert { (true) in
                
            }
            //pushNetworkErrorVC()
            SVProgressHUD.dismiss()
        }
    }
    
    func showIndicator(){
        SVProgressHUD.show()
    }
    
    func hideIndicator(){
        SVProgressHUD.dismiss()
    }
    
    func showSuccessIndicator(message: String){
        SVProgressHUD.showSuccess(withStatus: message)
    }

//MARK: - Webservice class.

//class WebServiceHandler{
    
    func requestWith<T>(method: HTTPMethod = .get, endPoint: String, loader: Bool = false, params: [String: Any] = [:], model: T.Type, success: @escaping (AnyObject) -> Void, failure: ((AnyObject) -> Void)? = nil) where T: Codable {
        
        print("===> start URL: \(BASE_URL + endPoint)")
        print("===> start Sending Dict : \(params)")
        
        
        if loader {
            APIClient.sharedInstance.showIndicator()
        }
        
//        let headers: HTTPHeaders = [
//            "x-access-token": UserManager.shared.userToken,
//            "accept": "application/json"
//        ]
        
        var URL = BASE_URL + endPoint
        
        URL = URL.replacingOccurrences(of: " ", with: "%20")
        print("===>URL: \(URL)")
        
        AF.request(URL, method: method, parameters: params,encoding: URLEncoding(destination: .methodDependent)).responseJSON {
            response -> Void in
            
            print("===> end URL: \(BASE_URL  + endPoint)")
            print("===> end Sending Dict : \(params)")
            print("===> end recieve Dict : \(response.description)")
            
            if loader {
                APIClient.sharedInstance.hideIndicator()
            }

            switch response.result {
            case .success(_):
                
                do {
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode(model, from: response.data!)
                    
                    print(NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)! as String)
                    
                    success(responseData as AnyObject)
                } catch {
                    print("Error = \(error)")
                    if failure != nil {
                        failure!(error.localizedDescription as AnyObject)
                    }
                }
                
            case .failure(_):
                //if !(Reachability()?.isReachable ?? true) {
                //    CommonClass().showNoInterNetPopup()
                //} else {
                    print("Response failed.............")
                    print("Error = \(response.error?.localizedDescription ?? "")")
                    if failure != nil {
                        failure!(response.error as AnyObject)
                //    }
                }
            }
            
            switch response.result {
            case .success:
                //print("Json Data :",response)
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

