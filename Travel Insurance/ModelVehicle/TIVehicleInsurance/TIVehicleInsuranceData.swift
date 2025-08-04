//
//	TIVehicleInsuranceData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIVehicleInsuranceData : NSObject, NSCoding{

	var agencyRepair : String!
	var basePremium : String!
	var chassisNo : String!
	var color : String!
	var createdAt : String!
	var dailCode : String!
	var dob : String!
	var duration : String!
	var email : String!
	var engineNo : String!
	var engineSize : String!
	var fuelType : String!
	var id : Int!
	var modelYear : String!
	var name : String!
	var phoneNo : String!
	var policyEndDate : String!
	var policyId : String!
	var policyStartDate : String!
	var totalPremium : String!
	var txnData : String!
	var txnId : String!
	var updatedAt : String!
	var userId : Int!
	var vehicleAge : Int!
	var vehicleBrand : String!
	var vehicleModel : String!
	var vehicleNo : String!
	var vehiclePlanId : String!
	var vehicleType : String!
	var vehicleValue : String!


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
		agencyRepair = dictionary["agency_repair"] as? String == nil ? "" : dictionary["agency_repair"] as? String
		basePremium = dictionary["base_premium"] as? String == nil ? "" : dictionary["base_premium"] as? String
		chassisNo = dictionary["chassis_no"] as? String == nil ? "" : dictionary["chassis_no"] as? String
		color = dictionary["color"] as? String == nil ? "" : dictionary["color"] as? String
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		dailCode = dictionary["dail_code"] as? String == nil ? "" : dictionary["dail_code"] as? String
		dob = dictionary["dob"] as? String == nil ? "" : dictionary["dob"] as? String
		duration = dictionary["duration"] as? String == nil ? "" : dictionary["duration"] as? String
		email = dictionary["email"] as? String == nil ? "" : dictionary["email"] as? String
		engineNo = dictionary["engine_no"] as? String == nil ? "" : dictionary["engine_no"] as? String
		engineSize = dictionary["engine_size"] as? String == nil ? "" : dictionary["engine_size"] as? String
		fuelType = dictionary["fuel_type"] as? String == nil ? "" : dictionary["fuel_type"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		modelYear = dictionary["model_year"] as? String == nil ? "" : dictionary["model_year"] as? String
		name = dictionary["name"] as? String == nil ? "" : dictionary["name"] as? String
		phoneNo = dictionary["phone_no"] as? String == nil ? "" : dictionary["phone_no"] as? String
		policyEndDate = dictionary["policy_end_date"] as? String == nil ? "" : dictionary["policy_end_date"] as? String
		policyId = dictionary["policy_id"] as? String == nil ? "" : dictionary["policy_id"] as? String
		policyStartDate = dictionary["policy_start_date"] as? String == nil ? "" : dictionary["policy_start_date"] as? String
		totalPremium = dictionary["total_premium"] as? String == nil ? "" : dictionary["total_premium"] as? String
		txnData = dictionary["txn_data"] as? String == nil ? "" : dictionary["txn_data"] as? String
		txnId = dictionary["txn_id"] as? String == nil ? "" : dictionary["txn_id"] as? String
		updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
		userId = dictionary["user_id"] as? Int == nil ? 0 : dictionary["user_id"] as? Int
		vehicleAge = dictionary["vehicle_age"] as? Int == nil ? 0 : dictionary["vehicle_age"] as? Int
		vehicleBrand = dictionary["vehicle_brand"] as? String == nil ? "" : dictionary["vehicle_brand"] as? String
		vehicleModel = dictionary["vehicle_model"] as? String == nil ? "" : dictionary["vehicle_model"] as? String
		vehicleNo = dictionary["vehicle_no"] as? String == nil ? "" : dictionary["vehicle_no"] as? String
		vehiclePlanId = dictionary["vehicle_plan_id"] as? String == nil ? "" : dictionary["vehicle_plan_id"] as? String
		vehicleType = dictionary["vehicle_type"] as? String == nil ? "" : dictionary["vehicle_type"] as? String
		vehicleValue = dictionary["vehicle_value"] as? String == nil ? "" : dictionary["vehicle_value"] as? String
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
		if basePremium != nil{
			dictionary["base_premium"] = basePremium
		}
		if chassisNo != nil{
			dictionary["chassis_no"] = chassisNo
		}
		if color != nil{
			dictionary["color"] = color
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if dailCode != nil{
			dictionary["dail_code"] = dailCode
		}
		if dob != nil{
			dictionary["dob"] = dob
		}
		if duration != nil{
			dictionary["duration"] = duration
		}
		if email != nil{
			dictionary["email"] = email
		}
		if engineNo != nil{
			dictionary["engine_no"] = engineNo
		}
		if engineSize != nil{
			dictionary["engine_size"] = engineSize
		}
		if fuelType != nil{
			dictionary["fuel_type"] = fuelType
		}
		if id != nil{
			dictionary["id"] = id
		}
		if modelYear != nil{
			dictionary["model_year"] = modelYear
		}
		if name != nil{
			dictionary["name"] = name
		}
		if phoneNo != nil{
			dictionary["phone_no"] = phoneNo
		}
		if policyEndDate != nil{
			dictionary["policy_end_date"] = policyEndDate
		}
		if policyId != nil{
			dictionary["policy_id"] = policyId
		}
		if policyStartDate != nil{
			dictionary["policy_start_date"] = policyStartDate
		}
		if totalPremium != nil{
			dictionary["total_premium"] = totalPremium
		}
		if txnData != nil{
			dictionary["txn_data"] = txnData
		}
		if txnId != nil{
			dictionary["txn_id"] = txnId
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if userId != nil{
			dictionary["user_id"] = userId
		}
		if vehicleAge != nil{
			dictionary["vehicle_age"] = vehicleAge
		}
		if vehicleBrand != nil{
			dictionary["vehicle_brand"] = vehicleBrand
		}
		if vehicleModel != nil{
			dictionary["vehicle_model"] = vehicleModel
		}
		if vehicleNo != nil{
			dictionary["vehicle_no"] = vehicleNo
		}
		if vehiclePlanId != nil{
			dictionary["vehicle_plan_id"] = vehiclePlanId
		}
		if vehicleType != nil{
			dictionary["vehicle_type"] = vehicleType
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
         agencyRepair = aDecoder.decodeObject(forKey: "agency_repair") as? String
         basePremium = aDecoder.decodeObject(forKey: "base_premium") as? String
         chassisNo = aDecoder.decodeObject(forKey: "chassis_no") as? String
         color = aDecoder.decodeObject(forKey: "color") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         dailCode = aDecoder.decodeObject(forKey: "dail_code") as? String
         dob = aDecoder.decodeObject(forKey: "dob") as? String
         duration = aDecoder.decodeObject(forKey: "duration") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         engineNo = aDecoder.decodeObject(forKey: "engine_no") as? String
         engineSize = aDecoder.decodeObject(forKey: "engine_size") as? String
         fuelType = aDecoder.decodeObject(forKey: "fuel_type") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         modelYear = aDecoder.decodeObject(forKey: "model_year") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         phoneNo = aDecoder.decodeObject(forKey: "phone_no") as? String
         policyEndDate = aDecoder.decodeObject(forKey: "policy_end_date") as? String
         policyId = aDecoder.decodeObject(forKey: "policy_id") as? String
         policyStartDate = aDecoder.decodeObject(forKey: "policy_start_date") as? String
         totalPremium = aDecoder.decodeObject(forKey: "total_premium") as? String
         txnData = aDecoder.decodeObject(forKey: "txn_data") as? String
         txnId = aDecoder.decodeObject(forKey: "txn_id") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         userId = aDecoder.decodeObject(forKey: "user_id") as? Int
         vehicleAge = aDecoder.decodeObject(forKey: "vehicle_age") as? Int
         vehicleBrand = aDecoder.decodeObject(forKey: "vehicle_brand") as? String
         vehicleModel = aDecoder.decodeObject(forKey: "vehicle_model") as? String
         vehicleNo = aDecoder.decodeObject(forKey: "vehicle_no") as? String
         vehiclePlanId = aDecoder.decodeObject(forKey: "vehicle_plan_id") as? String
         vehicleType = aDecoder.decodeObject(forKey: "vehicle_type") as? String
         vehicleValue = aDecoder.decodeObject(forKey: "vehicle_value") as? String

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
		if basePremium != nil{
			aCoder.encode(basePremium, forKey: "base_premium")
		}
		if chassisNo != nil{
			aCoder.encode(chassisNo, forKey: "chassis_no")
		}
		if color != nil{
			aCoder.encode(color, forKey: "color")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if dailCode != nil{
			aCoder.encode(dailCode, forKey: "dail_code")
		}
		if dob != nil{
			aCoder.encode(dob, forKey: "dob")
		}
		if duration != nil{
			aCoder.encode(duration, forKey: "duration")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if engineNo != nil{
			aCoder.encode(engineNo, forKey: "engine_no")
		}
		if engineSize != nil{
			aCoder.encode(engineSize, forKey: "engine_size")
		}
		if fuelType != nil{
			aCoder.encode(fuelType, forKey: "fuel_type")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if modelYear != nil{
			aCoder.encode(modelYear, forKey: "model_year")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if phoneNo != nil{
			aCoder.encode(phoneNo, forKey: "phone_no")
		}
		if policyEndDate != nil{
			aCoder.encode(policyEndDate, forKey: "policy_end_date")
		}
		if policyId != nil{
			aCoder.encode(policyId, forKey: "policy_id")
		}
		if policyStartDate != nil{
			aCoder.encode(policyStartDate, forKey: "policy_start_date")
		}
		if totalPremium != nil{
			aCoder.encode(totalPremium, forKey: "total_premium")
		}
		if txnData != nil{
			aCoder.encode(txnData, forKey: "txn_data")
		}
		if txnId != nil{
			aCoder.encode(txnId, forKey: "txn_id")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}
		if vehicleAge != nil{
			aCoder.encode(vehicleAge, forKey: "vehicle_age")
		}
		if vehicleBrand != nil{
			aCoder.encode(vehicleBrand, forKey: "vehicle_brand")
		}
		if vehicleModel != nil{
			aCoder.encode(vehicleModel, forKey: "vehicle_model")
		}
		if vehicleNo != nil{
			aCoder.encode(vehicleNo, forKey: "vehicle_no")
		}
		if vehiclePlanId != nil{
			aCoder.encode(vehiclePlanId, forKey: "vehicle_plan_id")
		}
		if vehicleType != nil{
			aCoder.encode(vehicleType, forKey: "vehicle_type")
		}
		if vehicleValue != nil{
			aCoder.encode(vehicleValue, forKey: "vehicle_value")
		}

	}

}