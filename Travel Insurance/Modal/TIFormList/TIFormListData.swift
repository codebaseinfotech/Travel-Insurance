//
//    TIFormListData.swift
//
//    Create by Ankit Gabani on 23/9/2024
//    Copyright © 2024. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIFormListData : NSObject, NSCoding{

    var order : TIFormListOrder!


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
        if let orderData = dictionary["order"] as? NSDictionary{
            order = TIFormListOrder(fromDictionary: orderData)
        }
        else
        {
            order = TIFormListOrder(fromDictionary: NSDictionary.init())
        }
    }

    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if order != nil{
            dictionary["order"] = order.toDictionary()
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         order = aDecoder.decodeObject(forKey: "order") as? TIFormListOrder

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder)
    {
        if order != nil{
            aCoder.encode(order, forKey: "order")
        }

    }

}
