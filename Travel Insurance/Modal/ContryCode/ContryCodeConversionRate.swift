//
//	ContryCodeConversionRate.swift
//
//	Create by Apple on 15/3/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ContryCodeConversionRate : NSObject, NSCoding{

	var abbreviation : String!
	var conversionRate : Double!
	var currency : String!
	var id : Int!
	var symbol : String!


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
		abbreviation = dictionary["abbreviation"] as? String == nil ? "" : dictionary["abbreviation"] as? String
        conversionRate = dictionary["conversion_rate"] as? Double == nil ? 0.0 : dictionary["conversion_rate"] as? Double
		currency = dictionary["currency"] as? String == nil ? "" : dictionary["currency"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		symbol = dictionary["symbol"] as? String == nil ? "" : dictionary["symbol"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if abbreviation != nil{
			dictionary["abbreviation"] = abbreviation
		}
		if conversionRate != nil{
			dictionary["conversion_rate"] = conversionRate
		}
		if currency != nil{
			dictionary["currency"] = currency
		}
		if id != nil{
			dictionary["id"] = id
		}
		if symbol != nil{
			dictionary["symbol"] = symbol
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         abbreviation = aDecoder.decodeObject(forKey: "abbreviation") as? String
         conversionRate = aDecoder.decodeObject(forKey: "conversion_rate") as? Double
         currency = aDecoder.decodeObject(forKey: "currency") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         symbol = aDecoder.decodeObject(forKey: "symbol") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if abbreviation != nil{
			aCoder.encode(abbreviation, forKey: "abbreviation")
		}
		if conversionRate != nil{
			aCoder.encode(conversionRate, forKey: "conversion_rate")
		}
		if currency != nil{
			aCoder.encode(currency, forKey: "currency")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if symbol != nil{
			aCoder.encode(symbol, forKey: "symbol")
		}

	}

}
