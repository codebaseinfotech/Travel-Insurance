//
//	TIClaimVehicle.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIClaimVehicle : NSObject, NSCoding{

	var claimDate : String!
	var claimDescription : String!
	var claimId : String!
	var claimImages : String!
	var claimType : String!
	var createdAt : String!
	var id : Int!
	var policeReportDocument : String!
	var status : String!
	var updatedAt : String!
	var vehicleDetails : TIClaimVehicleDetail!
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
		claimDate = dictionary["claim_date"] as? String == nil ? "" : dictionary["claim_date"] as? String
		claimDescription = dictionary["claim_description"] as? String == nil ? "" : dictionary["claim_description"] as? String
		claimId = dictionary["claim_id"] as? String == nil ? "" : dictionary["claim_id"] as? String
		claimImages = dictionary["claim_images"] as? String == nil ? "" : dictionary["claim_images"] as? String
		claimType = dictionary["claim_type"] as? String == nil ? "" : dictionary["claim_type"] as? String
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		policeReportDocument = dictionary["police_report_document"] as? String == nil ? "" : dictionary["police_report_document"] as? String
		status = dictionary["status"] as? String == nil ? "" : dictionary["status"] as? String
		updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
		if let vehicleDetailsData = dictionary["vehicle_details"] as? NSDictionary{
			vehicleDetails = TIClaimVehicleDetail(fromDictionary: vehicleDetailsData)
		}
		else
		{
			vehicleDetails = TIClaimVehicleDetail(fromDictionary: NSDictionary.init())
		}
		vehicleInsuranceId = dictionary["vehicle_insurance_id"] as? Int == nil ? 0 : dictionary["vehicle_insurance_id"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if claimDate != nil{
			dictionary["claim_date"] = claimDate
		}
		if claimDescription != nil{
			dictionary["claim_description"] = claimDescription
		}
		if claimId != nil{
			dictionary["claim_id"] = claimId
		}
		if claimImages != nil{
			dictionary["claim_images"] = claimImages
		}
		if claimType != nil{
			dictionary["claim_type"] = claimType
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if id != nil{
			dictionary["id"] = id
		}
		if policeReportDocument != nil{
			dictionary["police_report_document"] = policeReportDocument
		}
		if status != nil{
			dictionary["status"] = status
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if vehicleDetails != nil{
			dictionary["vehicle_details"] = vehicleDetails.toDictionary()
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
         claimDate = aDecoder.decodeObject(forKey: "claim_date") as? String
         claimDescription = aDecoder.decodeObject(forKey: "claim_description") as? String
         claimId = aDecoder.decodeObject(forKey: "claim_id") as? String
         claimImages = aDecoder.decodeObject(forKey: "claim_images") as? String
         claimType = aDecoder.decodeObject(forKey: "claim_type") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         policeReportDocument = aDecoder.decodeObject(forKey: "police_report_document") as? String
         status = aDecoder.decodeObject(forKey: "status") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         vehicleDetails = aDecoder.decodeObject(forKey: "vehicle_details") as? TIClaimVehicleDetail
         vehicleInsuranceId = aDecoder.decodeObject(forKey: "vehicle_insurance_id") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if claimDate != nil{
			aCoder.encode(claimDate, forKey: "claim_date")
		}
		if claimDescription != nil{
			aCoder.encode(claimDescription, forKey: "claim_description")
		}
		if claimId != nil{
			aCoder.encode(claimId, forKey: "claim_id")
		}
		if claimImages != nil{
			aCoder.encode(claimImages, forKey: "claim_images")
		}
		if claimType != nil{
			aCoder.encode(claimType, forKey: "claim_type")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if policeReportDocument != nil{
			aCoder.encode(policeReportDocument, forKey: "police_report_document")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if vehicleDetails != nil{
			aCoder.encode(vehicleDetails, forKey: "vehicle_details")
		}
		if vehicleInsuranceId != nil{
			aCoder.encode(vehicleInsuranceId, forKey: "vehicle_insurance_id")
		}

	}

}