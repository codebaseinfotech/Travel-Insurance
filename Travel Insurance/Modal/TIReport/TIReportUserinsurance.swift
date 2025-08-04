//
//	TIReportUserinsurance.swift
//
//	Create by Ankit Gabani on 18/9/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIReportUserinsurance : NSObject, NSCoding{

	var address : String!
	var age : Int!
	var agentCode : String!
	var borderEntry : String!
	var convertedAmount : String!
	var countryCode : String!
	var createdAt : String!
	var currency : String!
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
	var optionalCountryCode : String!
	var optionalMobileNo : String!
	var orderId : String!
	var passportCopy : String!
	var passportNumber : String!
	var paymentStatus : Int!
	var policyNo : String!
	var price : Int!
	var residenceDate : String!
	var residenceDuration : String!
	var residenceNo : String!
	var residenceReason : String!
	var roleId : Int!
	var slug : String!
	var status : String!
	var transactionDetailsId : Int!
	var user : TIReportAgent!
	var visaType : String!
	var visitType : String!
    var zone : String!
    var diwan_tax : String!
    var diwan_tax_percent : String!
    var single_price : String!
    var agent_commision : String!
	var agent_commision_percent : String!


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
		borderEntry = dictionary["border_entry"] as? String == nil ? "" : dictionary["border_entry"] as? String
		convertedAmount = dictionary["convertedAmount"] as? String == nil ? "" : dictionary["convertedAmount"] as? String
		countryCode = dictionary["country_code"] as? String == nil ? "" : dictionary["country_code"] as? String
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		currency = dictionary["currency"] as? String == nil ? "" : dictionary["currency"] as? String
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
		optionalCountryCode = dictionary["optional_country_code"] as? String == nil ? "" : dictionary["optional_country_code"] as? String
		optionalMobileNo = dictionary["optional_mobile_no"] as? String == nil ? "" : dictionary["optional_mobile_no"] as? String
		orderId = dictionary["order_id"] as? String == nil ? "" : dictionary["order_id"] as? String
		passportCopy = dictionary["passport_copy"] as? String == nil ? "" : dictionary["passport_copy"] as? String
		passportNumber = dictionary["passport_number"] as? String == nil ? "" : dictionary["passport_number"] as? String
		paymentStatus = dictionary["payment_status"] as? Int == nil ? 0 : dictionary["payment_status"] as? Int
		policyNo = dictionary["policy_no"] as? String == nil ? "" : dictionary["policy_no"] as? String
		price = dictionary["price"] as? Int == nil ? 0 : dictionary["price"] as? Int
		residenceDate = dictionary["residence_date"] as? String == nil ? "" : dictionary["residence_date"] as? String
		residenceDuration = dictionary["residence_duration"] as? String == nil ? "" : dictionary["residence_duration"] as? String
		residenceNo = dictionary["residence_no"] as? String == nil ? "" : dictionary["residence_no"] as? String
		residenceReason = dictionary["residence_reason"] as? String == nil ? "" : dictionary["residence_reason"] as? String
		roleId = dictionary["role_id"] as? Int == nil ? 0 : dictionary["role_id"] as? Int
		slug = dictionary["slug"] as? String == nil ? "" : dictionary["slug"] as? String
		status = dictionary["status"] as? String == nil ? "" : dictionary["status"] as? String
		transactionDetailsId = dictionary["transaction_details_id"] as? Int == nil ? 0 : dictionary["transaction_details_id"] as? Int
		if let userData = dictionary["user"] as? NSDictionary{
			user = TIReportAgent(fromDictionary: userData)
		}
		else
		{
			user = TIReportAgent(fromDictionary: NSDictionary.init())
		}
		visaType = dictionary["visa_type"] as? String == nil ? "" : dictionary["visa_type"] as? String
		visitType = dictionary["visit_type"] as? String == nil ? "" : dictionary["visit_type"] as? String
        zone = dictionary["zone"] as? String == nil ? "" : dictionary["zone"] as? String
        diwan_tax = dictionary["diwan_tax"] as? String == nil ? "" : dictionary["diwan_tax"] as? String
        diwan_tax_percent = dictionary["diwan_tax_percent"] as? String == nil ? "" : dictionary["diwan_tax_percent"] as? String
        single_price = dictionary["single_price"] as? String == nil ? "" : dictionary["single_price"] as? String
        agent_commision = dictionary["agent_commision"] as? String == nil ? "" : dictionary["agent_commision"] as? String
        agent_commision_percent = dictionary["agent_commision_percent"] as? String == nil ? "" : dictionary["agent_commision_percent"] as? String
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
		if borderEntry != nil{
			dictionary["border_entry"] = borderEntry
		}
		if convertedAmount != nil{
			dictionary["convertedAmount"] = convertedAmount
		}
		if countryCode != nil{
			dictionary["country_code"] = countryCode
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if currency != nil{
			dictionary["currency"] = currency
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
		if optionalCountryCode != nil{
			dictionary["optional_country_code"] = optionalCountryCode
		}
		if optionalMobileNo != nil{
			dictionary["optional_mobile_no"] = optionalMobileNo
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
		if residenceDate != nil{
			dictionary["residence_date"] = residenceDate
		}
		if residenceDuration != nil{
			dictionary["residence_duration"] = residenceDuration
		}
		if residenceNo != nil{
			dictionary["residence_no"] = residenceNo
		}
		if residenceReason != nil{
			dictionary["residence_reason"] = residenceReason
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
		if visaType != nil{
			dictionary["visa_type"] = visaType
		}
		if visitType != nil{
			dictionary["visit_type"] = visitType
		}
		if zone != nil{
			dictionary["zone"] = zone
		}
        if diwan_tax != nil{
            dictionary["diwan_tax"] = diwan_tax
        }
        if diwan_tax_percent != nil{
            dictionary["diwan_tax_percent"] = diwan_tax_percent
        }
        if single_price != nil{
            dictionary["single_price"] = single_price
        }
        
        if agent_commision != nil{
            dictionary["agent_commision"] = agent_commision
        }
        if agent_commision_percent != nil{
            dictionary["agent_commision_percent"] = agent_commision_percent
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
         borderEntry = aDecoder.decodeObject(forKey: "border_entry") as? String
         convertedAmount = aDecoder.decodeObject(forKey: "convertedAmount") as? String
         countryCode = aDecoder.decodeObject(forKey: "country_code") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         currency = aDecoder.decodeObject(forKey: "currency") as? String
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
         optionalCountryCode = aDecoder.decodeObject(forKey: "optional_country_code") as? String
         optionalMobileNo = aDecoder.decodeObject(forKey: "optional_mobile_no") as? String
         orderId = aDecoder.decodeObject(forKey: "order_id") as? String
         passportCopy = aDecoder.decodeObject(forKey: "passport_copy") as? String
         passportNumber = aDecoder.decodeObject(forKey: "passport_number") as? String
         paymentStatus = aDecoder.decodeObject(forKey: "payment_status") as? Int
         policyNo = aDecoder.decodeObject(forKey: "policy_no") as? String
         price = aDecoder.decodeObject(forKey: "price") as? Int
         residenceDate = aDecoder.decodeObject(forKey: "residence_date") as? String
         residenceDuration = aDecoder.decodeObject(forKey: "residence_duration") as? String
         residenceNo = aDecoder.decodeObject(forKey: "residence_no") as? String
         residenceReason = aDecoder.decodeObject(forKey: "residence_reason") as? String
         roleId = aDecoder.decodeObject(forKey: "role_id") as? Int
         slug = aDecoder.decodeObject(forKey: "slug") as? String
         status = aDecoder.decodeObject(forKey: "status") as? String
         transactionDetailsId = aDecoder.decodeObject(forKey: "transaction_details_id") as? Int
         user = aDecoder.decodeObject(forKey: "user") as? TIReportAgent
         visaType = aDecoder.decodeObject(forKey: "visa_type") as? String
         visitType = aDecoder.decodeObject(forKey: "visit_type") as? String
         zone = aDecoder.decodeObject(forKey: "zone") as? String
        diwan_tax = aDecoder.decodeObject(forKey: "diwan_tax") as? String
        diwan_tax_percent = aDecoder.decodeObject(forKey: "diwan_tax_percent") as? String
        single_price = aDecoder.decodeObject(forKey: "single_price") as? String
        agent_commision = aDecoder.decodeObject(forKey: "agent_commision") as? String
        agent_commision_percent = aDecoder.decodeObject(forKey: "agent_commision_percent") as? String

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
		if borderEntry != nil{
			aCoder.encode(borderEntry, forKey: "border_entry")
		}
		if convertedAmount != nil{
			aCoder.encode(convertedAmount, forKey: "convertedAmount")
		}
		if countryCode != nil{
			aCoder.encode(countryCode, forKey: "country_code")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if currency != nil{
			aCoder.encode(currency, forKey: "currency")
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
		if optionalCountryCode != nil{
			aCoder.encode(optionalCountryCode, forKey: "optional_country_code")
		}
		if optionalMobileNo != nil{
			aCoder.encode(optionalMobileNo, forKey: "optional_mobile_no")
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
		if residenceDate != nil{
			aCoder.encode(residenceDate, forKey: "residence_date")
		}
		if residenceDuration != nil{
			aCoder.encode(residenceDuration, forKey: "residence_duration")
		}
		if residenceNo != nil{
			aCoder.encode(residenceNo, forKey: "residence_no")
		}
		if residenceReason != nil{
			aCoder.encode(residenceReason, forKey: "residence_reason")
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
		if visaType != nil{
			aCoder.encode(visaType, forKey: "visa_type")
		}
		if visitType != nil{
			aCoder.encode(visitType, forKey: "visit_type")
		}
		if zone != nil{
			aCoder.encode(zone, forKey: "zone")
		}
        if diwan_tax != nil{
            aCoder.encode(diwan_tax, forKey: "diwan_tax")
        }
        if diwan_tax_percent != nil{
            aCoder.encode(diwan_tax_percent, forKey: "diwan_tax_percent")
        }
        if single_price != nil{
            aCoder.encode(single_price, forKey: "single_price")
        }
        if agent_commision != nil{
            aCoder.encode(agent_commision, forKey: "agent_commision")
        }
        if agent_commision_percent != nil{
            aCoder.encode(agent_commision_percent, forKey: "agent_commision_percent")
        }
	}

}
