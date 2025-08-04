//
//	TIGetAddOn.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIGetAddOn : NSObject, NSCoding{

	var errors : String!
	var vehiclePlan : TIGetAddOnVehiclePlan!


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
		errors = dictionary["errors"] as? String == nil ? "" : dictionary["errors"] as? String
		if let vehiclePlanData = dictionary["vehicle_plan"] as? NSDictionary{
			vehiclePlan = TIGetAddOnVehiclePlan(fromDictionary: vehiclePlanData)
		}
		else
		{
			vehiclePlan = TIGetAddOnVehiclePlan(fromDictionary: NSDictionary.init())
		}
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if errors != nil{
			dictionary["errors"] = errors
		}
		if vehiclePlan != nil{
			dictionary["vehicle_plan"] = vehiclePlan.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         errors = aDecoder.decodeObject(forKey: "errors") as? String
         vehiclePlan = aDecoder.decodeObject(forKey: "vehicle_plan") as? TIGetAddOnVehiclePlan

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if errors != nil{
			aCoder.encode(errors, forKey: "errors")
		}
		if vehiclePlan != nil{
			aCoder.encode(vehiclePlan, forKey: "vehicle_plan")
		}

	}

}