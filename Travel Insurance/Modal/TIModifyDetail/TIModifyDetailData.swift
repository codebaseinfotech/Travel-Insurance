//
//	TIModifyDetailData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIModifyDetailData : NSObject, NSCoding{

	var currencySymbol : String!
	var policyEndDate : String!
	var policyStartDate : String!
	var timePeriod : String!
	var iQDAmount : String!
    var totalUSDPrice : Double!
	var currentPolicy : [TIModifyDetailCurrentPolicy]!
	var data : TIModifyNewDetailDataData!
	var formattedPriceData : [TIModifyDetailFormattedPriceData]!
	var planid : String!
	var requestDatapolicy : TIModifyDetailRequestDatapolicy!
	var sumOfPrices : Float!
	var transactionDetailsId : Int!


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
		iQDAmount = dictionary["IQDAmount"] as? String == nil ? "" : dictionary["IQDAmount"] as? String
        totalUSDPrice = dictionary["TotalUSDPrice"] as? Double == nil ? 0.0 : dictionary["TotalUSDPrice"] as? Double
		currentPolicy = [TIModifyDetailCurrentPolicy]()
		if let currentPolicyArray = dictionary["currentPolicy"] as? [NSDictionary]{
			for dic in currentPolicyArray{
				let value = TIModifyDetailCurrentPolicy(fromDictionary: dic)
				currentPolicy.append(value)
			}
		}
		if let dataData = dictionary["data"] as? NSDictionary{
			data = TIModifyNewDetailDataData(fromDictionary: dataData)
		}
		else
		{
			data = TIModifyNewDetailDataData(fromDictionary: NSDictionary.init())
		}
		formattedPriceData = [TIModifyDetailFormattedPriceData]()
		if let formattedPriceDataArray = dictionary["formattedPriceData"] as? [NSDictionary]{
			for dic in formattedPriceDataArray{
				let value = TIModifyDetailFormattedPriceData(fromDictionary: dic)
				formattedPriceData.append(value)
			}
		}
		planid = dictionary["planid"] as? String == nil ? "" : dictionary["planid"] as? String
		if let requestDatapolicyData = dictionary["requestDatapolicy"] as? NSDictionary{
			requestDatapolicy = TIModifyDetailRequestDatapolicy(fromDictionary: requestDatapolicyData)
		}
		else
		{
			requestDatapolicy = TIModifyDetailRequestDatapolicy(fromDictionary: NSDictionary.init())
		}
		sumOfPrices = dictionary["sumOfPrices"] as? Float == nil ? 0 : dictionary["sumOfPrices"] as? Float
		transactionDetailsId = dictionary["transaction_details_id"] as? Int == nil ? 0 : dictionary["transaction_details_id"] as? Int
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
 		if iQDAmount != nil{
			dictionary["IQDAmount"] = iQDAmount
		}
		if totalUSDPrice != nil{
			dictionary["TotalUSDPrice"] = totalUSDPrice
		}
		if currentPolicy != nil{
			var dictionaryElements = [NSDictionary]()
			for currentPolicyElement in currentPolicy {
				dictionaryElements.append(currentPolicyElement.toDictionary())
			}
			dictionary["currentPolicy"] = dictionaryElements
		}
		if data != nil{
			dictionary["data"] = data.toDictionary()
		}
		if formattedPriceData != nil{
			var dictionaryElements = [NSDictionary]()
			for formattedPriceDataElement in formattedPriceData {
				dictionaryElements.append(formattedPriceDataElement.toDictionary())
			}
			dictionary["formattedPriceData"] = dictionaryElements
		}
		if planid != nil{
			dictionary["planid"] = planid
		}
		if requestDatapolicy != nil{
			dictionary["requestDatapolicy"] = requestDatapolicy.toDictionary()
		}
		if sumOfPrices != nil{
			dictionary["sumOfPrices"] = sumOfPrices
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
         iQDAmount = aDecoder.decodeObject(forKey: "IQDAmount") as? String
         totalUSDPrice = aDecoder.decodeObject(forKey: "TotalUSDPrice") as? Double
         currentPolicy = aDecoder.decodeObject(forKey: "currentPolicy") as? [TIModifyDetailCurrentPolicy]
         data = aDecoder.decodeObject(forKey: "data") as? TIModifyNewDetailDataData
         formattedPriceData = aDecoder.decodeObject(forKey: "formattedPriceData") as? [TIModifyDetailFormattedPriceData]
         planid = aDecoder.decodeObject(forKey: "planid") as? String
         requestDatapolicy = aDecoder.decodeObject(forKey: "requestDatapolicy") as? TIModifyDetailRequestDatapolicy
         sumOfPrices = aDecoder.decodeObject(forKey: "sumOfPrices") as? Float
         transactionDetailsId = aDecoder.decodeObject(forKey: "transaction_details_id") as? Int

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
		 
		if iQDAmount != nil{
			aCoder.encode(iQDAmount, forKey: "IQDAmount")
		}
		if totalUSDPrice != nil{
			aCoder.encode(totalUSDPrice, forKey: "TotalUSDPrice")
		}
		if currentPolicy != nil{
			aCoder.encode(currentPolicy, forKey: "currentPolicy")
		}
		if data != nil{
			aCoder.encode(data, forKey: "data")
		}
		if formattedPriceData != nil{
			aCoder.encode(formattedPriceData, forKey: "formattedPriceData")
		}
		if planid != nil{
			aCoder.encode(planid, forKey: "planid")
		}
		if requestDatapolicy != nil{
			aCoder.encode(requestDatapolicy, forKey: "requestDatapolicy")
		}
		if sumOfPrices != nil{
			aCoder.encode(sumOfPrices, forKey: "sumOfPrices")
		}
		if transactionDetailsId != nil{
			aCoder.encode(transactionDetailsId, forKey: "transaction_details_id")
		}

	}

}
