//
//	THGerPremiumCalculation.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class THGerPremiumCalculation : NSObject, NSCoding{

	var data : THGerPremiumCalculationData!
	var errors : String!
	var message : String!
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
		if let dataData = dictionary["data"] as? NSDictionary{
			data = THGerPremiumCalculationData(fromDictionary: dataData)
		}
		else
		{
			data = THGerPremiumCalculationData(fromDictionary: NSDictionary.init())
		}
		errors = dictionary["errors"] as? String == nil ? "" : dictionary["errors"] as? String
		message = dictionary["message"] as? String == nil ? "" : dictionary["message"] as? String
		status = dictionary["status"] as? Bool == nil ? false : dictionary["status"] as? Bool
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if data != nil{
			dictionary["data"] = data.toDictionary()
		}
		if errors != nil{
			dictionary["errors"] = errors
		}
		if message != nil{
			dictionary["message"] = message
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
         data = aDecoder.decodeObject(forKey: "data") as? THGerPremiumCalculationData
         errors = aDecoder.decodeObject(forKey: "errors") as? String
         message = aDecoder.decodeObject(forKey: "message") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if data != nil{
			aCoder.encode(data, forKey: "data")
		}
		if errors != nil{
			aCoder.encode(errors, forKey: "errors")
		}
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}

	}

}