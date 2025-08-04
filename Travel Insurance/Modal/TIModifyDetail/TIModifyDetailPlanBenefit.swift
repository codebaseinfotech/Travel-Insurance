//
//	TIModifyDetailPlanBenefit.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIModifyDetailPlanBenefit : NSObject, NSCoding{

	var createdAt : String!
	var planCoverage : String!
	var planDescription : String!
	var planId : Int!
	var planImage : String!
	var planTitle : String!
	var planTitleId : Int!
	var slug : String!
	var status : String!
	var updatedAt : String!


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
		planCoverage = dictionary["plan_coverage"] as? String == nil ? "" : dictionary["plan_coverage"] as? String
		planDescription = dictionary["plan_description"] as? String == nil ? "" : dictionary["plan_description"] as? String
		planId = dictionary["plan_id"] as? Int == nil ? 0 : dictionary["plan_id"] as? Int
		planImage = dictionary["plan_image"] as? String == nil ? "" : dictionary["plan_image"] as? String
		planTitle = dictionary["plan_title"] as? String == nil ? "" : dictionary["plan_title"] as? String
		planTitleId = dictionary["plan_title_id"] as? Int == nil ? 0 : dictionary["plan_title_id"] as? Int
		slug = dictionary["slug"] as? String == nil ? "" : dictionary["slug"] as? String
		status = dictionary["status"] as? String == nil ? "" : dictionary["status"] as? String
		updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
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
		if planCoverage != nil{
			dictionary["plan_coverage"] = planCoverage
		}
		if planDescription != nil{
			dictionary["plan_description"] = planDescription
		}
		if planId != nil{
			dictionary["plan_id"] = planId
		}
		if planImage != nil{
			dictionary["plan_image"] = planImage
		}
		if planTitle != nil{
			dictionary["plan_title"] = planTitle
		}
		if planTitleId != nil{
			dictionary["plan_title_id"] = planTitleId
		}
		if slug != nil{
			dictionary["slug"] = slug
		}
		if status != nil{
			dictionary["status"] = status
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
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
         planCoverage = aDecoder.decodeObject(forKey: "plan_coverage") as? String
         planDescription = aDecoder.decodeObject(forKey: "plan_description") as? String
         planId = aDecoder.decodeObject(forKey: "plan_id") as? Int
         planImage = aDecoder.decodeObject(forKey: "plan_image") as? String
         planTitle = aDecoder.decodeObject(forKey: "plan_title") as? String
         planTitleId = aDecoder.decodeObject(forKey: "plan_title_id") as? Int
         slug = aDecoder.decodeObject(forKey: "slug") as? String
         status = aDecoder.decodeObject(forKey: "status") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String

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
		if planCoverage != nil{
			aCoder.encode(planCoverage, forKey: "plan_coverage")
		}
		if planDescription != nil{
			aCoder.encode(planDescription, forKey: "plan_description")
		}
		if planId != nil{
			aCoder.encode(planId, forKey: "plan_id")
		}
		if planImage != nil{
			aCoder.encode(planImage, forKey: "plan_image")
		}
		if planTitle != nil{
			aCoder.encode(planTitle, forKey: "plan_title")
		}
		if planTitleId != nil{
			aCoder.encode(planTitleId, forKey: "plan_title_id")
		}
		if slug != nil{
			aCoder.encode(slug, forKey: "slug")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}

	}

}