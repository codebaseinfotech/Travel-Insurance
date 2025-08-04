//
//	TIReportTransectionStatu.swift
//
//	Create by Ankit Gabani on 18/9/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIReportTransectionStatu : NSObject, NSCoding{

	var createdAt : String!
	var id : Int!
	var status : String!
	var transactionDetailsId : Int!
	var updatedAt : String!
	var updatedOn : String!


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
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		status = dictionary["status"] as? String == nil ? "" : dictionary["status"] as? String
		transactionDetailsId = dictionary["transaction_details_id"] as? Int == nil ? 0 : dictionary["transaction_details_id"] as? Int
		updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
		updatedOn = dictionary["updated_on"] as? String == nil ? "" : dictionary["updated_on"] as? String
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
		if id != nil{
			dictionary["id"] = id
		}
		if status != nil{
			dictionary["status"] = status
		}
		if transactionDetailsId != nil{
			dictionary["transaction_details_id"] = transactionDetailsId
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if updatedOn != nil{
			dictionary["updated_on"] = updatedOn
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
         id = aDecoder.decodeObject(forKey: "id") as? Int
         status = aDecoder.decodeObject(forKey: "status") as? String
         transactionDetailsId = aDecoder.decodeObject(forKey: "transaction_details_id") as? Int
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         updatedOn = aDecoder.decodeObject(forKey: "updated_on") as? String

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
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if transactionDetailsId != nil{
			aCoder.encode(transactionDetailsId, forKey: "transaction_details_id")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if updatedOn != nil{
			aCoder.encode(updatedOn, forKey: "updated_on")
		}

	}

}