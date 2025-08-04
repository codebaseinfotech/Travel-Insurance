//
//	ITPolicy.swift
//
//	Create by iMac on 22/2/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ITPolicy : NSObject, NSCoding{

	var message : String!
	var response : ITPolicyResponse!
	var status : Int!


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
		message = dictionary["message"] as? String == nil ? "" : dictionary["message"] as? String
		if let responseData = dictionary["response"] as? NSDictionary{
			response = ITPolicyResponse(fromDictionary: responseData)
		}
		else
		{
			response = ITPolicyResponse(fromDictionary: NSDictionary.init())
		}
		status = dictionary["status"] as? Int == nil ? 0 : dictionary["status"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if message != nil{
			dictionary["message"] = message
		}
		if response != nil{
			dictionary["response"] = response.toDictionary()
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
         message = aDecoder.decodeObject(forKey: "message") as? String
         response = aDecoder.decodeObject(forKey: "response") as? ITPolicyResponse
         status = aDecoder.decodeObject(forKey: "status") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}
		if response != nil{
			aCoder.encode(response, forKey: "response")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}

	}

}