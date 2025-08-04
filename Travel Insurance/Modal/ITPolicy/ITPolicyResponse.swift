//
//	ITPolicyResponse.swift
//
//	Create by iMac on 22/2/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ITPolicyResponse : NSObject, NSCoding{

	var current : [ITPolicyCurrent]!
	var expired : [ITPolicyCurrent]!
	var upcoming : [String]!


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
		current = [ITPolicyCurrent]()
		if let currentArray = dictionary["current"] as? [NSDictionary]{
			for dic in currentArray{
				let value = ITPolicyCurrent(fromDictionary: dic)
				current.append(value)
			}
		}
		expired = [ITPolicyCurrent]()
		if let expiredArray = dictionary["expired"] as? [NSDictionary]{
			for dic in expiredArray{
				let value = ITPolicyCurrent(fromDictionary: dic)
				expired.append(value)
			}
		}
		upcoming = dictionary["upcoming"] as? [String] == nil ? [] : dictionary["upcoming"] as? [String]
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if current != nil{
			var dictionaryElements = [NSDictionary]()
			for currentElement in current {
				dictionaryElements.append(currentElement.toDictionary())
			}
			dictionary["current"] = dictionaryElements
		}
		if expired != nil{
			var dictionaryElements = [NSDictionary]()
			for expiredElement in expired {
				dictionaryElements.append(expiredElement.toDictionary())
			}
			dictionary["expired"] = dictionaryElements
		}
		if upcoming != nil{
			dictionary["upcoming"] = upcoming
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         current = aDecoder.decodeObject(forKey: "current") as? [ITPolicyCurrent]
         expired = aDecoder.decodeObject(forKey: "expired") as? [ITPolicyCurrent]
         upcoming = aDecoder.decodeObject(forKey: "upcoming") as? [String]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if current != nil{
			aCoder.encode(current, forKey: "current")
		}
		if expired != nil{
			aCoder.encode(expired, forKey: "expired")
		}
		if upcoming != nil{
			aCoder.encode(upcoming, forKey: "upcoming")
		}

	}

}
