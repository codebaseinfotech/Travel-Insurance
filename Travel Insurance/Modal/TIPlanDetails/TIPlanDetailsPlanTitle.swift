//
//	TIPlanDetailsPlanTitle.swift
//
//	Create by Ankit Gabani on 29/7/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIPlanDetailsPlanTitle : NSObject, NSCoding{

	var createdAt : String!
	var planBenefits : [TIPlanDetailsPlanBenefit]!
	var planId : Int!
	var planImage : String!
	var planTitle : String!
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
		planBenefits = [TIPlanDetailsPlanBenefit]()
		if let planBenefitsArray = dictionary["plan_benefits"] as? [NSDictionary]{
			for dic in planBenefitsArray{
				let value = TIPlanDetailsPlanBenefit(fromDictionary: dic)
				planBenefits.append(value)
			}
		}
		planId = dictionary["plan_id"] as? Int == nil ? 0 : dictionary["plan_id"] as? Int
		planImage = dictionary["plan_image"] as? String == nil ? "" : dictionary["plan_image"] as? String
		planTitle = dictionary["plan_title"] as? String == nil ? "" : dictionary["plan_title"] as? String
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
		if planBenefits != nil{
			var dictionaryElements = [NSDictionary]()
			for planBenefitsElement in planBenefits {
				dictionaryElements.append(planBenefitsElement.toDictionary())
			}
			dictionary["plan_benefits"] = dictionaryElements
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
         planBenefits = aDecoder.decodeObject(forKey: "plan_benefits") as? [TIPlanDetailsPlanBenefit]
         planId = aDecoder.decodeObject(forKey: "plan_id") as? Int
         planImage = aDecoder.decodeObject(forKey: "plan_image") as? String
         planTitle = aDecoder.decodeObject(forKey: "plan_title") as? String
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
		if planBenefits != nil{
			aCoder.encode(planBenefits, forKey: "plan_benefits")
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