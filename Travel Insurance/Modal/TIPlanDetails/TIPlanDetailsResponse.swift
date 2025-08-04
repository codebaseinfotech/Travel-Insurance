//
//	TIPlanDetailsResponse.swift
//
//	Create by Ankit Gabani on 29/7/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIPlanDetailsResponse : NSObject, NSCoding{

	var categoryArr : [TIPlanDetailsCategoryArr]!
	var createdAt : String!
	var maxDays : Int!
	var planFeatures : [String]!
	var planId : Int!
	var planImage : String!
	var planTitles : [TIPlanDetailsPlanTitle]!
	var planType : String!
	var planTypeCategory : TIPlanDetailsPlanTypeCategory!
	var planTypeDescription : String!
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
		categoryArr = [TIPlanDetailsCategoryArr]()
		if let categoryArrArray = dictionary["category_arr"] as? [NSDictionary]{
			for dic in categoryArrArray{
				let value = TIPlanDetailsCategoryArr(fromDictionary: dic)
				categoryArr.append(value)
			}
		}
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		maxDays = dictionary["max_days"] as? Int == nil ? 0 : dictionary["max_days"] as? Int
		planFeatures = dictionary["plan_features"] as? [String] == nil ? [] : dictionary["plan_features"] as? [String]
		planId = dictionary["plan_id"] as? Int == nil ? 0 : dictionary["plan_id"] as? Int
		planImage = dictionary["plan_image"] as? String == nil ? "" : dictionary["plan_image"] as? String
		planTitles = [TIPlanDetailsPlanTitle]()
		if let planTitlesArray = dictionary["plan_titles"] as? [NSDictionary]{
			for dic in planTitlesArray{
				let value = TIPlanDetailsPlanTitle(fromDictionary: dic)
				planTitles.append(value)
			}
		}
		planType = dictionary["plan_type"] as? String == nil ? "" : dictionary["plan_type"] as? String
		if let planTypeCategoryData = dictionary["plan_type_category"] as? NSDictionary{
			planTypeCategory = TIPlanDetailsPlanTypeCategory(fromDictionary: planTypeCategoryData)
		}
		else
		{
			planTypeCategory = TIPlanDetailsPlanTypeCategory(fromDictionary: NSDictionary.init())
		}
		planTypeDescription = dictionary["plan_type_description"] as? String == nil ? "" : dictionary["plan_type_description"] as? String
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
		if categoryArr != nil{
			var dictionaryElements = [NSDictionary]()
			for categoryArrElement in categoryArr {
				dictionaryElements.append(categoryArrElement.toDictionary())
			}
			dictionary["category_arr"] = dictionaryElements
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if maxDays != nil{
			dictionary["max_days"] = maxDays
		}
		if planFeatures != nil{
			dictionary["plan_features"] = planFeatures
		}
		if planId != nil{
			dictionary["plan_id"] = planId
		}
		if planImage != nil{
			dictionary["plan_image"] = planImage
		}
		if planTitles != nil{
			var dictionaryElements = [NSDictionary]()
			for planTitlesElement in planTitles {
				dictionaryElements.append(planTitlesElement.toDictionary())
			}
			dictionary["plan_titles"] = dictionaryElements
		}
		if planType != nil{
			dictionary["plan_type"] = planType
		}
		if planTypeCategory != nil{
			dictionary["plan_type_category"] = planTypeCategory.toDictionary()
		}
		if planTypeDescription != nil{
			dictionary["plan_type_description"] = planTypeDescription
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
         categoryArr = aDecoder.decodeObject(forKey: "category_arr") as? [TIPlanDetailsCategoryArr]
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         maxDays = aDecoder.decodeObject(forKey: "max_days") as? Int
         planFeatures = aDecoder.decodeObject(forKey: "plan_features") as? [String]
         planId = aDecoder.decodeObject(forKey: "plan_id") as? Int
         planImage = aDecoder.decodeObject(forKey: "plan_image") as? String
         planTitles = aDecoder.decodeObject(forKey: "plan_titles") as? [TIPlanDetailsPlanTitle]
         planType = aDecoder.decodeObject(forKey: "plan_type") as? String
         planTypeCategory = aDecoder.decodeObject(forKey: "plan_type_category") as? TIPlanDetailsPlanTypeCategory
         planTypeDescription = aDecoder.decodeObject(forKey: "plan_type_description") as? String
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
		if categoryArr != nil{
			aCoder.encode(categoryArr, forKey: "category_arr")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if maxDays != nil{
			aCoder.encode(maxDays, forKey: "max_days")
		}
		if planFeatures != nil{
			aCoder.encode(planFeatures, forKey: "plan_features")
		}
		if planId != nil{
			aCoder.encode(planId, forKey: "plan_id")
		}
		if planImage != nil{
			aCoder.encode(planImage, forKey: "plan_image")
		}
		if planTitles != nil{
			aCoder.encode(planTitles, forKey: "plan_titles")
		}
		if planType != nil{
			aCoder.encode(planType, forKey: "plan_type")
		}
		if planTypeCategory != nil{
			aCoder.encode(planTypeCategory, forKey: "plan_type_category")
		}
		if planTypeDescription != nil{
			aCoder.encode(planTypeDescription, forKey: "plan_type_description")
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
