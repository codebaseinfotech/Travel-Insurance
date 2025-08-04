//
//    TIPolicyDetailResponse.swift
//
//    Create by Ankit Gabani on 23/9/2024
//    Copyright © 2024. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIPolicyDetailResponse : NSObject, NSCoding{

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
    var plans : TIPolicyDetailPlan!
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
    var transectionStatus : [TIPolicyDetailTransectionStatu]!
    var txnId : String!
    var updatedAt : String!
    var updatedBy : String!
    var usdAmount : String!
    var userId : Int!
    var userinsurancedata : [TIPolicyDetailUserinsurancedata]!
    var zone : String!
    var diwan_tax : String!
    var diwan_tax_percent : String!
    



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
            plans = TIPolicyDetailPlan(fromDictionary: plansData)
        }
        else
        {
            plans = TIPolicyDetailPlan(fromDictionary: NSDictionary.init())
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
        transectionStatus = [TIPolicyDetailTransectionStatu]()
        if let transectionStatusArray = dictionary["transection_status"] as? [NSDictionary]{
            for dic in transectionStatusArray{
                let value = TIPolicyDetailTransectionStatu(fromDictionary: dic)
                transectionStatus.append(value)
            }
        }
        txnId = dictionary["txn_id"] as? String == nil ? "" : dictionary["txn_id"] as? String
        updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
        updatedBy = dictionary["updated_by"] as? String == nil ? "" : dictionary["updated_by"] as? String
        usdAmount = dictionary["usd_amount"] as? String == nil ? "" : dictionary["usd_amount"] as? String
        userId = dictionary["user_id"] as? Int == nil ? 0 : dictionary["user_id"] as? Int
        userinsurancedata = [TIPolicyDetailUserinsurancedata]()
        if let userinsurancedataArray = dictionary["userinsurancedata"] as? [NSDictionary]{
            for dic in userinsurancedataArray{
                let value = TIPolicyDetailUserinsurancedata(fromDictionary: dic)
                userinsurancedata.append(value)
            }
        }
        zone = dictionary["zone"] as? String == nil ? "" : dictionary["zone"] as? String
        diwan_tax = dictionary["diwan_tax"] as? String == nil ? "" : dictionary["diwan_tax"] as? String
        diwan_tax_percent = dictionary["diwan_tax_percent"] as? String == nil ? "" : dictionary["diwan_tax_percent"] as? String
        
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
        if userinsurancedata != nil{
            var dictionaryElements = [NSDictionary]()
            for userinsurancedataElement in userinsurancedata {
                dictionaryElements.append(userinsurancedataElement.toDictionary())
            }
            dictionary["userinsurancedata"] = dictionaryElements
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
         plans = aDecoder.decodeObject(forKey: "plans") as? TIPolicyDetailPlan
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
         transectionStatus = aDecoder.decodeObject(forKey: "transection_status") as? [TIPolicyDetailTransectionStatu]
         txnId = aDecoder.decodeObject(forKey: "txn_id") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         updatedBy = aDecoder.decodeObject(forKey: "updated_by") as? String
         usdAmount = aDecoder.decodeObject(forKey: "usd_amount") as? String
         userId = aDecoder.decodeObject(forKey: "user_id") as? Int
         userinsurancedata = aDecoder.decodeObject(forKey: "userinsurancedata") as? [TIPolicyDetailUserinsurancedata]
         zone = aDecoder.decodeObject(forKey: "zone") as? String
        diwan_tax = aDecoder.decodeObject(forKey: "diwan_tax") as? String
        diwan_tax_percent = aDecoder.decodeObject(forKey: "diwan_tax_percent") as? String
        
        
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
        if userinsurancedata != nil{
            aCoder.encode(userinsurancedata, forKey: "userinsurancedata")
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
        
        
    }

}
