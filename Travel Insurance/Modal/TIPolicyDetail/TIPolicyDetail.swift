//
//    TIPolicyDetail.swift
//
//    Create by Ankit Gabani on 23/9/2024
//    Copyright © 2024. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIPolicyDetail : NSObject, NSCoding{

    var invoiceUrl : String!
    var downloadInvoiceUrl : String!
    var downloadReportUrl : String!
    var message : String!
    var reportUrl : String!
    var response : [TIPolicyDetailResponse]!
    var status : Int!


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
        invoiceUrl = dictionary["Invoice_url"] as? String == nil ? "" : dictionary["Invoice_url"] as? String
        downloadInvoiceUrl = dictionary["download_invoice_url"] as? String == nil ? "" : dictionary["download_invoice_url"] as? String
        downloadReportUrl = dictionary["download_report_url"] as? String == nil ? "" : dictionary["download_report_url"] as? String
        message = dictionary["message"] as? String == nil ? "" : dictionary["message"] as? String
        reportUrl = dictionary["report_url"] as? String == nil ? "" : dictionary["report_url"] as? String
        response = [TIPolicyDetailResponse]()
        if let responseArray = dictionary["response"] as? [NSDictionary]{
            for dic in responseArray{
                let value = TIPolicyDetailResponse(fromDictionary: dic)
                response.append(value)
            }
        }
        status = dictionary["status"] as? Int == nil ? 0 : dictionary["status"] as? Int
    }

    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if invoiceUrl != nil{
            dictionary["Invoice_url"] = invoiceUrl
        }
        if downloadInvoiceUrl != nil{
            dictionary["download_invoice_url"] = downloadInvoiceUrl
        }
        if downloadReportUrl != nil{
            dictionary["download_report_url"] = downloadReportUrl
        }
        if message != nil{
            dictionary["message"] = message
        }
        if reportUrl != nil{
            dictionary["report_url"] = reportUrl
        }
        if response != nil{
            var dictionaryElements = [NSDictionary]()
            for responseElement in response {
                dictionaryElements.append(responseElement.toDictionary())
            }
            dictionary["response"] = dictionaryElements
        }
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         invoiceUrl = aDecoder.decodeObject(forKey: "Invoice_url") as? String
         downloadInvoiceUrl = aDecoder.decodeObject(forKey: "download_invoice_url") as? String
         downloadReportUrl = aDecoder.decodeObject(forKey: "download_report_url") as? String
         message = aDecoder.decodeObject(forKey: "message") as? String
         reportUrl = aDecoder.decodeObject(forKey: "report_url") as? String
         response = aDecoder.decodeObject(forKey: "response") as? [TIPolicyDetailResponse]
         status = aDecoder.decodeObject(forKey: "status") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder)
    {
        if invoiceUrl != nil{
            aCoder.encode(invoiceUrl, forKey: "Invoice_url")
        }
        if downloadInvoiceUrl != nil{
            aCoder.encode(downloadInvoiceUrl, forKey: "download_invoice_url")
        }
        if downloadReportUrl != nil{
            aCoder.encode(downloadReportUrl, forKey: "download_report_url")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if reportUrl != nil{
            aCoder.encode(reportUrl, forKey: "report_url")
        }
        if response != nil{
            aCoder.encode(response, forKey: "response")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }

    }

}
