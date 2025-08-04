//
//	TIPlanPeriodData.swift
//
//	Create by Ankit Gabani on 29/7/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIPlanPeriodData : NSObject, NSCoding{

	var createdAt : String!
	var createdBy : String!
	var days : Int!
	var deletedAt : String!
	var endDate : String!
	var insurancePeriod : String!
	var insurancePeriodId : Int!
	var planTypeCategory : String!
	var slug : String!
	var startDate : String!
	var status : Int!
	var updatedAt : String!
	var updatedBy : String!


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
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		createdBy = dictionary["created_by"] as? String == nil ? "" : dictionary["created_by"] as? String
		days = dictionary["days"] as? Int == nil ? 0 : dictionary["days"] as? Int
		deletedAt = dictionary["deleted_at"] as? String == nil ? "" : dictionary["deleted_at"] as? String
		endDate = dictionary["end_date"] as? String == nil ? "" : dictionary["end_date"] as? String
		insurancePeriod = dictionary["insurance_period"] as? String == nil ? "" : dictionary["insurance_period"] as? String
		insurancePeriodId = dictionary["insurance_period_id"] as? Int == nil ? 0 : dictionary["insurance_period_id"] as? Int
		planTypeCategory = dictionary["plan_type_category"] as? String == nil ? "" : dictionary["plan_type_category"] as? String
		slug = dictionary["slug"] as? String == nil ? "" : dictionary["slug"] as? String
		startDate = dictionary["start_date"] as? String == nil ? "" : dictionary["start_date"] as? String
		status = dictionary["status"] as? Int == nil ? 0 : dictionary["status"] as? Int
		updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
		updatedBy = dictionary["updated_by"] as? String == nil ? "" : dictionary["updated_by"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if createdBy != nil{
			dictionary["created_by"] = createdBy
		}
		if days != nil{
			dictionary["days"] = days
		}
		if deletedAt != nil{
			dictionary["deleted_at"] = deletedAt
		}
		if endDate != nil{
			dictionary["end_date"] = endDate
		}
		if insurancePeriod != nil{
			dictionary["insurance_period"] = insurancePeriod
		}
		if insurancePeriodId != nil{
			dictionary["insurance_period_id"] = insurancePeriodId
		}
		if planTypeCategory != nil{
			dictionary["plan_type_category"] = planTypeCategory
		}
		if slug != nil{
			dictionary["slug"] = slug
		}
		if startDate != nil{
			dictionary["start_date"] = startDate
		}
		if status != nil{
			dictionary["status"] = status
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if updatedBy != nil{
			dictionary["updated_by"] = updatedBy
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         createdBy = aDecoder.decodeObject(forKey: "created_by") as? String
         days = aDecoder.decodeObject(forKey: "days") as? Int
         deletedAt = aDecoder.decodeObject(forKey: "deleted_at") as? String
         endDate = aDecoder.decodeObject(forKey: "end_date") as? String
         insurancePeriod = aDecoder.decodeObject(forKey: "insurance_period") as? String
         insurancePeriodId = aDecoder.decodeObject(forKey: "insurance_period_id") as? Int
         planTypeCategory = aDecoder.decodeObject(forKey: "plan_type_category") as? String
         slug = aDecoder.decodeObject(forKey: "slug") as? String
         startDate = aDecoder.decodeObject(forKey: "start_date") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Int
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         updatedBy = aDecoder.decodeObject(forKey: "updated_by") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if createdBy != nil{
			aCoder.encode(createdBy, forKey: "created_by")
		}
		if days != nil{
			aCoder.encode(days, forKey: "days")
		}
		if deletedAt != nil{
			aCoder.encode(deletedAt, forKey: "deleted_at")
		}
		if endDate != nil{
			aCoder.encode(endDate, forKey: "end_date")
		}
		if insurancePeriod != nil{
			aCoder.encode(insurancePeriod, forKey: "insurance_period")
		}
		if insurancePeriodId != nil{
			aCoder.encode(insurancePeriodId, forKey: "insurance_period_id")
		}
		if planTypeCategory != nil{
			aCoder.encode(planTypeCategory, forKey: "plan_type_category")
		}
		if slug != nil{
			aCoder.encode(slug, forKey: "slug")
		}
		if startDate != nil{
			aCoder.encode(startDate, forKey: "start_date")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if updatedBy != nil{
			aCoder.encode(updatedBy, forKey: "updated_by")
		}

	}

}