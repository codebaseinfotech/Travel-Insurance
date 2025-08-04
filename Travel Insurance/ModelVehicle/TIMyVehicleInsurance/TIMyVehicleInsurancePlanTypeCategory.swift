//
//	TIMyVehicleInsurancePlanTypeCategory.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIMyVehicleInsurancePlanTypeCategory : NSObject, NSCoding{

	var id : Int!
	var name : String!
	var nameArabic : String!
	var type : String!
	var zoneId : String!


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
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		name = dictionary["name"] as? String == nil ? "" : dictionary["name"] as? String
		nameArabic = dictionary["name_arabic"] as? String == nil ? "" : dictionary["name_arabic"] as? String
		type = dictionary["type"] as? String == nil ? "" : dictionary["type"] as? String
		zoneId = dictionary["zone_id"] as? String == nil ? "" : dictionary["zone_id"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if id != nil{
			dictionary["id"] = id
		}
		if name != nil{
			dictionary["name"] = name
		}
		if nameArabic != nil{
			dictionary["name_arabic"] = nameArabic
		}
		if type != nil{
			dictionary["type"] = type
		}
		if zoneId != nil{
			dictionary["zone_id"] = zoneId
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         nameArabic = aDecoder.decodeObject(forKey: "name_arabic") as? String
         type = aDecoder.decodeObject(forKey: "type") as? String
         zoneId = aDecoder.decodeObject(forKey: "zone_id") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if nameArabic != nil{
			aCoder.encode(nameArabic, forKey: "name_arabic")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}
		if zoneId != nil{
			aCoder.encode(zoneId, forKey: "zone_id")
		}

	}

}