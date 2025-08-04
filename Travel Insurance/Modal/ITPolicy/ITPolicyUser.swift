//
//	ITPolicyUser.swift
//
//	Create by iMac on 22/2/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ITPolicyUser : NSObject, NSCoding{

	var age : Int!
	var agentCode : String!
	var bloodGroup : String!
	var companyName : String!
	var companyType : String!
	var createdAt : String!
	var dateOfBirth : String!
	var deletedAt : String!
	var deviceToken : String!
	var email : String!
	var emailVerifiedAt : String!
	var entitlement : String!
	var firstName : String!
	var gender : String!
	var image : String!
	var imagePath : String!
	var isOtpVerified : Int!
	var mobileNumber : String!
	var name : String!
	var nationality : String!
	var otp : String!
	var otpForgot : String!
	var roleId : Int!
	var slug : String!
	var status : String!
	var termsCheck : Int!
	var updatedAt : String!
	var username : String!


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
		age = dictionary["age"] as? Int == nil ? 0 : dictionary["age"] as? Int
		agentCode = dictionary["agent_code"] as? String == nil ? "" : dictionary["agent_code"] as? String
		bloodGroup = dictionary["blood_group"] as? String == nil ? "" : dictionary["blood_group"] as? String
		companyName = dictionary["company_name"] as? String == nil ? "" : dictionary["company_name"] as? String
		companyType = dictionary["company_type"] as? String == nil ? "" : dictionary["company_type"] as? String
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		dateOfBirth = dictionary["date_of_birth"] as? String == nil ? "" : dictionary["date_of_birth"] as? String
		deletedAt = dictionary["deleted_at"] as? String == nil ? "" : dictionary["deleted_at"] as? String
		deviceToken = dictionary["device_token"] as? String == nil ? "" : dictionary["device_token"] as? String
		email = dictionary["email"] as? String == nil ? "" : dictionary["email"] as? String
		emailVerifiedAt = dictionary["email_verified_at"] as? String == nil ? "" : dictionary["email_verified_at"] as? String
		entitlement = dictionary["entitlement"] as? String == nil ? "" : dictionary["entitlement"] as? String
		firstName = dictionary["first_name"] as? String == nil ? "" : dictionary["first_name"] as? String
		gender = dictionary["gender"] as? String == nil ? "" : dictionary["gender"] as? String
		image = dictionary["image"] as? String == nil ? "" : dictionary["image"] as? String
		imagePath = dictionary["image_path"] as? String == nil ? "" : dictionary["image_path"] as? String
		isOtpVerified = dictionary["is_otp_verified"] as? Int == nil ? 0 : dictionary["is_otp_verified"] as? Int
		mobileNumber = dictionary["mobile_number"] as? String == nil ? "" : dictionary["mobile_number"] as? String
		name = dictionary["name"] as? String == nil ? "" : dictionary["name"] as? String
		nationality = dictionary["nationality"] as? String == nil ? "" : dictionary["nationality"] as? String
		otp = dictionary["otp"] as? String == nil ? "" : dictionary["otp"] as? String
		otpForgot = dictionary["otp_forgot"] as? String == nil ? "" : dictionary["otp_forgot"] as? String
		roleId = dictionary["role_id"] as? Int == nil ? 0 : dictionary["role_id"] as? Int
		slug = dictionary["slug"] as? String == nil ? "" : dictionary["slug"] as? String
		status = dictionary["status"] as? String == nil ? "" : dictionary["status"] as? String
		termsCheck = dictionary["termsCheck"] as? Int == nil ? 0 : dictionary["termsCheck"] as? Int
		updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
		username = dictionary["username"] as? String == nil ? "" : dictionary["username"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if age != nil{
			dictionary["age"] = age
		}
		if agentCode != nil{
			dictionary["agent_code"] = agentCode
		}
		if bloodGroup != nil{
			dictionary["blood_group"] = bloodGroup
		}
		if companyName != nil{
			dictionary["company_name"] = companyName
		}
		if companyType != nil{
			dictionary["company_type"] = companyType
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if dateOfBirth != nil{
			dictionary["date_of_birth"] = dateOfBirth
		}
		if deletedAt != nil{
			dictionary["deleted_at"] = deletedAt
		}
		if deviceToken != nil{
			dictionary["device_token"] = deviceToken
		}
		if email != nil{
			dictionary["email"] = email
		}
		if emailVerifiedAt != nil{
			dictionary["email_verified_at"] = emailVerifiedAt
		}
		if entitlement != nil{
			dictionary["entitlement"] = entitlement
		}
		if firstName != nil{
			dictionary["first_name"] = firstName
		}
		if gender != nil{
			dictionary["gender"] = gender
		}
		if image != nil{
			dictionary["image"] = image
		}
		if imagePath != nil{
			dictionary["image_path"] = imagePath
		}
		if isOtpVerified != nil{
			dictionary["is_otp_verified"] = isOtpVerified
		}
		if mobileNumber != nil{
			dictionary["mobile_number"] = mobileNumber
		}
		if name != nil{
			dictionary["name"] = name
		}
		if nationality != nil{
			dictionary["nationality"] = nationality
		}
		if otp != nil{
			dictionary["otp"] = otp
		}
		if otpForgot != nil{
			dictionary["otp_forgot"] = otpForgot
		}
		if roleId != nil{
			dictionary["role_id"] = roleId
		}
		if slug != nil{
			dictionary["slug"] = slug
		}
		if status != nil{
			dictionary["status"] = status
		}
		if termsCheck != nil{
			dictionary["termsCheck"] = termsCheck
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if username != nil{
			dictionary["username"] = username
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         age = aDecoder.decodeObject(forKey: "age") as? Int
         agentCode = aDecoder.decodeObject(forKey: "agent_code") as? String
         bloodGroup = aDecoder.decodeObject(forKey: "blood_group") as? String
         companyName = aDecoder.decodeObject(forKey: "company_name") as? String
         companyType = aDecoder.decodeObject(forKey: "company_type") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         dateOfBirth = aDecoder.decodeObject(forKey: "date_of_birth") as? String
         deletedAt = aDecoder.decodeObject(forKey: "deleted_at") as? String
         deviceToken = aDecoder.decodeObject(forKey: "device_token") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         emailVerifiedAt = aDecoder.decodeObject(forKey: "email_verified_at") as? String
         entitlement = aDecoder.decodeObject(forKey: "entitlement") as? String
         firstName = aDecoder.decodeObject(forKey: "first_name") as? String
         gender = aDecoder.decodeObject(forKey: "gender") as? String
         image = aDecoder.decodeObject(forKey: "image") as? String
         imagePath = aDecoder.decodeObject(forKey: "image_path") as? String
         isOtpVerified = aDecoder.decodeObject(forKey: "is_otp_verified") as? Int
         mobileNumber = aDecoder.decodeObject(forKey: "mobile_number") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         nationality = aDecoder.decodeObject(forKey: "nationality") as? String
         otp = aDecoder.decodeObject(forKey: "otp") as? String
         otpForgot = aDecoder.decodeObject(forKey: "otp_forgot") as? String
         roleId = aDecoder.decodeObject(forKey: "role_id") as? Int
         slug = aDecoder.decodeObject(forKey: "slug") as? String
         status = aDecoder.decodeObject(forKey: "status") as? String
         termsCheck = aDecoder.decodeObject(forKey: "termsCheck") as? Int
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         username = aDecoder.decodeObject(forKey: "username") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if age != nil{
			aCoder.encode(age, forKey: "age")
		}
		if agentCode != nil{
			aCoder.encode(agentCode, forKey: "agent_code")
		}
		if bloodGroup != nil{
			aCoder.encode(bloodGroup, forKey: "blood_group")
		}
		if companyName != nil{
			aCoder.encode(companyName, forKey: "company_name")
		}
		if companyType != nil{
			aCoder.encode(companyType, forKey: "company_type")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if dateOfBirth != nil{
			aCoder.encode(dateOfBirth, forKey: "date_of_birth")
		}
		if deletedAt != nil{
			aCoder.encode(deletedAt, forKey: "deleted_at")
		}
		if deviceToken != nil{
			aCoder.encode(deviceToken, forKey: "device_token")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if emailVerifiedAt != nil{
			aCoder.encode(emailVerifiedAt, forKey: "email_verified_at")
		}
		if entitlement != nil{
			aCoder.encode(entitlement, forKey: "entitlement")
		}
		if firstName != nil{
			aCoder.encode(firstName, forKey: "first_name")
		}
		if gender != nil{
			aCoder.encode(gender, forKey: "gender")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if imagePath != nil{
			aCoder.encode(imagePath, forKey: "image_path")
		}
		if isOtpVerified != nil{
			aCoder.encode(isOtpVerified, forKey: "is_otp_verified")
		}
		if mobileNumber != nil{
			aCoder.encode(mobileNumber, forKey: "mobile_number")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if nationality != nil{
			aCoder.encode(nationality, forKey: "nationality")
		}
		if otp != nil{
			aCoder.encode(otp, forKey: "otp")
		}
		if otpForgot != nil{
			aCoder.encode(otpForgot, forKey: "otp_forgot")
		}
		if roleId != nil{
			aCoder.encode(roleId, forKey: "role_id")
		}
		if slug != nil{
			aCoder.encode(slug, forKey: "slug")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if termsCheck != nil{
			aCoder.encode(termsCheck, forKey: "termsCheck")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if username != nil{
			aCoder.encode(username, forKey: "username")
		}

	}

}