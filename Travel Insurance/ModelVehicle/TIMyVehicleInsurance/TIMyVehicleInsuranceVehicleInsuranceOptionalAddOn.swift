//
//	TIMyVehicleInsuranceVehicleInsuranceOptionalAddOn.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIMyVehicleInsuranceVehicleInsuranceOptionalAddOn : NSObject, NSCoding{

	var addOnId : String!
	var createdAt : String!
	var id : Int!
	var price : String!
	var updatedAt : String!
	var vehicleInsuranceId : String!


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
		addOnId = dictionary["add_on_id"] as? String == nil ? "" : dictionary["add_on_id"] as? String
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		price = dictionary["price"] as? String == nil ? "" : dictionary["price"] as? String
		updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
		vehicleInsuranceId = dictionary["vehicle_insurance_id"] as? String == nil ? "" : dictionary["vehicle_insurance_id"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if addOnId != nil{
			dictionary["add_on_id"] = addOnId
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if id != nil{
			dictionary["id"] = id
		}
		if price != nil{
			dictionary["price"] = price
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if vehicleInsuranceId != nil{
			dictionary["vehicle_insurance_id"] = vehicleInsuranceId
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         addOnId = aDecoder.decodeObject(forKey: "add_on_id") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         price = aDecoder.decodeObject(forKey: "price") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         vehicleInsuranceId = aDecoder.decodeObject(forKey: "vehicle_insurance_id") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if addOnId != nil{
			aCoder.encode(addOnId, forKey: "add_on_id")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if vehicleInsuranceId != nil{
			aCoder.encode(vehicleInsuranceId, forKey: "vehicle_insurance_id")
		}

	}

}