//
//	TIReportResponse.swift
//
//	Create by Ankit Gabani on 18/9/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIReportResponse : NSObject, NSCoding{

	var iQDAmount : Int!
	var data : [TIReportData]!
	var entitlement : TIReportAgent!
	var totalCommisionAmount : Int!
	var totalInsurances : Int!
	var totalPaidAmount : Int!


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
		iQDAmount = dictionary["IQD_Amount"] as? Int == nil ? 0 : dictionary["IQD_Amount"] as? Int
		data = [TIReportData]()
		if let dataArray = dictionary["data"] as? [NSDictionary]{
			for dic in dataArray{
				let value = TIReportData(fromDictionary: dic)
				data.append(value)
			}
		}
		if let entitlementData = dictionary["entitlement"] as? NSDictionary{
			entitlement = TIReportAgent(fromDictionary: entitlementData)
		}
		else
		{
			entitlement = TIReportAgent(fromDictionary: NSDictionary.init())
		}
		totalCommisionAmount = dictionary["totalCommisionAmount"] as? Int == nil ? 0 : dictionary["totalCommisionAmount"] as? Int
		totalInsurances = dictionary["total_insurances"] as? Int == nil ? 0 : dictionary["total_insurances"] as? Int
		totalPaidAmount = dictionary["total_paid_amount"] as? Int == nil ? 0 : dictionary["total_paid_amount"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if iQDAmount != nil{
			dictionary["IQD_Amount"] = iQDAmount
		}
		if data != nil{
			var dictionaryElements = [NSDictionary]()
			for dataElement in data {
				dictionaryElements.append(dataElement.toDictionary())
			}
			dictionary["data"] = dictionaryElements
		}
		if entitlement != nil{
			dictionary["entitlement"] = entitlement.toDictionary()
		}
		if totalCommisionAmount != nil{
			dictionary["totalCommisionAmount"] = totalCommisionAmount
		}
		if totalInsurances != nil{
			dictionary["total_insurances"] = totalInsurances
		}
		if totalPaidAmount != nil{
			dictionary["total_paid_amount"] = totalPaidAmount
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         iQDAmount = aDecoder.decodeObject(forKey: "IQD_Amount") as? Int
         data = aDecoder.decodeObject(forKey: "data") as? [TIReportData]
         entitlement = aDecoder.decodeObject(forKey: "entitlement") as? TIReportAgent
         totalCommisionAmount = aDecoder.decodeObject(forKey: "totalCommisionAmount") as? Int
         totalInsurances = aDecoder.decodeObject(forKey: "total_insurances") as? Int
         totalPaidAmount = aDecoder.decodeObject(forKey: "total_paid_amount") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if iQDAmount != nil{
			aCoder.encode(iQDAmount, forKey: "IQD_Amount")
		}
		if data != nil{
			aCoder.encode(data, forKey: "data")
		}
		if entitlement != nil{
			aCoder.encode(entitlement, forKey: "entitlement")
		}
		if totalCommisionAmount != nil{
			aCoder.encode(totalCommisionAmount, forKey: "totalCommisionAmount")
		}
		if totalInsurances != nil{
			aCoder.encode(totalInsurances, forKey: "total_insurances")
		}
		if totalPaidAmount != nil{
			aCoder.encode(totalPaidAmount, forKey: "total_paid_amount")
		}

	}

}