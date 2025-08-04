//
//	TIMyVehicleInsuranceUserinsurance.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIMyVehicleInsuranceUserinsurance : NSObject, NSCoding{

	var address : String!
	var adminRejectReason : String!
	var age : Int!
	var agentCode : String!
	var agentCommision : String!
	var agentCommisionPercent : String!
	var borderEntry : String!
	var canceldocuments : String!
	var cancelreason : String!
	var convertedAmount : String!
	var countryCode : String!
	var createdAt : String!
	var currency : String!
	var dateOfBirth : String!
	var destination : String!
	var diwanTax : String!
	var diwanTaxPercent : String!
	var email : String!
	var formSteps : Int!
	var fullName : String!
	var gender : String!
	var insuranceId : Int!
	var isClaim : String!
	var isModified : String!
	var maritalStatus : String!
	var mobileNumber : String!
	var nationality : String!
	var optionalCountryCode : String!
	var optionalMobileNo : String!
	var orderId : String!
	var passportCopy : String!
	var passportNumber : String!
	var paymentStatus : Int!
	var planId : String!
	var policyEndDate : String!
	var policyId : Int!
	var policyNo : String!
	var policyStartDate : String!
	var policyStatus : String!
	var price : Int!
	var residenceDate : String!
	var residenceDuration : String!
	var residenceNo : String!
	var residenceReason : String!
	var roleId : Int!
	var singlePrice : String!
	var slug : String!
	var status : String!
	var timePeriod : String!
	var totalPrice : String!
	var transactionDetailsId : Int!
	var user : TIMyVehicleInsuranceUser!
	var visaType : String!
	var visitType : String!
	var zone : String!


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
		adminRejectReason = dictionary["admin_reject_reason"] as? String == nil ? "" : dictionary["admin_reject_reason"] as? String
		age = dictionary["age"] as? Int == nil ? 0 : dictionary["age"] as? Int
		agentCode = dictionary["agent_code"] as? String == nil ? "" : dictionary["agent_code"] as? String
		agentCommision = dictionary["agent_commision"] as? String == nil ? "" : dictionary["agent_commision"] as? String
		agentCommisionPercent = dictionary["agent_commision_percent"] as? String == nil ? "" : dictionary["agent_commision_percent"] as? String
		borderEntry = dictionary["border_entry"] as? String == nil ? "" : dictionary["border_entry"] as? String
		canceldocuments = dictionary["canceldocuments"] as? String == nil ? "" : dictionary["canceldocuments"] as? String
		cancelreason = dictionary["cancelreason"] as? String == nil ? "" : dictionary["cancelreason"] as? String
		convertedAmount = dictionary["convertedAmount"] as? String == nil ? "" : dictionary["convertedAmount"] as? String
		countryCode = dictionary["country_code"] as? String == nil ? "" : dictionary["country_code"] as? String
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		currency = dictionary["currency"] as? String == nil ? "" : dictionary["currency"] as? String
		dateOfBirth = dictionary["date_of_birth"] as? String == nil ? "" : dictionary["date_of_birth"] as? String
		destination = dictionary["destination"] as? String == nil ? "" : dictionary["destination"] as? String
		diwanTax = dictionary["diwan_tax"] as? String == nil ? "" : dictionary["diwan_tax"] as? String
		diwanTaxPercent = dictionary["diwan_tax_percent"] as? String == nil ? "" : dictionary["diwan_tax_percent"] as? String
		email = dictionary["email"] as? String == nil ? "" : dictionary["email"] as? String
		formSteps = dictionary["form_steps"] as? Int == nil ? 0 : dictionary["form_steps"] as? Int
		fullName = dictionary["full_name"] as? String == nil ? "" : dictionary["full_name"] as? String
		gender = dictionary["gender"] as? String == nil ? "" : dictionary["gender"] as? String
		insuranceId = dictionary["insurance_id"] as? Int == nil ? 0 : dictionary["insurance_id"] as? Int
		isClaim = dictionary["is_claim"] as? String == nil ? "" : dictionary["is_claim"] as? String
		isModified = dictionary["is_modified"] as? String == nil ? "" : dictionary["is_modified"] as? String
		maritalStatus = dictionary["marital_status"] as? String == nil ? "" : dictionary["marital_status"] as? String
		mobileNumber = dictionary["mobile_number"] as? String == nil ? "" : dictionary["mobile_number"] as? String
		nationality = dictionary["nationality"] as? String == nil ? "" : dictionary["nationality"] as? String
		optionalCountryCode = dictionary["optional_country_code"] as? String == nil ? "" : dictionary["optional_country_code"] as? String
		optionalMobileNo = dictionary["optional_mobile_no"] as? String == nil ? "" : dictionary["optional_mobile_no"] as? String
		orderId = dictionary["order_id"] as? String == nil ? "" : dictionary["order_id"] as? String
		passportCopy = dictionary["passport_copy"] as? String == nil ? "" : dictionary["passport_copy"] as? String
		passportNumber = dictionary["passport_number"] as? String == nil ? "" : dictionary["passport_number"] as? String
		paymentStatus = dictionary["payment_status"] as? Int == nil ? 0 : dictionary["payment_status"] as? Int
		planId = dictionary["plan_id"] as? String == nil ? "" : dictionary["plan_id"] as? String
		policyEndDate = dictionary["policy_end_date"] as? String == nil ? "" : dictionary["policy_end_date"] as? String
		policyId = dictionary["policy_id"] as? Int == nil ? 0 : dictionary["policy_id"] as? Int
		policyNo = dictionary["policy_no"] as? String == nil ? "" : dictionary["policy_no"] as? String
		policyStartDate = dictionary["policy_start_date"] as? String == nil ? "" : dictionary["policy_start_date"] as? String
		policyStatus = dictionary["policy_status"] as? String == nil ? "" : dictionary["policy_status"] as? String
		price = dictionary["price"] as? Int == nil ? 0 : dictionary["price"] as? Int
		residenceDate = dictionary["residence_date"] as? String == nil ? "" : dictionary["residence_date"] as? String
		residenceDuration = dictionary["residence_duration"] as? String == nil ? "" : dictionary["residence_duration"] as? String
		residenceNo = dictionary["residence_no"] as? String == nil ? "" : dictionary["residence_no"] as? String
		residenceReason = dictionary["residence_reason"] as? String == nil ? "" : dictionary["residence_reason"] as? String
		roleId = dictionary["role_id"] as? Int == nil ? 0 : dictionary["role_id"] as? Int
		singlePrice = dictionary["single_price"] as? String == nil ? "" : dictionary["single_price"] as? String
		slug = dictionary["slug"] as? String == nil ? "" : dictionary["slug"] as? String
		status = dictionary["status"] as? String == nil ? "" : dictionary["status"] as? String
		timePeriod = dictionary["time_period"] as? String == nil ? "" : dictionary["time_period"] as? String
		totalPrice = dictionary["total_price"] as? String == nil ? "" : dictionary["total_price"] as? String
		transactionDetailsId = dictionary["transaction_details_id"] as? Int == nil ? 0 : dictionary["transaction_details_id"] as? Int
		if let userData = dictionary["user"] as? NSDictionary{
			user = TIMyVehicleInsuranceUser(fromDictionary: userData)
		}
		else
		{
			user = TIMyVehicleInsuranceUser(fromDictionary: NSDictionary.init())
		}
		visaType = dictionary["visa_type"] as? String == nil ? "" : dictionary["visa_type"] as? String
		visitType = dictionary["visit_type"] as? String == nil ? "" : dictionary["visit_type"] as? String
		zone = dictionary["zone"] as? String == nil ? "" : dictionary["zone"] as? String
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
		if adminRejectReason != nil{
			dictionary["admin_reject_reason"] = adminRejectReason
		}
		if age != nil{
			dictionary["age"] = age
		}
		if agentCode != nil{
			dictionary["agent_code"] = agentCode
		}
		if agentCommision != nil{
			dictionary["agent_commision"] = agentCommision
		}
		if agentCommisionPercent != nil{
			dictionary["agent_commision_percent"] = agentCommisionPercent
		}
		if borderEntry != nil{
			dictionary["border_entry"] = borderEntry
		}
		if canceldocuments != nil{
			dictionary["canceldocuments"] = canceldocuments
		}
		if cancelreason != nil{
			dictionary["cancelreason"] = cancelreason
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
		if diwanTax != nil{
			dictionary["diwan_tax"] = diwanTax
		}
		if diwanTaxPercent != nil{
			dictionary["diwan_tax_percent"] = diwanTaxPercent
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
		if isClaim != nil{
			dictionary["is_claim"] = isClaim
		}
		if isModified != nil{
			dictionary["is_modified"] = isModified
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
		if planId != nil{
			dictionary["plan_id"] = planId
		}
		if policyEndDate != nil{
			dictionary["policy_end_date"] = policyEndDate
		}
		if policyId != nil{
			dictionary["policy_id"] = policyId
		}
		if policyNo != nil{
			dictionary["policy_no"] = policyNo
		}
		if policyStartDate != nil{
			dictionary["policy_start_date"] = policyStartDate
		}
		if policyStatus != nil{
			dictionary["policy_status"] = policyStatus
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
		if singlePrice != nil{
			dictionary["single_price"] = singlePrice
		}
		if slug != nil{
			dictionary["slug"] = slug
		}
		if status != nil{
			dictionary["status"] = status
		}
		if timePeriod != nil{
			dictionary["time_period"] = timePeriod
		}
		if totalPrice != nil{
			dictionary["total_price"] = totalPrice
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
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         address = aDecoder.decodeObject(forKey: "address") as? String
         adminRejectReason = aDecoder.decodeObject(forKey: "admin_reject_reason") as? String
         age = aDecoder.decodeObject(forKey: "age") as? Int
         agentCode = aDecoder.decodeObject(forKey: "agent_code") as? String
         agentCommision = aDecoder.decodeObject(forKey: "agent_commision") as? String
         agentCommisionPercent = aDecoder.decodeObject(forKey: "agent_commision_percent") as? String
         borderEntry = aDecoder.decodeObject(forKey: "border_entry") as? String
         canceldocuments = aDecoder.decodeObject(forKey: "canceldocuments") as? String
         cancelreason = aDecoder.decodeObject(forKey: "cancelreason") as? String
         convertedAmount = aDecoder.decodeObject(forKey: "convertedAmount") as? String
         countryCode = aDecoder.decodeObject(forKey: "country_code") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         currency = aDecoder.decodeObject(forKey: "currency") as? String
         dateOfBirth = aDecoder.decodeObject(forKey: "date_of_birth") as? String
         destination = aDecoder.decodeObject(forKey: "destination") as? String
         diwanTax = aDecoder.decodeObject(forKey: "diwan_tax") as? String
         diwanTaxPercent = aDecoder.decodeObject(forKey: "diwan_tax_percent") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         formSteps = aDecoder.decodeObject(forKey: "form_steps") as? Int
         fullName = aDecoder.decodeObject(forKey: "full_name") as? String
         gender = aDecoder.decodeObject(forKey: "gender") as? String
         insuranceId = aDecoder.decodeObject(forKey: "insurance_id") as? Int
         isClaim = aDecoder.decodeObject(forKey: "is_claim") as? String
         isModified = aDecoder.decodeObject(forKey: "is_modified") as? String
         maritalStatus = aDecoder.decodeObject(forKey: "marital_status") as? String
         mobileNumber = aDecoder.decodeObject(forKey: "mobile_number") as? String
         nationality = aDecoder.decodeObject(forKey: "nationality") as? String
         optionalCountryCode = aDecoder.decodeObject(forKey: "optional_country_code") as? String
         optionalMobileNo = aDecoder.decodeObject(forKey: "optional_mobile_no") as? String
         orderId = aDecoder.decodeObject(forKey: "order_id") as? String
         passportCopy = aDecoder.decodeObject(forKey: "passport_copy") as? String
         passportNumber = aDecoder.decodeObject(forKey: "passport_number") as? String
         paymentStatus = aDecoder.decodeObject(forKey: "payment_status") as? Int
         planId = aDecoder.decodeObject(forKey: "plan_id") as? String
         policyEndDate = aDecoder.decodeObject(forKey: "policy_end_date") as? String
         policyId = aDecoder.decodeObject(forKey: "policy_id") as? Int
         policyNo = aDecoder.decodeObject(forKey: "policy_no") as? String
         policyStartDate = aDecoder.decodeObject(forKey: "policy_start_date") as? String
         policyStatus = aDecoder.decodeObject(forKey: "policy_status") as? String
         price = aDecoder.decodeObject(forKey: "price") as? Int
         residenceDate = aDecoder.decodeObject(forKey: "residence_date") as? String
         residenceDuration = aDecoder.decodeObject(forKey: "residence_duration") as? String
         residenceNo = aDecoder.decodeObject(forKey: "residence_no") as? String
         residenceReason = aDecoder.decodeObject(forKey: "residence_reason") as? String
         roleId = aDecoder.decodeObject(forKey: "role_id") as? Int
         singlePrice = aDecoder.decodeObject(forKey: "single_price") as? String
         slug = aDecoder.decodeObject(forKey: "slug") as? String
         status = aDecoder.decodeObject(forKey: "status") as? String
         timePeriod = aDecoder.decodeObject(forKey: "time_period") as? String
         totalPrice = aDecoder.decodeObject(forKey: "total_price") as? String
         transactionDetailsId = aDecoder.decodeObject(forKey: "transaction_details_id") as? Int
         user = aDecoder.decodeObject(forKey: "user") as? TIMyVehicleInsuranceUser
         visaType = aDecoder.decodeObject(forKey: "visa_type") as? String
         visitType = aDecoder.decodeObject(forKey: "visit_type") as? String
         zone = aDecoder.decodeObject(forKey: "zone") as? String

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
		if adminRejectReason != nil{
			aCoder.encode(adminRejectReason, forKey: "admin_reject_reason")
		}
		if age != nil{
			aCoder.encode(age, forKey: "age")
		}
		if agentCode != nil{
			aCoder.encode(agentCode, forKey: "agent_code")
		}
		if agentCommision != nil{
			aCoder.encode(agentCommision, forKey: "agent_commision")
		}
		if agentCommisionPercent != nil{
			aCoder.encode(agentCommisionPercent, forKey: "agent_commision_percent")
		}
		if borderEntry != nil{
			aCoder.encode(borderEntry, forKey: "border_entry")
		}
		if canceldocuments != nil{
			aCoder.encode(canceldocuments, forKey: "canceldocuments")
		}
		if cancelreason != nil{
			aCoder.encode(cancelreason, forKey: "cancelreason")
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
		if diwanTax != nil{
			aCoder.encode(diwanTax, forKey: "diwan_tax")
		}
		if diwanTaxPercent != nil{
			aCoder.encode(diwanTaxPercent, forKey: "diwan_tax_percent")
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
		if isClaim != nil{
			aCoder.encode(isClaim, forKey: "is_claim")
		}
		if isModified != nil{
			aCoder.encode(isModified, forKey: "is_modified")
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
		if planId != nil{
			aCoder.encode(planId, forKey: "plan_id")
		}
		if policyEndDate != nil{
			aCoder.encode(policyEndDate, forKey: "policy_end_date")
		}
		if policyId != nil{
			aCoder.encode(policyId, forKey: "policy_id")
		}
		if policyNo != nil{
			aCoder.encode(policyNo, forKey: "policy_no")
		}
		if policyStartDate != nil{
			aCoder.encode(policyStartDate, forKey: "policy_start_date")
		}
		if policyStatus != nil{
			aCoder.encode(policyStatus, forKey: "policy_status")
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
		if singlePrice != nil{
			aCoder.encode(singlePrice, forKey: "single_price")
		}
		if slug != nil{
			aCoder.encode(slug, forKey: "slug")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if timePeriod != nil{
			aCoder.encode(timePeriod, forKey: "time_period")
		}
		if totalPrice != nil{
			aCoder.encode(totalPrice, forKey: "total_price")
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

	}

}