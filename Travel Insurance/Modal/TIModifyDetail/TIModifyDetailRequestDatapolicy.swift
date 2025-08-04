//
//	TIModifyDetailRequestDatapolicy.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIModifyDetailRequestDatapolicy : NSObject, NSCoding{

	var agentPercentage : Int!
	var amountToSubtract : String!
	var currencySymbol : String!
	var diwanTax : String!
	var diwanTaxData : Float!
	var entitlement : Int!
	var iqdAmount : String!
	var iqdAmountAdjusted : String!
	var policyEndDate : String!
	var policyStartDate : String!
	var reason : String!
	var timePeriod : String!
	var transactionDetailsId : String!
	var userInsuranceId : Int!


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
		agentPercentage = dictionary["agent_percentage"] as? Int == nil ? 0 : dictionary["agent_percentage"] as? Int
		amountToSubtract = dictionary["amount_to_subtract"] as? String == nil ? "" : dictionary["amount_to_subtract"] as? String
		currencySymbol = dictionary["currencySymbol"] as? String == nil ? "" : dictionary["currencySymbol"] as? String
		diwanTax = dictionary["diwan_tax"] as? String == nil ? "" : dictionary["diwan_tax"] as? String
		diwanTaxData = dictionary["diwan_tax_data"] as? Float == nil ? 0 : dictionary["diwan_tax_data"] as? Float
		entitlement = dictionary["entitlement"] as? Int == nil ? 0 : dictionary["entitlement"] as? Int
		iqdAmount = dictionary["iqd_amount"] as? String == nil ? "" : dictionary["iqd_amount"] as? String
		iqdAmountAdjusted = dictionary["iqd_amount_adjusted"] as? String == nil ? "" : dictionary["iqd_amount_adjusted"] as? String
		policyEndDate = dictionary["policy_end_date"] as? String == nil ? "" : dictionary["policy_end_date"] as? String
		policyStartDate = dictionary["policy_start_date"] as? String == nil ? "" : dictionary["policy_start_date"] as? String
		reason = dictionary["reason"] as? String == nil ? "" : dictionary["reason"] as? String
		timePeriod = dictionary["time_period"] as? String == nil ? "" : dictionary["time_period"] as? String
		transactionDetailsId = dictionary["transaction_details_id"] as? String == nil ? "" : dictionary["transaction_details_id"] as? String
		userInsuranceId = dictionary["user_insurance_id"] as? Int == nil ? 0 : dictionary["user_insurance_id"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if agentPercentage != nil{
			dictionary["agent_percentage"] = agentPercentage
		}
		if amountToSubtract != nil{
			dictionary["amount_to_subtract"] = amountToSubtract
		}
		if currencySymbol != nil{
			dictionary["currencySymbol"] = currencySymbol
		}
		if diwanTax != nil{
			dictionary["diwan_tax"] = diwanTax
		}
		if diwanTaxData != nil{
			dictionary["diwan_tax_data"] = diwanTaxData
		}
		if entitlement != nil{
			dictionary["entitlement"] = entitlement
		}
		if iqdAmount != nil{
			dictionary["iqd_amount"] = iqdAmount
		}
		if iqdAmountAdjusted != nil{
			dictionary["iqd_amount_adjusted"] = iqdAmountAdjusted
		}
		if policyEndDate != nil{
			dictionary["policy_end_date"] = policyEndDate
		}
		if policyStartDate != nil{
			dictionary["policy_start_date"] = policyStartDate
		}
		if reason != nil{
			dictionary["reason"] = reason
		}
		if timePeriod != nil{
			dictionary["time_period"] = timePeriod
		}
		if transactionDetailsId != nil{
			dictionary["transaction_details_id"] = transactionDetailsId
		}
		if userInsuranceId != nil{
			dictionary["user_insurance_id"] = userInsuranceId
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         agentPercentage = aDecoder.decodeObject(forKey: "agent_percentage") as? Int
         amountToSubtract = aDecoder.decodeObject(forKey: "amount_to_subtract") as? String
         currencySymbol = aDecoder.decodeObject(forKey: "currencySymbol") as? String
         diwanTax = aDecoder.decodeObject(forKey: "diwan_tax") as? String
         diwanTaxData = aDecoder.decodeObject(forKey: "diwan_tax_data") as? Float
         entitlement = aDecoder.decodeObject(forKey: "entitlement") as? Int
         iqdAmount = aDecoder.decodeObject(forKey: "iqd_amount") as? String
         iqdAmountAdjusted = aDecoder.decodeObject(forKey: "iqd_amount_adjusted") as? String
         policyEndDate = aDecoder.decodeObject(forKey: "policy_end_date") as? String
         policyStartDate = aDecoder.decodeObject(forKey: "policy_start_date") as? String
         reason = aDecoder.decodeObject(forKey: "reason") as? String
         timePeriod = aDecoder.decodeObject(forKey: "time_period") as? String
         transactionDetailsId = aDecoder.decodeObject(forKey: "transaction_details_id") as? String
         userInsuranceId = aDecoder.decodeObject(forKey: "user_insurance_id") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if agentPercentage != nil{
			aCoder.encode(agentPercentage, forKey: "agent_percentage")
		}
		if amountToSubtract != nil{
			aCoder.encode(amountToSubtract, forKey: "amount_to_subtract")
		}
		if currencySymbol != nil{
			aCoder.encode(currencySymbol, forKey: "currencySymbol")
		}
		if diwanTax != nil{
			aCoder.encode(diwanTax, forKey: "diwan_tax")
		}
		if diwanTaxData != nil{
			aCoder.encode(diwanTaxData, forKey: "diwan_tax_data")
		}
		if entitlement != nil{
			aCoder.encode(entitlement, forKey: "entitlement")
		}
		if iqdAmount != nil{
			aCoder.encode(iqdAmount, forKey: "iqd_amount")
		}
		if iqdAmountAdjusted != nil{
			aCoder.encode(iqdAmountAdjusted, forKey: "iqd_amount_adjusted")
		}
		if policyEndDate != nil{
			aCoder.encode(policyEndDate, forKey: "policy_end_date")
		}
		if policyStartDate != nil{
			aCoder.encode(policyStartDate, forKey: "policy_start_date")
		}
		if reason != nil{
			aCoder.encode(reason, forKey: "reason")
		}
		if timePeriod != nil{
			aCoder.encode(timePeriod, forKey: "time_period")
		}
		if transactionDetailsId != nil{
			aCoder.encode(transactionDetailsId, forKey: "transaction_details_id")
		}
		if userInsuranceId != nil{
			aCoder.encode(userInsuranceId, forKey: "user_insurance_id")
		}

	}

}