//
//	ITPolicyUserinsurance.swift
//
//	Create by iMac on 22/2/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ITPolicyUserinsurance : NSObject, NSCoding{

	var address : String!
	var age : Int!
	var agentCode : String!
	var createdAt : String!
	var dateOfBirth : String!
	var destination : String!
	var email : String!
	var formSteps : Int!
	var fullName : String!
	var gender : String!
	var insuranceId : Int!
	var maritalStatus : String!
	var mobileNumber : String!
	var nationality : String!
	var orderId : String!
	var passportCopy : String!
	var passportNumber : String!
	var paymentStatus : Int!
	var policyNo : String!
	var price : Int!
	var roleId : Int!
	var slug : String!
	var status : String!
	var transactionDetailsId : Int!
	var user : ITPolicyUser!


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
		address = dictionary["address"] as? String == nil ? "" : dictionary["address"] as? String
		age = dictionary["age"] as? Int == nil ? 0 : dictionary["age"] as? Int
		agentCode = dictionary["agent_code"] as? String == nil ? "" : dictionary["agent_code"] as? String
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		dateOfBirth = dictionary["date_of_birth"] as? String == nil ? "" : dictionary["date_of_birth"] as? String
		destination = dictionary["destination"] as? String == nil ? "" : dictionary["destination"] as? String
		email = dictionary["email"] as? String == nil ? "" : dictionary["email"] as? String
		formSteps = dictionary["form_steps"] as? Int == nil ? 0 : dictionary["form_steps"] as? Int
		fullName = dictionary["full_name"] as? String == nil ? "" : dictionary["full_name"] as? String
		gender = dictionary["gender"] as? String == nil ? "" : dictionary["gender"] as? String
		insuranceId = dictionary["insurance_id"] as? Int == nil ? 0 : dictionary["insurance_id"] as? Int
		maritalStatus = dictionary["marital_status"] as? String == nil ? "" : dictionary["marital_status"] as? String
		mobileNumber = dictionary["mobile_number"] as? String == nil ? "" : dictionary["mobile_number"] as? String
		nationality = dictionary["nationality"] as? String == nil ? "" : dictionary["nationality"] as? String
		orderId = dictionary["order_id"] as? String == nil ? "" : dictionary["order_id"] as? String
		passportCopy = dictionary["passport_copy"] as? String == nil ? "" : dictionary["passport_copy"] as? String
		passportNumber = dictionary["passport_number"] as? String == nil ? "" : dictionary["passport_number"] as? String
		paymentStatus = dictionary["payment_status"] as? Int == nil ? 0 : dictionary["payment_status"] as? Int
		policyNo = dictionary["policy_no"] as? String == nil ? "" : dictionary["policy_no"] as? String
		price = dictionary["price"] as? Int == nil ? 0 : dictionary["price"] as? Int
		roleId = dictionary["role_id"] as? Int == nil ? 0 : dictionary["role_id"] as? Int
		slug = dictionary["slug"] as? String == nil ? "" : dictionary["slug"] as? String
		status = dictionary["status"] as? String == nil ? "" : dictionary["status"] as? String
		transactionDetailsId = dictionary["transaction_details_id"] as? Int == nil ? 0 : dictionary["transaction_details_id"] as? Int
		if let userData = dictionary["user"] as? NSDictionary{
			user = ITPolicyUser(fromDictionary: userData)
		}
		else
		{
			user = ITPolicyUser(fromDictionary: NSDictionary.init())
		}
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if address != nil{
			dictionary["address"] = address
		}
		if age != nil{
			dictionary["age"] = age
		}
		if agentCode != nil{
			dictionary["agent_code"] = agentCode
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if dateOfBirth != nil{
			dictionary["date_of_birth"] = dateOfBirth
		}
		if destination != nil{
			dictionary["destination"] = destination
		}
		if email != nil{
			dictionary["email"] = email
		}
		if formSteps != nil{
			dictionary["form_steps"] = formSteps
		}
		if fullName != nil{
			dictionary["full_name"] = fullName
		}
		if gender != nil{
			dictionary["gender"] = gender
		}
		if insuranceId != nil{
			dictionary["insurance_id"] = insuranceId
		}
		if maritalStatus != nil{
			dictionary["marital_status"] = maritalStatus
		}
		if mobileNumber != nil{
			dictionary["mobile_number"] = mobileNumber
		}
		if nationality != nil{
			dictionary["nationality"] = nationality
		}
		if orderId != nil{
			dictionary["order_id"] = orderId
		}
		if passportCopy != nil{
			dictionary["passport_copy"] = passportCopy
		}
		if passportNumber != nil{
			dictionary["passport_number"] = passportNumber
		}
		if paymentStatus != nil{
			dictionary["payment_status"] = paymentStatus
		}
		if policyNo != nil{
			dictionary["policy_no"] = policyNo
		}
		if price != nil{
			dictionary["price"] = price
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
		if transactionDetailsId != nil{
			dictionary["transaction_details_id"] = transactionDetailsId
		}
		if user != nil{
			dictionary["user"] = user.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         address = aDecoder.decodeObject(forKey: "address") as? String
         age = aDecoder.decodeObject(forKey: "age") as? Int
         agentCode = aDecoder.decodeObject(forKey: "agent_code") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         dateOfBirth = aDecoder.decodeObject(forKey: "date_of_birth") as? String
         destination = aDecoder.decodeObject(forKey: "destination") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         formSteps = aDecoder.decodeObject(forKey: "form_steps") as? Int
         fullName = aDecoder.decodeObject(forKey: "full_name") as? String
         gender = aDecoder.decodeObject(forKey: "gender") as? String
         insuranceId = aDecoder.decodeObject(forKey: "insurance_id") as? Int
         maritalStatus = aDecoder.decodeObject(forKey: "marital_status") as? String
         mobileNumber = aDecoder.decodeObject(forKey: "mobile_number") as? String
         nationality = aDecoder.decodeObject(forKey: "nationality") as? String
         orderId = aDecoder.decodeObject(forKey: "order_id") as? String
         passportCopy = aDecoder.decodeObject(forKey: "passport_copy") as? String
         passportNumber = aDecoder.decodeObject(forKey: "passport_number") as? String
         paymentStatus = aDecoder.decodeObject(forKey: "payment_status") as? Int
         policyNo = aDecoder.decodeObject(forKey: "policy_no") as? String
         price = aDecoder.decodeObject(forKey: "price") as? Int
         roleId = aDecoder.decodeObject(forKey: "role_id") as? Int
         slug = aDecoder.decodeObject(forKey: "slug") as? String
         status = aDecoder.decodeObject(forKey: "status") as? String
         transactionDetailsId = aDecoder.decodeObject(forKey: "transaction_details_id") as? Int
         user = aDecoder.decodeObject(forKey: "user") as? ITPolicyUser

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if address != nil{
			aCoder.encode(address, forKey: "address")
		}
		if age != nil{
			aCoder.encode(age, forKey: "age")
		}
		if agentCode != nil{
			aCoder.encode(agentCode, forKey: "agent_code")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if dateOfBirth != nil{
			aCoder.encode(dateOfBirth, forKey: "date_of_birth")
		}
		if destination != nil{
			aCoder.encode(destination, forKey: "destination")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if formSteps != nil{
			aCoder.encode(formSteps, forKey: "form_steps")
		}
		if fullName != nil{
			aCoder.encode(fullName, forKey: "full_name")
		}
		if gender != nil{
			aCoder.encode(gender, forKey: "gender")
		}
		if insuranceId != nil{
			aCoder.encode(insuranceId, forKey: "insurance_id")
		}
		if maritalStatus != nil{
			aCoder.encode(maritalStatus, forKey: "marital_status")
		}
		if mobileNumber != nil{
			aCoder.encode(mobileNumber, forKey: "mobile_number")
		}
		if nationality != nil{
			aCoder.encode(nationality, forKey: "nationality")
		}
		if orderId != nil{
			aCoder.encode(orderId, forKey: "order_id")
		}
		if passportCopy != nil{
			aCoder.encode(passportCopy, forKey: "passport_copy")
		}
		if passportNumber != nil{
			aCoder.encode(passportNumber, forKey: "passport_number")
		}
		if paymentStatus != nil{
			aCoder.encode(paymentStatus, forKey: "payment_status")
		}
		if policyNo != nil{
			aCoder.encode(policyNo, forKey: "policy_no")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
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
		if transactionDetailsId != nil{
			aCoder.encode(transactionDetailsId, forKey: "transaction_details_id")
		}
		if user != nil{
			aCoder.encode(user, forKey: "user")
		}

	}

}