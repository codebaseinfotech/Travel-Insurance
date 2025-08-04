//
//	TIMyVehicleInsuranceUserOrder.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIMyVehicleInsuranceUserOrder : NSObject, NSCoding{

	var current : [TIMyVehicleInsuranceCurrent]!
	var expired : [TIMyVehicleInsuranceCurrent]!
	var upcoming : [TIMyVehicleInsuranceCurrent]!


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
		current = [TIMyVehicleInsuranceCurrent]()
		if let currentArray = dictionary["current"] as? [NSDictionary]{
			for dic in currentArray{
				let value = TIMyVehicleInsuranceCurrent(fromDictionary: dic)
				current.append(value)
			}
		}
		expired = [TIMyVehicleInsuranceCurrent]()
		if let expiredArray = dictionary["expired"] as? [NSDictionary]{
			for dic in expiredArray{
				let value = TIMyVehicleInsuranceCurrent(fromDictionary: dic)
				expired.append(value)
			}
		}
		upcoming = [TIMyVehicleInsuranceCurrent]()
		if let upcomingArray = dictionary["upcoming"] as? [NSDictionary]{
			for dic in upcomingArray{
				let value = TIMyVehicleInsuranceCurrent(fromDictionary: dic)
				upcoming.append(value)
			}
		}
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
			var dictionaryElements = [NSDictionary]()
			for upcomingElement in upcoming {
				dictionaryElements.append(upcomingElement.toDictionary())
			}
			dictionary["upcoming"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         current = aDecoder.decodeObject(forKey: "current") as? [TIMyVehicleInsuranceCurrent]
         expired = aDecoder.decodeObject(forKey: "expired") as? [TIMyVehicleInsuranceCurrent]
         upcoming = aDecoder.decodeObject(forKey: "upcoming") as? [TIMyVehicleInsuranceCurrent]

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
