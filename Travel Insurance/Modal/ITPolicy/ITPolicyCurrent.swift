//
//	ITPolicyCurrent.swift
//
//	Create by iMac on 22/2/2024
//	Copyright © 2024. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ITPolicyCurrent : NSObject, NSCoding{

	var cancellationDocument : String!
	var cardType : String!
	var createdAt : String!
	var createdBy : Int!
	var currency : String!
	var orderId : String!
	var orderStatus : String!
	var payment : String!
	var paymentMode : String!
	var paymentResponse : String!
	var paymentStatus : Int!
	var planId : Int!
	var plans : ITPolicyPlan!
	var policyEndDate : String!
	var policyNo : String!
	var policyStartDate : String!
	var reason : String!
	var slug : String!
	var taxAmount : String!
	var timePeriod : String!
	var totalPrice : String!
	var transactionDate : String!
	var transactionDetailsId : Int!
	var transectionStatus : [ITPolicyTransectionStatu]!
	var txnId : String!
	var updatedAt : String!
	var updatedBy : String!
	var userId : Int!
	var userinsurance : [ITPolicyUserinsurance]!
	var zone : String!
    var currencySymbol : String!


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
		cancellationDocument = dictionary["cancellationDocument"] as? String == nil ? "" : dictionary["cancellationDocument"] as? String
		cardType = dictionary["card_type"] as? String == nil ? "" : dictionary["card_type"] as? String
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		createdBy = dictionary["created_by"] as? Int == nil ? 0 : dictionary["created_by"] as? Int
		currency = dictionary["currency"] as? String == nil ? "" : dictionary["currency"] as? String
		orderId = dictionary["order_id"] as? String == nil ? "" : dictionary["order_id"] as? String
		orderStatus = dictionary["order_status"] as? String == nil ? "" : dictionary["order_status"] as? String
		payment = dictionary["payment"] as? String == nil ? "" : dictionary["payment"] as? String
		paymentMode = dictionary["payment_mode"] as? String == nil ? "" : dictionary["payment_mode"] as? String
		paymentResponse = dictionary["payment_response"] as? String == nil ? "" : dictionary["payment_response"] as? String
		paymentStatus = dictionary["payment_status"] as? Int == nil ? 0 : dictionary["payment_status"] as? Int
		planId = dictionary["plan_id"] as? Int == nil ? 0 : dictionary["plan_id"] as? Int
		if let plansData = dictionary["plans"] as? NSDictionary{
			plans = ITPolicyPlan(fromDictionary: plansData)
		}
		else
		{
			plans = ITPolicyPlan(fromDictionary: NSDictionary.init())
		}
		policyEndDate = dictionary["policy_end_date"] as? String == nil ? "" : dictionary["policy_end_date"] as? String
		policyNo = dictionary["policy_no"] as? String == nil ? "" : dictionary["policy_no"] as? String
		policyStartDate = dictionary["policy_start_date"] as? String == nil ? "" : dictionary["policy_start_date"] as? String
		reason = dictionary["reason"] as? String == nil ? "" : dictionary["reason"] as? String
		slug = dictionary["slug"] as? String == nil ? "" : dictionary["slug"] as? String
		taxAmount = dictionary["tax_amount"] as? String == nil ? "" : dictionary["tax_amount"] as? String
		timePeriod = dictionary["time_period"] as? String == nil ? "" : dictionary["time_period"] as? String
		totalPrice = dictionary["total_price"] as? String == nil ? "" : dictionary["total_price"] as? String
		transactionDate = dictionary["transaction_date"] as? String == nil ? "" : dictionary["transaction_date"] as? String
		transactionDetailsId = dictionary["transaction_details_id"] as? Int == nil ? 0 : dictionary["transaction_details_id"] as? Int
		transectionStatus = [ITPolicyTransectionStatu]()
		if let transectionStatusArray = dictionary["transection_status"] as? [NSDictionary]{
			for dic in transectionStatusArray{
				let value = ITPolicyTransectionStatu(fromDictionary: dic)
				transectionStatus.append(value)
			}
		}
		txnId = dictionary["txn_id"] as? String == nil ? "" : dictionary["txn_id"] as? String
		updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
		updatedBy = dictionary["updated_by"] as? String == nil ? "" : dictionary["updated_by"] as? String
		userId = dictionary["user_id"] as? Int == nil ? 0 : dictionary["user_id"] as? Int
		userinsurance = [ITPolicyUserinsurance]()
		if let userinsuranceArray = dictionary["userinsurance"] as? [NSDictionary]{
			for dic in userinsuranceArray{
				let value = ITPolicyUserinsurance(fromDictionary: dic)
				userinsurance.append(value)
			}
		}
		zone = dictionary["zone"] as? String == nil ? "" : dictionary["zone"] as? String
        currencySymbol = dictionary["currencySymbol"] as? String == nil ? "" : dictionary["currencySymbol"] as? String

	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
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
		if orderId != nil{
			dictionary["order_id"] = orderId
		}
		if orderStatus != nil{
			dictionary["order_status"] = orderStatus
		}
		if payment != nil{
			dictionary["payment"] = payment
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
        if currencySymbol != nil{
            dictionary["currencySymbol"] = currencySymbol
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         cancellationDocument = aDecoder.decodeObject(forKey: "cancellationDocument") as? String
         cardType = aDecoder.decodeObject(forKey: "card_type") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         createdBy = aDecoder.decodeObject(forKey: "created_by") as? Int
         currency = aDecoder.decodeObject(forKey: "currency") as? String
         orderId = aDecoder.decodeObject(forKey: "order_id") as? String
         orderStatus = aDecoder.decodeObject(forKey: "order_status") as? String
         payment = aDecoder.decodeObject(forKey: "payment") as? String
         paymentMode = aDecoder.decodeObject(forKey: "payment_mode") as? String
         paymentResponse = aDecoder.decodeObject(forKey: "payment_response") as? String
         paymentStatus = aDecoder.decodeObject(forKey: "payment_status") as? Int
         planId = aDecoder.decodeObject(forKey: "plan_id") as? Int
         plans = aDecoder.decodeObject(forKey: "plans") as? ITPolicyPlan
         policyEndDate = aDecoder.decodeObject(forKey: "policy_end_date") as? String
         policyNo = aDecoder.decodeObject(forKey: "policy_no") as? String
         policyStartDate = aDecoder.decodeObject(forKey: "policy_start_date") as? String
         reason = aDecoder.decodeObject(forKey: "reason") as? String
         slug = aDecoder.decodeObject(forKey: "slug") as? String
         taxAmount = aDecoder.decodeObject(forKey: "tax_amount") as? String
         timePeriod = aDecoder.decodeObject(forKey: "time_period") as? String
         totalPrice = aDecoder.decodeObject(forKey: "total_price") as? String
         transactionDate = aDecoder.decodeObject(forKey: "transaction_date") as? String
         transactionDetailsId = aDecoder.decodeObject(forKey: "transaction_details_id") as? Int
         transectionStatus = aDecoder.decodeObject(forKey: "transection_status") as? [ITPolicyTransectionStatu]
         txnId = aDecoder.decodeObject(forKey: "txn_id") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         updatedBy = aDecoder.decodeObject(forKey: "updated_by") as? String
         userId = aDecoder.decodeObject(forKey: "user_id") as? Int
         userinsurance = aDecoder.decodeObject(forKey: "userinsurance") as? [ITPolicyUserinsurance]
         zone = aDecoder.decodeObject(forKey: "zone") as? String
        currencySymbol = aDecoder.decodeObject(forKey: "currencySymbol") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
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
		if orderId != nil{
			aCoder.encode(orderId, forKey: "order_id")
		}
		if orderStatus != nil{
			aCoder.encode(orderStatus, forKey: "order_status")
		}
		if payment != nil{
			aCoder.encode(payment, forKey: "payment")
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
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}
		if userinsurance != nil{
			aCoder.encode(userinsurance, forKey: "userinsurance")
		}
		if zone != nil{
			aCoder.encode(zone, forKey: "zone")
		}
        if currencySymbol != nil{
            aCoder.encode(currencySymbol, forKey: "currencySymbol")
        }

	}

}
