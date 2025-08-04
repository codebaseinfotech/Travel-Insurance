//
//  TIModifyNewDetailDataData.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 24/12/24.
//

import Foundation

class TIModifyNewDetailDataData : NSObject, NSCoding{

    var currencySymbol : String!
    var policyEndDate : String!
    var policyStartDate : String!
    var timePeriod : String!
    var transactionDetailsId : String!


    /**
     * Overiding init method
     */
    init(fromDictionary dictionary: NSDictionary)
    {
        super.init()
        parseJSONData(fromDictionary: dictionary)
    }

    /**
     * Overiding init method
     */
    override init(){
    }

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    @objc func parseJSONData(fromDictionary dictionary: NSDictionary)
    {
        currencySymbol = dictionary["currencySymbol"] as? String == nil ? "" : dictionary["currencySymbol"] as? String
        policyEndDate = dictionary["policy_end_date"] as? String == nil ? "" : dictionary["policy_end_date"] as? String
        policyStartDate = dictionary["policy_start_date"] as? String == nil ? "" : dictionary["policy_start_date"] as? String
        timePeriod = dictionary["time_period"] as? String == nil ? "" : dictionary["time_period"] as? String
        transactionDetailsId = dictionary["transaction_details_id"] as? String == nil ? "" : dictionary["transaction_details_id"] as? String
    }

    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if currencySymbol != nil{
            dictionary["currencySymbol"] = currencySymbol
        }
        if policyEndDate != nil{
            dictionary["policy_end_date"] = policyEndDate
        }
        if policyStartDate != nil{
            dictionary["policy_start_date"] = policyStartDate
        }
        if timePeriod != nil{
            dictionary["time_period"] = timePeriod
        }
        if transactionDetailsId != nil{
            dictionary["transaction_details_id"] = transactionDetailsId
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         currencySymbol = aDecoder.decodeObject(forKey: "currencySymbol") as? String
         policyEndDate = aDecoder.decodeObject(forKey: "policy_end_date") as? String
         policyStartDate = aDecoder.decodeObject(forKey: "policy_start_date") as? String
         timePeriod = aDecoder.decodeObject(forKey: "time_period") as? String
         transactionDetailsId = aDecoder.decodeObject(forKey: "transaction_details_id") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder)
    {
        if currencySymbol != nil{
            aCoder.encode(currencySymbol, forKey: "currencySymbol")
        }
        if policyEndDate != nil{
            aCoder.encode(policyEndDate, forKey: "policy_end_date")
        }
        if policyStartDate != nil{
            aCoder.encode(policyStartDate, forKey: "policy_start_date")
        }
        if timePeriod != nil{
            aCoder.encode(timePeriod, forKey: "time_period")
        }
        if transactionDetailsId != nil{
            aCoder.encode(transactionDetailsId, forKey: "transaction_details_id")
        }

    }

}
