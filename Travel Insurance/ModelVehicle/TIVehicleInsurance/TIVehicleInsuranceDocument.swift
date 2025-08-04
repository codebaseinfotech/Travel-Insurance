//
//	TIVehicleInsuranceDocument.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIVehicleInsuranceDocument : NSObject, NSCoding{

	var createdAt : String!
	var document : String!
	var documentType : String!
	var id : Int!
	var type : String!
	var updatedAt : String!
	var vehicleInsuranceId : Int!


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
		document = dictionary["document"] as? String == nil ? "" : dictionary["document"] as? String
		documentType = dictionary["document_type"] as? String == nil ? "" : dictionary["document_type"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		type = dictionary["type"] as? String == nil ? "" : dictionary["type"] as? String
		updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
		vehicleInsuranceId = dictionary["vehicle_insurance_id"] as? Int == nil ? 0 : dictionary["vehicle_insurance_id"] as? Int
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
		if document != nil{
			dictionary["document"] = document
		}
		if documentType != nil{
			dictionary["document_type"] = documentType
		}
		if id != nil{
			dictionary["id"] = id
		}
		if type != nil{
			dictionary["type"] = type
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if vehicleInsuranceId != nil{
			dictionary["vehicle_insurance_id"] = vehicleInsuranceId
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
         document = aDecoder.decodeObject(forKey: "document") as? String
         documentType = aDecoder.decodeObject(forKey: "document_type") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         type = aDecoder.decodeObject(forKey: "type") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         vehicleInsuranceId = aDecoder.decodeObject(forKey: "vehicle_insurance_id") as? Int

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
		if document != nil{
			aCoder.encode(document, forKey: "document")
		}
		if documentType != nil{
			aCoder.encode(documentType, forKey: "document_type")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if vehicleInsuranceId != nil{
			aCoder.encode(vehicleInsuranceId, forKey: "vehicle_insurance_id")
		}

	}

}