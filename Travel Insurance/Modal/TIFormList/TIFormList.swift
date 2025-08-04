//
//    TIFormList.swift
//
//    Create by Ankit Gabani on 23/9/2024
//    Copyright © 2024. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIFormList : NSObject, NSCoding{

    var data : TIFormListData!
    var success : Bool!


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
        if let dataData = dictionary["data"] as? NSDictionary{
            data = TIFormListData(fromDictionary: dataData)
        }
        else
        {
            data = TIFormListData(fromDictionary: NSDictionary.init())
        }
        success = dictionary["success"] as? Bool == nil ? false : dictionary["success"] as? Bool
    }

    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if data != nil{
            dictionary["data"] = data.toDictionary()
        }
        if success != nil{
            dictionary["success"] = success
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         data = aDecoder.decodeObject(forKey: "data") as? TIFormListData
         success = aDecoder.decodeObject(forKey: "success") as? Bool

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder)
    {
        if data != nil{
            aCoder.encode(data, forKey: "data")
        }
        if success != nil{
            aCoder.encode(success, forKey: "success")
        }

    }

}
