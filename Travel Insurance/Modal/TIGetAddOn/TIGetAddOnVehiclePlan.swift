//
//	TIGetAddOnVehiclePlan.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIGetAddOnVehiclePlan : NSObject, NSCoding{

	var claimSupport : String!
	var createdAt : String!
	var id : Int!
	var planName : String!
	var status : String!
	var type : String!
	var updatedAt : String!
	var vehicleAddOn : [TIGetAddOnVehicleAddOn]!


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
		claimSupport = dictionary["claim_support"] as? String == nil ? "" : dictionary["claim_support"] as? String
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		planName = dictionary["plan_name"] as? String == nil ? "" : dictionary["plan_name"] as? String
		status = dictionary["status"] as? String == nil ? "" : dictionary["status"] as? String
		type = dictionary["type"] as? String == nil ? "" : dictionary["type"] as? String
		updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
		vehicleAddOn = [TIGetAddOnVehicleAddOn]()
		if let vehicleAddOnArray = dictionary["vehicle_add_on"] as? [NSDictionary]{
			for dic in vehicleAddOnArray{
				let value = TIGetAddOnVehicleAddOn(fromDictionary: dic)
				vehicleAddOn.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if claimSupport != nil{
			dictionary["claim_support"] = claimSupport
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if id != nil{
			dictionary["id"] = id
		}
		if planName != nil{
			dictionary["plan_name"] = planName
		}
		if status != nil{
			dictionary["status"] = status
		}
		if type != nil{
			dictionary["type"] = type
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if vehicleAddOn != nil{
			var dictionaryElements = [NSDictionary]()
			for vehicleAddOnElement in vehicleAddOn {
				dictionaryElements.append(vehicleAddOnElement.toDictionary())
			}
			dictionary["vehicle_add_on"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         claimSupport = aDecoder.decodeObject(forKey: "claim_support") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         planName = aDecoder.decodeObject(forKey: "plan_name") as? String
         status = aDecoder.decodeObject(forKey: "status") as? String
         type = aDecoder.decodeObject(forKey: "type") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         vehicleAddOn = aDecoder.decodeObject(forKey: "vehicle_add_on") as? [TIGetAddOnVehicleAddOn]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if claimSupport != nil{
			aCoder.encode(claimSupport, forKey: "claim_support")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if planName != nil{
			aCoder.encode(planName, forKey: "plan_name")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if vehicleAddOn != nil{
			aCoder.encode(vehicleAddOn, forKey: "vehicle_add_on")
		}

	}

}