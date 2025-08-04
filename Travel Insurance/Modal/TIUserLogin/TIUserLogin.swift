//
//	TIUserLogin.swift
//
//	Create by Ankit Gabani on 31/7/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIUserLogin : NSObject, NSCoding{

	var authorisation : TIUserLoginAuthorisation!
	var currencySymbol : String!
	var message : String!
	var response : TIUserLoginResponse!
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
		if let authorisationData = dictionary["authorisation"] as? NSDictionary{
			authorisation = TIUserLoginAuthorisation(fromDictionary: authorisationData)
		}
		else
		{
			authorisation = TIUserLoginAuthorisation(fromDictionary: NSDictionary.init())
		}
		currencySymbol = dictionary["currency_symbol"] as? String == nil ? "" : dictionary["currency_symbol"] as? String
		message = dictionary["message"] as? String == nil ? "" : dictionary["message"] as? String
		if let responseData = dictionary["response"] as? NSDictionary{
			response = TIUserLoginResponse(fromDictionary: responseData)
		}
		else
		{
			response = TIUserLoginResponse(fromDictionary: NSDictionary.init())
		}
		status = dictionary["status"] as? Int == nil ? 0 : dictionary["status"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if authorisation != nil{
			dictionary["authorisation"] = authorisation.toDictionary()
		}
		if currencySymbol != nil{
			dictionary["currency_symbol"] = currencySymbol
		}
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
         authorisation = aDecoder.decodeObject(forKey: "authorisation") as? TIUserLoginAuthorisation
         currencySymbol = aDecoder.decodeObject(forKey: "currency_symbol") as? String
         message = aDecoder.decodeObject(forKey: "message") as? String
         response = aDecoder.decodeObject(forKey: "response") as? TIUserLoginResponse
         status = aDecoder.decodeObject(forKey: "status") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if authorisation != nil{
			aCoder.encode(authorisation, forKey: "authorisation")
		}
		if currencySymbol != nil{
			aCoder.encode(currencySymbol, forKey: "currency_symbol")
		}
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