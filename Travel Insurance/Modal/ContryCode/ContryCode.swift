//
//	ContryCode.swift
//
//	Create by Apple on 15/3/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ContryCode : NSObject, NSCoding{

	var conversionRate : [ContryCodeConversionRate]!
	var status : Bool!


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
		conversionRate = [ContryCodeConversionRate]()
		if let conversionRateArray = dictionary["conversion_rate"] as? [NSDictionary]{
			for dic in conversionRateArray{
				let value = ContryCodeConversionRate(fromDictionary: dic)
				conversionRate.append(value)
			}
		}
		status = dictionary["status"] as? Bool == nil ? false : dictionary["status"] as? Bool
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if conversionRate != nil{
			var dictionaryElements = [NSDictionary]()
			for conversionRateElement in conversionRate {
				dictionaryElements.append(conversionRateElement.toDictionary())
			}
			dictionary["conversion_rate"] = dictionaryElements
		}
		if status != nil{
			dictionary["status"] = status
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         conversionRate = aDecoder.decodeObject(forKey: "conversion_rate") as? [ContryCodeConversionRate]
         status = aDecoder.decodeObject(forKey: "status") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if conversionRate != nil{
			aCoder.encode(conversionRate, forKey: "conversion_rate")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}

	}

}