//
//	THGerPremiumCalculationData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class THGerPremiumCalculationData : NSObject, NSCoding{

	var agencyRepair : Float!
	var baseRate : Float!
	var idvAmount : Double!
	var postClaimAmount : Int!
    var premiumAmount : Double!
	var totalRate : Float!
	var vehicleAge : Int!
	var vehiclePlan : THGerPremiumCalculationVehiclePlan!
	var vehicleValue : Int!


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
		agencyRepair = dictionary["agency_repair"] as? Float == nil ? 0 : dictionary["agency_repair"] as? Float
		baseRate = dictionary["base_rate"] as? Float == nil ? 0 : dictionary["base_rate"] as? Float
		idvAmount = dictionary["idv_amount"] as? Double == nil ? 0 : dictionary["idv_amount"] as? Double
		postClaimAmount = dictionary["post_claim_amount"] as? Int == nil ? 0 : dictionary["post_claim_amount"] as? Int
		premiumAmount = dictionary["premium_amount"] as? Double == nil ? 0 : dictionary["premium_amount"] as? Double
		totalRate = dictionary["total_rate"] as? Float == nil ? 0 : dictionary["total_rate"] as? Float
		vehicleAge = dictionary["vehicle_age"] as? Int == nil ? 0 : dictionary["vehicle_age"] as? Int
		if let vehiclePlanData = dictionary["vehicle_plan"] as? NSDictionary{
			vehiclePlan = THGerPremiumCalculationVehiclePlan(fromDictionary: vehiclePlanData)
		}
		else
		{
			vehiclePlan = THGerPremiumCalculationVehiclePlan(fromDictionary: NSDictionary.init())
		}
		vehicleValue = dictionary["vehicle_value"] as? Int == nil ? 0 : dictionary["vehicle_value"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if agencyRepair != nil{
			dictionary["agency_repair"] = agencyRepair
		}
		if baseRate != nil{
			dictionary["base_rate"] = baseRate
		}
		if idvAmount != nil{
			dictionary["idv_amount"] = idvAmount
		}
		if postClaimAmount != nil{
			dictionary["post_claim_amount"] = postClaimAmount
		}
		if premiumAmount != nil{
			dictionary["premium_amount"] = premiumAmount
		}
		if totalRate != nil{
			dictionary["total_rate"] = totalRate
		}
		if vehicleAge != nil{
			dictionary["vehicle_age"] = vehicleAge
		}
		if vehiclePlan != nil{
			dictionary["vehicle_plan"] = vehiclePlan.toDictionary()
		}
		if vehicleValue != nil{
			dictionary["vehicle_value"] = vehicleValue
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         agencyRepair = aDecoder.decodeObject(forKey: "agency_repair") as? Float
         baseRate = aDecoder.decodeObject(forKey: "base_rate") as? Float
         idvAmount = aDecoder.decodeObject(forKey: "idv_amount") as? Double
         postClaimAmount = aDecoder.decodeObject(forKey: "post_claim_amount") as? Int
         premiumAmount = aDecoder.decodeObject(forKey: "premium_amount") as? Double
         totalRate = aDecoder.decodeObject(forKey: "total_rate") as? Float
         vehicleAge = aDecoder.decodeObject(forKey: "vehicle_age") as? Int
         vehiclePlan = aDecoder.decodeObject(forKey: "vehicle_plan") as? THGerPremiumCalculationVehiclePlan
         vehicleValue = aDecoder.decodeObject(forKey: "vehicle_value") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if agencyRepair != nil{
			aCoder.encode(agencyRepair, forKey: "agency_repair")
		}
		if baseRate != nil{
			aCoder.encode(baseRate, forKey: "base_rate")
		}
		if idvAmount != nil{
			aCoder.encode(idvAmount, forKey: "idv_amount")
		}
		if postClaimAmount != nil{
			aCoder.encode(postClaimAmount, forKey: "post_claim_amount")
		}
		if premiumAmount != nil{
			aCoder.encode(premiumAmount, forKey: "premium_amount")
		}
		if totalRate != nil{
			aCoder.encode(totalRate, forKey: "total_rate")
		}
		if vehicleAge != nil{
			aCoder.encode(vehicleAge, forKey: "vehicle_age")
		}
		if vehiclePlan != nil{
			aCoder.encode(vehiclePlan, forKey: "vehicle_plan")
		}
		if vehicleValue != nil{
			aCoder.encode(vehicleValue, forKey: "vehicle_value")
		}

	}

}
