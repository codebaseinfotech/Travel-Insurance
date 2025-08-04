//
//	TIModifyDetailFormattedPriceData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIModifyDetailFormattedPriceData : NSObject, NSCoding{

	var price : Float!
	var priceusd : String!


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
		price = dictionary["price"] as? Float == nil ? 0 : dictionary["price"] as? Float
		priceusd = dictionary["priceusd"] as? String == nil ? "" : dictionary["priceusd"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if price != nil{
			dictionary["price"] = price
		}
		if priceusd != nil{
			dictionary["priceusd"] = priceusd
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         price = aDecoder.decodeObject(forKey: "price") as? Float
         priceusd = aDecoder.decodeObject(forKey: "priceusd") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}
		if priceusd != nil{
			aCoder.encode(priceusd, forKey: "priceusd")
		}

	}

}