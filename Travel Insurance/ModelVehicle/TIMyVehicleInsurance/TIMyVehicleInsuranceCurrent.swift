//
//	TIMyVehicleInsuranceCurrent.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIMyVehicleInsuranceCurrent : NSObject, NSCoding{

	var iQDAmount : String!
	var adminRejectReason : String!
	var agentCommision : String!
	var agentPrice : String!
	var cancellationDocument : String!
	var cardType : String!
	var createdAt : String!
	var createdBy : Int!
	var currency : String!
	var currencySymbol : String!
	var diwanTax : String!
	var diwanTaxPercent : String!
	var isRefund : String!
	var orderId : String!
	var orderStatus : String!
	var payment : String!
	var paymentBy : String!
	var paymentMethod : String!
	var paymentMode : String!
	var paymentResponse : String!
	var paymentStatus : String!
	var planId : Int!
	var plans : TIMyVehicleInsurancePlan!
	var policyEndDate : String!
	var policyNo : String!
	var policyStartDate : String!
	var reason : String!
	var slug : String!
	var taxAmount : String!
	var timePeriod : String!
	var totalAmount : String!
	var totalPrice : String!
	var transactionDate : String!
	var transactionDetailsId : Int!
	var transectionStatus : [TIMyVehicleInsuranceTransectionStatu]!
	var txnId : String!
	var updatedAt : String!
	var updatedBy : String!
	var usdAmount : String!
	var userId : Int!
	var userinsurance : [TIMyVehicleInsuranceUserinsurance]!
	var zone : String!
	var address : String!
	var agencyRepair : String!
	var basePremium : String!
	var cancelDocument : String!
	var cancelReason : String!
	var chassisNo : String!
	var claimStatus : String!
	var color : String!
	var dailCode : String!
	var dob : String!
	var duration : String!
	var email : String!
	var engineNo : String!
	var engineSize : String!
	var fuelType : String!
	var id : Int!
	var idvAmount : String!
	var modelYear : String!
	var name : String!
	var phoneNo : String!
	var policyId : String!
	var postClaimAmount : String!
	var registrationDate : String!
	var status : String!
	var totalAddOnPrice : String!
	var totalPremium : String!
	var txnData : String!
	var struserId : String!
	var vehicleAge : String!
	var vehicleBrand : String!
	var vehicleInsuranceOptionalAddOn : [TIMyVehicleInsuranceVehicleInsuranceOptionalAddOn]!
	var vehicleModel : String!
	var vehicleNo : String!
	var vehiclePlanId : Int!
	var vehicleType : String!
	var vehicleValue : String!


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
		iQDAmount = dictionary["IQD_Amount"] as? String == nil ? "" : dictionary["IQD_Amount"] as? String
		adminRejectReason = dictionary["admin_reject_reason"] as? String == nil ? "" : dictionary["admin_reject_reason"] as? String
		agentCommision = dictionary["agent_commision"] as? String == nil ? "" : dictionary["agent_commision"] as? String
		agentPrice = dictionary["agent_price"] as? String == nil ? "" : dictionary["agent_price"] as? String
		cancellationDocument = dictionary["cancellationDocument"] as? String == nil ? "" : dictionary["cancellationDocument"] as? String
		cardType = dictionary["card_type"] as? String == nil ? "" : dictionary["card_type"] as? String
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		createdBy = dictionary["created_by"] as? Int == nil ? 0 : dictionary["created_by"] as? Int
		currency = dictionary["currency"] as? String == nil ? "" : dictionary["currency"] as? String
		currencySymbol = dictionary["currencySymbol"] as? String == nil ? "" : dictionary["currencySymbol"] as? String
		diwanTax = dictionary["diwan_tax"] as? String == nil ? "" : dictionary["diwan_tax"] as? String
		diwanTaxPercent = dictionary["diwan_tax_percent"] as? String == nil ? "" : dictionary["diwan_tax_percent"] as? String
		isRefund = dictionary["is_refund"] as? String == nil ? "" : dictionary["is_refund"] as? String
		orderId = dictionary["order_id"] as? String == nil ? "" : dictionary["order_id"] as? String
		orderStatus = dictionary["order_status"] as? String == nil ? "" : dictionary["order_status"] as? String
		payment = dictionary["payment"] as? String == nil ? "" : dictionary["payment"] as? String
		paymentBy = dictionary["payment_by"] as? String == nil ? "" : dictionary["payment_by"] as? String
		paymentMethod = dictionary["payment_method"] as? String == nil ? "" : dictionary["payment_method"] as? String
		paymentMode = dictionary["payment_mode"] as? String == nil ? "" : dictionary["payment_mode"] as? String
		paymentResponse = dictionary["payment_response"] as? String == nil ? "" : dictionary["payment_response"] as? String
		paymentStatus = dictionary["payment_status"] as? String == nil ? "" : dictionary["payment_status"] as? String
		planId = dictionary["plan_id"] as? Int == nil ? 0 : dictionary["plan_id"] as? Int
		if let plansData = dictionary["plans"] as? NSDictionary{
			plans = TIMyVehicleInsurancePlan(fromDictionary: plansData)
		}
		else
		{
			plans = TIMyVehicleInsurancePlan(fromDictionary: NSDictionary.init())
		}
		policyEndDate = dictionary["policy_end_date"] as? String == nil ? "" : dictionary["policy_end_date"] as? String
		policyNo = dictionary["policy_no"] as? String == nil ? "" : dictionary["policy_no"] as? String
		policyStartDate = dictionary["policy_start_date"] as? String == nil ? "" : dictionary["policy_start_date"] as? String
		reason = dictionary["reason"] as? String == nil ? "" : dictionary["reason"] as? String
		slug = dictionary["slug"] as? String == nil ? "" : dictionary["slug"] as? String
		taxAmount = dictionary["tax_amount"] as? String == nil ? "" : dictionary["tax_amount"] as? String
		timePeriod = dictionary["time_period"] as? String == nil ? "" : dictionary["time_period"] as? String
		totalAmount = dictionary["total_amount"] as? String == nil ? "" : dictionary["total_amount"] as? String
		totalPrice = dictionary["total_price"] as? String == nil ? "" : dictionary["total_price"] as? String
		transactionDate = dictionary["transaction_date"] as? String == nil ? "" : dictionary["transaction_date"] as? String
		transactionDetailsId = dictionary["transaction_details_id"] as? Int == nil ? 0 : dictionary["transaction_details_id"] as? Int
		transectionStatus = [TIMyVehicleInsuranceTransectionStatu]()
		if let transectionStatusArray = dictionary["transection_status"] as? [NSDictionary]{
			for dic in transectionStatusArray{
				let value = TIMyVehicleInsuranceTransectionStatu(fromDictionary: dic)
				transectionStatus.append(value)
			}
		}
		txnId = dictionary["txn_id"] as? String == nil ? "" : dictionary["txn_id"] as? String
		updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
		updatedBy = dictionary["updated_by"] as? String == nil ? "" : dictionary["updated_by"] as? String
		usdAmount = dictionary["usd_amount"] as? String == nil ? "" : dictionary["usd_amount"] as? String
		userId = dictionary["user_id"] as? Int == nil ? 0 : dictionary["user_id"] as? Int
		userinsurance = [TIMyVehicleInsuranceUserinsurance]()
		if let userinsuranceArray = dictionary["userinsurance"] as? [NSDictionary]{
			for dic in userinsuranceArray{
				let value = TIMyVehicleInsuranceUserinsurance(fromDictionary: dic)
				userinsurance.append(value)
			}
		}
		zone = dictionary["zone"] as? String == nil ? "" : dictionary["zone"] as? String
		address = dictionary["address"] as? String == nil ? "" : dictionary["address"] as? String
		agencyRepair = dictionary["agency_repair"] as? String == nil ? "" : dictionary["agency_repair"] as? String
		basePremium = dictionary["base_premium"] as? String == nil ? "" : dictionary["base_premium"] as? String
		cancelDocument = dictionary["cancel_document"] as? String == nil ? "" : dictionary["cancel_document"] as? String
		cancelReason = dictionary["cancel_reason"] as? String == nil ? "" : dictionary["cancel_reason"] as? String
		chassisNo = dictionary["chassis_no"] as? String == nil ? "" : dictionary["chassis_no"] as? String
		claimStatus = dictionary["claim_status"] as? String == nil ? "" : dictionary["claim_status"] as? String
		color = dictionary["color"] as? String == nil ? "" : dictionary["color"] as? String
		dailCode = dictionary["dail_code"] as? String == nil ? "" : dictionary["dail_code"] as? String
		dob = dictionary["dob"] as? String == nil ? "" : dictionary["dob"] as? String
		duration = dictionary["duration"] as? String == nil ? "" : dictionary["duration"] as? String
		email = dictionary["email"] as? String == nil ? "" : dictionary["email"] as? String
		engineNo = dictionary["engine_no"] as? String == nil ? "" : dictionary["engine_no"] as? String
		engineSize = dictionary["engine_size"] as? String == nil ? "" : dictionary["engine_size"] as? String
		fuelType = dictionary["fuel_type"] as? String == nil ? "" : dictionary["fuel_type"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		idvAmount = dictionary["idv_amount"] as? String == nil ? "" : dictionary["idv_amount"] as? String
		modelYear = dictionary["model_year"] as? String == nil ? "" : dictionary["model_year"] as? String
		name = dictionary["name"] as? String == nil ? "" : dictionary["name"] as? String
		phoneNo = dictionary["phone_no"] as? String == nil ? "" : dictionary["phone_no"] as? String
		policyId = dictionary["policy_id"] as? String == nil ? "" : dictionary["policy_id"] as? String
		postClaimAmount = dictionary["post_claim_amount"] as? String == nil ? "" : dictionary["post_claim_amount"] as? String
		registrationDate = dictionary["registration_date"] as? String == nil ? "" : dictionary["registration_date"] as? String
		status = dictionary["status"] as? String == nil ? "" : dictionary["status"] as? String
		totalAddOnPrice = dictionary["total_add_on_price"] as? String == nil ? "" : dictionary["total_add_on_price"] as? String
		totalPremium = dictionary["total_premium"] as? String == nil ? "" : dictionary["total_premium"] as? String
		txnData = dictionary["txn_data"] as? String == nil ? "" : dictionary["txn_data"] as? String
        struserId = dictionary["user_id"] as? String == nil ? "" : dictionary["user_id"] as? String
		vehicleAge = dictionary["vehicle_age"] as? String == nil ? "" : dictionary["vehicle_age"] as? String
		vehicleBrand = dictionary["vehicle_brand"] as? String == nil ? "" : dictionary["vehicle_brand"] as? String
		vehicleInsuranceOptionalAddOn = [TIMyVehicleInsuranceVehicleInsuranceOptionalAddOn]()
		if let vehicleInsuranceOptionalAddOnArray = dictionary["vehicle_insurance_optional_add_on"] as? [NSDictionary]{
			for dic in vehicleInsuranceOptionalAddOnArray{
				let value = TIMyVehicleInsuranceVehicleInsuranceOptionalAddOn(fromDictionary: dic)
				vehicleInsuranceOptionalAddOn.append(value)
			}
		}
		vehicleModel = dictionary["vehicle_model"] as? String == nil ? "" : dictionary["vehicle_model"] as? String
		vehicleNo = dictionary["vehicle_no"] as? String == nil ? "" : dictionary["vehicle_no"] as? String
		vehiclePlanId = dictionary["vehicle_plan_id"] as? Int == nil ? 0 : dictionary["vehicle_plan_id"] as? Int
		vehicleType = dictionary["vehicle_type"] as? String == nil ? "" : dictionary["vehicle_type"] as? String
		vehicleValue = dictionary["vehicle_value"] as? String == nil ? "" : dictionary["vehicle_value"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if iQDAmount != nil{
			dictionary["IQD_Amount"] = iQDAmount
		}
		if adminRejectReason != nil{
			dictionary["admin_reject_reason"] = adminRejectReason
		}
		if agentCommision != nil{
			dictionary["agent_commision"] = agentCommision
		}
		if agentPrice != nil{
			dictionary["agent_price"] = agentPrice
		}
		if cancellationDocument != nil{
			dictionary["cancellationDocument"] = cancellationDocument
		}
		if cardType != nil{
			dictionary["card_type"] = cardType
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if createdBy != nil{
			dictionary["created_by"] = createdBy
		}
		if currency != nil{
			dictionary["currency"] = currency
		}
		if currencySymbol != nil{
			dictionary["currencySymbol"] = currencySymbol
		}
		if diwanTax != nil{
			dictionary["diwan_tax"] = diwanTax
		}
		if diwanTaxPercent != nil{
			dictionary["diwan_tax_percent"] = diwanTaxPercent
		}
		if isRefund != nil{
			dictionary["is_refund"] = isRefund
		}
		if orderId != nil{
			dictionary["order_id"] = orderId
		}
		if orderStatus != nil{
			dictionary["order_status"] = orderStatus
		}
		if payment != nil{
			dictionary["payment"] = payment
		}
		if paymentBy != nil{
			dictionary["payment_by"] = paymentBy
		}
		if paymentMethod != nil{
			dictionary["payment_method"] = paymentMethod
		}
		if paymentMode != nil{
			dictionary["payment_mode"] = paymentMode
		}
		if paymentResponse != nil{
			dictionary["payment_response"] = paymentResponse
		}
		if paymentStatus != nil{
			dictionary["payment_status"] = paymentStatus
		}
		if planId != nil{
			dictionary["plan_id"] = planId
		}
		if plans != nil{
			dictionary["plans"] = plans.toDictionary()
		}
		if policyEndDate != nil{
			dictionary["policy_end_date"] = policyEndDate
		}
		if policyNo != nil{
			dictionary["policy_no"] = policyNo
		}
		if policyStartDate != nil{
			dictionary["policy_start_date"] = policyStartDate
		}
		if reason != nil{
			dictionary["reason"] = reason
		}
		if slug != nil{
			dictionary["slug"] = slug
		}
		if taxAmount != nil{
			dictionary["tax_amount"] = taxAmount
		}
		if timePeriod != nil{
			dictionary["time_period"] = timePeriod
		}
		if totalAmount != nil{
			dictionary["total_amount"] = totalAmount
		}
		if totalPrice != nil{
			dictionary["total_price"] = totalPrice
		}
		if transactionDate != nil{
			dictionary["transaction_date"] = transactionDate
		}
		if transactionDetailsId != nil{
			dictionary["transaction_details_id"] = transactionDetailsId
		}
		if transectionStatus != nil{
			var dictionaryElements = [NSDictionary]()
			for transectionStatusElement in transectionStatus {
				dictionaryElements.append(transectionStatusElement.toDictionary())
			}
			dictionary["transection_status"] = dictionaryElements
		}
		if txnId != nil{
			dictionary["txn_id"] = txnId
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if updatedBy != nil{
			dictionary["updated_by"] = updatedBy
		}
		if usdAmount != nil{
			dictionary["usd_amount"] = usdAmount
		}
		if userId != nil{
			dictionary["user_id"] = userId
		}
		if userinsurance != nil{
			var dictionaryElements = [NSDictionary]()
			for userinsuranceElement in userinsurance {
				dictionaryElements.append(userinsuranceElement.toDictionary())
			}
			dictionary["userinsurance"] = dictionaryElements
		}
		if zone != nil{
			dictionary["zone"] = zone
		}
		if address != nil{
			dictionary["address"] = address
		}
		if agencyRepair != nil{
			dictionary["agency_repair"] = agencyRepair
		}
		if basePremium != nil{
			dictionary["base_premium"] = basePremium
		}
		if cancelDocument != nil{
			dictionary["cancel_document"] = cancelDocument
		}
		if cancelReason != nil{
			dictionary["cancel_reason"] = cancelReason
		}
		if chassisNo != nil{
			dictionary["chassis_no"] = chassisNo
		}
		if claimStatus != nil{
			dictionary["claim_status"] = claimStatus
		}
		if color != nil{
			dictionary["color"] = color
		}
		if dailCode != nil{
			dictionary["dail_code"] = dailCode
		}
		if dob != nil{
			dictionary["dob"] = dob
		}
		if duration != nil{
			dictionary["duration"] = duration
		}
		if email != nil{
			dictionary["email"] = email
		}
		if engineNo != nil{
			dictionary["engine_no"] = engineNo
		}
		if engineSize != nil{
			dictionary["engine_size"] = engineSize
		}
		if fuelType != nil{
			dictionary["fuel_type"] = fuelType
		}
		if id != nil{
			dictionary["id"] = id
		}
		if idvAmount != nil{
			dictionary["idv_amount"] = idvAmount
		}
		if modelYear != nil{
			dictionary["model_year"] = modelYear
		}
		if name != nil{
			dictionary["name"] = name
		}
		if phoneNo != nil{
			dictionary["phone_no"] = phoneNo
		}
		if policyId != nil{
			dictionary["policy_id"] = policyId
		}
		if postClaimAmount != nil{
			dictionary["post_claim_amount"] = postClaimAmount
		}
		if registrationDate != nil{
			dictionary["registration_date"] = registrationDate
		}
		if status != nil{
			dictionary["status"] = status
		}
		if totalAddOnPrice != nil{
			dictionary["total_add_on_price"] = totalAddOnPrice
		}
		if totalPremium != nil{
			dictionary["total_premium"] = totalPremium
		}
		if txnData != nil{
			dictionary["txn_data"] = txnData
		}
		if struserId != nil{
			dictionary["user_id"] = struserId
		}
		if vehicleAge != nil{
			dictionary["vehicle_age"] = vehicleAge
		}
		if vehicleBrand != nil{
			dictionary["vehicle_brand"] = vehicleBrand
		}
		if vehicleInsuranceOptionalAddOn != nil{
			var dictionaryElements = [NSDictionary]()
			for vehicleInsuranceOptionalAddOnElement in vehicleInsuranceOptionalAddOn {
				dictionaryElements.append(vehicleInsuranceOptionalAddOnElement.toDictionary())
			}
			dictionary["vehicle_insurance_optional_add_on"] = dictionaryElements
		}
		if vehicleModel != nil{
			dictionary["vehicle_model"] = vehicleModel
		}
		if vehicleNo != nil{
			dictionary["vehicle_no"] = vehicleNo
		}
		if vehiclePlanId != nil{
			dictionary["vehicle_plan_id"] = vehiclePlanId
		}
		if vehicleType != nil{
			dictionary["vehicle_type"] = vehicleType
		}
		if vehicleValue != nil{
			dictionary["vehicle_value"] = vehicleValue
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         iQDAmount = aDecoder.decodeObject(forKey: "IQD_Amount") as? String
         adminRejectReason = aDecoder.decodeObject(forKey: "admin_reject_reason") as? String
         agentCommision = aDecoder.decodeObject(forKey: "agent_commision") as? String
         agentPrice = aDecoder.decodeObject(forKey: "agent_price") as? String
         cancellationDocument = aDecoder.decodeObject(forKey: "cancellationDocument") as? String
         cardType = aDecoder.decodeObject(forKey: "card_type") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         createdBy = aDecoder.decodeObject(forKey: "created_by") as? Int
         currency = aDecoder.decodeObject(forKey: "currency") as? String
         currencySymbol = aDecoder.decodeObject(forKey: "currencySymbol") as? String
         diwanTax = aDecoder.decodeObject(forKey: "diwan_tax") as? String
         diwanTaxPercent = aDecoder.decodeObject(forKey: "diwan_tax_percent") as? String
         isRefund = aDecoder.decodeObject(forKey: "is_refund") as? String
         orderId = aDecoder.decodeObject(forKey: "order_id") as? String
         orderStatus = aDecoder.decodeObject(forKey: "order_status") as? String
         payment = aDecoder.decodeObject(forKey: "payment") as? String
         paymentBy = aDecoder.decodeObject(forKey: "payment_by") as? String
         paymentMethod = aDecoder.decodeObject(forKey: "payment_method") as? String
         paymentMode = aDecoder.decodeObject(forKey: "payment_mode") as? String
         paymentResponse = aDecoder.decodeObject(forKey: "payment_response") as? String
         paymentStatus = aDecoder.decodeObject(forKey: "payment_status") as? String
         planId = aDecoder.decodeObject(forKey: "plan_id") as? Int
         plans = aDecoder.decodeObject(forKey: "plans") as? TIMyVehicleInsurancePlan
         policyEndDate = aDecoder.decodeObject(forKey: "policy_end_date") as? String
         policyNo = aDecoder.decodeObject(forKey: "policy_no") as? String
         policyStartDate = aDecoder.decodeObject(forKey: "policy_start_date") as? String
         reason = aDecoder.decodeObject(forKey: "reason") as? String
         slug = aDecoder.decodeObject(forKey: "slug") as? String
         taxAmount = aDecoder.decodeObject(forKey: "tax_amount") as? String
         timePeriod = aDecoder.decodeObject(forKey: "time_period") as? String
         totalAmount = aDecoder.decodeObject(forKey: "total_amount") as? String
         totalPrice = aDecoder.decodeObject(forKey: "total_price") as? String
         transactionDate = aDecoder.decodeObject(forKey: "transaction_date") as? String
         transactionDetailsId = aDecoder.decodeObject(forKey: "transaction_details_id") as? Int
         transectionStatus = aDecoder.decodeObject(forKey: "transection_status") as? [TIMyVehicleInsuranceTransectionStatu]
         txnId = aDecoder.decodeObject(forKey: "txn_id") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         updatedBy = aDecoder.decodeObject(forKey: "updated_by") as? String
         usdAmount = aDecoder.decodeObject(forKey: "usd_amount") as? String
         userId = aDecoder.decodeObject(forKey: "user_id") as? Int
         userinsurance = aDecoder.decodeObject(forKey: "userinsurance") as? [TIMyVehicleInsuranceUserinsurance]
         zone = aDecoder.decodeObject(forKey: "zone") as? String
         address = aDecoder.decodeObject(forKey: "address") as? String
         agencyRepair = aDecoder.decodeObject(forKey: "agency_repair") as? String
         basePremium = aDecoder.decodeObject(forKey: "base_premium") as? String
         cancelDocument = aDecoder.decodeObject(forKey: "cancel_document") as? String
         cancelReason = aDecoder.decodeObject(forKey: "cancel_reason") as? String
         chassisNo = aDecoder.decodeObject(forKey: "chassis_no") as? String
         claimStatus = aDecoder.decodeObject(forKey: "claim_status") as? String
         color = aDecoder.decodeObject(forKey: "color") as? String
         dailCode = aDecoder.decodeObject(forKey: "dail_code") as? String
         dob = aDecoder.decodeObject(forKey: "dob") as? String
         duration = aDecoder.decodeObject(forKey: "duration") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         engineNo = aDecoder.decodeObject(forKey: "engine_no") as? String
         engineSize = aDecoder.decodeObject(forKey: "engine_size") as? String
         fuelType = aDecoder.decodeObject(forKey: "fuel_type") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         idvAmount = aDecoder.decodeObject(forKey: "idv_amount") as? String
         modelYear = aDecoder.decodeObject(forKey: "model_year") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         phoneNo = aDecoder.decodeObject(forKey: "phone_no") as? String
         policyId = aDecoder.decodeObject(forKey: "policy_id") as? String
         postClaimAmount = aDecoder.decodeObject(forKey: "post_claim_amount") as? String
         registrationDate = aDecoder.decodeObject(forKey: "registration_date") as? String
         status = aDecoder.decodeObject(forKey: "status") as? String
         totalAddOnPrice = aDecoder.decodeObject(forKey: "total_add_on_price") as? String
         totalPremium = aDecoder.decodeObject(forKey: "total_premium") as? String
         txnData = aDecoder.decodeObject(forKey: "txn_data") as? String
        struserId = aDecoder.decodeObject(forKey: "user_id") as? String
         vehicleAge = aDecoder.decodeObject(forKey: "vehicle_age") as? String
         vehicleBrand = aDecoder.decodeObject(forKey: "vehicle_brand") as? String
         vehicleInsuranceOptionalAddOn = aDecoder.decodeObject(forKey: "vehicle_insurance_optional_add_on") as? [TIMyVehicleInsuranceVehicleInsuranceOptionalAddOn]
         vehicleModel = aDecoder.decodeObject(forKey: "vehicle_model") as? String
         vehicleNo = aDecoder.decodeObject(forKey: "vehicle_no") as? String
         vehiclePlanId = aDecoder.decodeObject(forKey: "vehicle_plan_id") as? Int
         vehicleType = aDecoder.decodeObject(forKey: "vehicle_type") as? String
         vehicleValue = aDecoder.decodeObject(forKey: "vehicle_value") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if iQDAmount != nil{
			aCoder.encode(iQDAmount, forKey: "IQD_Amount")
		}
		if adminRejectReason != nil{
			aCoder.encode(adminRejectReason, forKey: "admin_reject_reason")
		}
		if agentCommision != nil{
			aCoder.encode(agentCommision, forKey: "agent_commision")
		}
		if agentPrice != nil{
			aCoder.encode(agentPrice, forKey: "agent_price")
		}
		if cancellationDocument != nil{
			aCoder.encode(cancellationDocument, forKey: "cancellationDocument")
		}
		if cardType != nil{
			aCoder.encode(cardType, forKey: "card_type")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if createdBy != nil{
			aCoder.encode(createdBy, forKey: "created_by")
		}
		if currency != nil{
			aCoder.encode(currency, forKey: "currency")
		}
		if currencySymbol != nil{
			aCoder.encode(currencySymbol, forKey: "currencySymbol")
		}
		if diwanTax != nil{
			aCoder.encode(diwanTax, forKey: "diwan_tax")
		}
		if diwanTaxPercent != nil{
			aCoder.encode(diwanTaxPercent, forKey: "diwan_tax_percent")
		}
		if isRefund != nil{
			aCoder.encode(isRefund, forKey: "is_refund")
		}
		if orderId != nil{
			aCoder.encode(orderId, forKey: "order_id")
		}
		if orderStatus != nil{
			aCoder.encode(orderStatus, forKey: "order_status")
		}
		if payment != nil{
			aCoder.encode(payment, forKey: "payment")
		}
		if paymentBy != nil{
			aCoder.encode(paymentBy, forKey: "payment_by")
		}
		if paymentMethod != nil{
			aCoder.encode(paymentMethod, forKey: "payment_method")
		}
		if paymentMode != nil{
			aCoder.encode(paymentMode, forKey: "payment_mode")
		}
		if paymentResponse != nil{
			aCoder.encode(paymentResponse, forKey: "payment_response")
		}
		if paymentStatus != nil{
			aCoder.encode(paymentStatus, forKey: "payment_status")
		}
		if planId != nil{
			aCoder.encode(planId, forKey: "plan_id")
		}
		if plans != nil{
			aCoder.encode(plans, forKey: "plans")
		}
		if policyEndDate != nil{
			aCoder.encode(policyEndDate, forKey: "policy_end_date")
		}
		if policyNo != nil{
			aCoder.encode(policyNo, forKey: "policy_no")
		}
		if policyStartDate != nil{
			aCoder.encode(policyStartDate, forKey: "policy_start_date")
		}
		if reason != nil{
			aCoder.encode(reason, forKey: "reason")
		}
		if slug != nil{
			aCoder.encode(slug, forKey: "slug")
		}
		if taxAmount != nil{
			aCoder.encode(taxAmount, forKey: "tax_amount")
		}
		if timePeriod != nil{
			aCoder.encode(timePeriod, forKey: "time_period")
		}
		if totalAmount != nil{
			aCoder.encode(totalAmount, forKey: "total_amount")
		}
		if totalPrice != nil{
			aCoder.encode(totalPrice, forKey: "total_price")
		}
		if transactionDate != nil{
			aCoder.encode(transactionDate, forKey: "transaction_date")
		}
		if transactionDetailsId != nil{
			aCoder.encode(transactionDetailsId, forKey: "transaction_details_id")
		}
		if transectionStatus != nil{
			aCoder.encode(transectionStatus, forKey: "transection_status")
		}
		if txnId != nil{
			aCoder.encode(txnId, forKey: "txn_id")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if updatedBy != nil{
			aCoder.encode(updatedBy, forKey: "updated_by")
		}
		if usdAmount != nil{
			aCoder.encode(usdAmount, forKey: "usd_amount")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}
		if userinsurance != nil{
			aCoder.encode(userinsurance, forKey: "userinsurance")
		}
		if zone != nil{
			aCoder.encode(zone, forKey: "zone")
		}
		if address != nil{
			aCoder.encode(address, forKey: "address")
		}
		if agencyRepair != nil{
			aCoder.encode(agencyRepair, forKey: "agency_repair")
		}
		if basePremium != nil{
			aCoder.encode(basePremium, forKey: "base_premium")
		}
		if cancelDocument != nil{
			aCoder.encode(cancelDocument, forKey: "cancel_document")
		}
		if cancelReason != nil{
			aCoder.encode(cancelReason, forKey: "cancel_reason")
		}
		if chassisNo != nil{
			aCoder.encode(chassisNo, forKey: "chassis_no")
		}
		if claimStatus != nil{
			aCoder.encode(claimStatus, forKey: "claim_status")
		}
		if color != nil{
			aCoder.encode(color, forKey: "color")
		}
		if dailCode != nil{
			aCoder.encode(dailCode, forKey: "dail_code")
		}
		if dob != nil{
			aCoder.encode(dob, forKey: "dob")
		}
		if duration != nil{
			aCoder.encode(duration, forKey: "duration")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if engineNo != nil{
			aCoder.encode(engineNo, forKey: "engine_no")
		}
		if engineSize != nil{
			aCoder.encode(engineSize, forKey: "engine_size")
		}
		if fuelType != nil{
			aCoder.encode(fuelType, forKey: "fuel_type")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if idvAmount != nil{
			aCoder.encode(idvAmount, forKey: "idv_amount")
		}
		if modelYear != nil{
			aCoder.encode(modelYear, forKey: "model_year")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if phoneNo != nil{
			aCoder.encode(phoneNo, forKey: "phone_no")
		}
		if policyId != nil{
			aCoder.encode(policyId, forKey: "policy_id")
		}
		if postClaimAmount != nil{
			aCoder.encode(postClaimAmount, forKey: "post_claim_amount")
		}
		if registrationDate != nil{
			aCoder.encode(registrationDate, forKey: "registration_date")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if totalAddOnPrice != nil{
			aCoder.encode(totalAddOnPrice, forKey: "total_add_on_price")
		}
		if totalPremium != nil{
			aCoder.encode(totalPremium, forKey: "total_premium")
		}
		if txnData != nil{
			aCoder.encode(txnData, forKey: "txn_data")
		}
		if struserId != nil{
			aCoder.encode(struserId, forKey: "user_id")
		}
		if vehicleAge != nil{
			aCoder.encode(vehicleAge, forKey: "vehicle_age")
		}
		if vehicleBrand != nil{
			aCoder.encode(vehicleBrand, forKey: "vehicle_brand")
		}
		if vehicleInsuranceOptionalAddOn != nil{
			aCoder.encode(vehicleInsuranceOptionalAddOn, forKey: "vehicle_insurance_optional_add_on")
		}
		if vehicleModel != nil{
			aCoder.encode(vehicleModel, forKey: "vehicle_model")
		}
		if vehicleNo != nil{
			aCoder.encode(vehicleNo, forKey: "vehicle_no")
		}
		if vehiclePlanId != nil{
			aCoder.encode(vehiclePlanId, forKey: "vehicle_plan_id")
		}
		if vehicleType != nil{
			aCoder.encode(vehicleType, forKey: "vehicle_type")
		}
		if vehicleValue != nil{
			aCoder.encode(vehicleValue, forKey: "vehicle_value")
		}

	}

}
