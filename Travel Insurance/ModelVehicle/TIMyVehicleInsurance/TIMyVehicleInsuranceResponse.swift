//
//	TIMyVehicleInsuranceResponse.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIMyVehicleInsuranceResponse : NSObject, NSCoding{

	var userOrder : TIMyVehicleInsuranceUserOrder!
	var vehicleClaim : TIMyVehicleInsuranceVehicleClaim!
	var vehicleInsurance : TIMyVehicleInsuranceUserOrder!


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
		if let userOrderData = dictionary["user_order"] as? NSDictionary{
			userOrder = TIMyVehicleInsuranceUserOrder(fromDictionary: userOrderData)
		}
		else
		{
			userOrder = TIMyVehicleInsuranceUserOrder(fromDictionary: NSDictionary.init())
		}
		if let vehicleClaimData = dictionary["vehicle_claim"] as? NSDictionary{
			vehicleClaim = TIMyVehicleInsuranceVehicleClaim(fromDictionary: vehicleClaimData)
		}
		else
		{
			vehicleClaim = TIMyVehicleInsuranceVehicleClaim(fromDictionary: NSDictionary.init())
		}
		if let vehicleInsuranceData = dictionary["vehicle_insurance"] as? NSDictionary{
			vehicleInsurance = TIMyVehicleInsuranceUserOrder(fromDictionary: vehicleInsuranceData)
		}
		else
		{
			vehicleInsurance = TIMyVehicleInsuranceUserOrder(fromDictionary: NSDictionary.init())
		}
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if userOrder != nil{
			dictionary["user_order"] = userOrder.toDictionary()
		}
		if vehicleClaim != nil{
			dictionary["vehicle_claim"] = vehicleClaim.toDictionary()
		}
		if vehicleInsurance != nil{
			dictionary["vehicle_insurance"] = vehicleInsurance.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         userOrder = aDecoder.decodeObject(forKey: "user_order") as? TIMyVehicleInsuranceUserOrder
         vehicleClaim = aDecoder.decodeObject(forKey: "vehicle_claim") as? TIMyVehicleInsuranceVehicleClaim
         vehicleInsurance = aDecoder.decodeObject(forKey: "vehicle_insurance") as? TIMyVehicleInsuranceUserOrder

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if userOrder != nil{
			aCoder.encode(userOrder, forKey: "user_order")
		}
		if vehicleClaim != nil{
			aCoder.encode(vehicleClaim, forKey: "vehicle_claim")
		}
		if vehicleInsurance != nil{
			aCoder.encode(vehicleInsurance, forKey: "vehicle_insurance")
		}

	}

}