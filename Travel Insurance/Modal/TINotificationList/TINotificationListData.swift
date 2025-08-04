//
//    TINotificationListData.swift
//
//    Create by Ankit Gabani on 16/9/2024
//    Copyright © 2024. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TINotificationListData : NSObject, NSCoding{

    var createdAt : String!
    var id : Int!
    var msg : String!
    var status : Int!
    var title : String!
    var type : String!
    var updatedAt : String!
    var userId : Int!


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
        createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
        id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
        msg = dictionary["msg"] as? String == nil ? "" : dictionary["msg"] as? String
        status = dictionary["status"] as? Int == nil ? 0 : dictionary["status"] as? Int
        title = dictionary["title"] as? String == nil ? "" : dictionary["title"] as? String
        type = dictionary["type"] as? String == nil ? "" : dictionary["type"] as? String
        updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
        userId = dictionary["user_id"] as? Int == nil ? 0 : dictionary["user_id"] as? Int
    }

    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if id != nil{
            dictionary["id"] = id
        }
        if msg != nil{
            dictionary["msg"] = msg
        }
        if status != nil{
            dictionary["status"] = status
        }
        if title != nil{
            dictionary["title"] = title
        }
        if type != nil{
            dictionary["type"] = type
        }
        if updatedAt != nil{
            dictionary["updated_at"] = updatedAt
        }
        if userId != nil{
            dictionary["user_id"] = userId
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         msg = aDecoder.decodeObject(forKey: "msg") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Int
         title = aDecoder.decodeObject(forKey: "title") as? String
         type = aDecoder.decodeObject(forKey: "type") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         userId = aDecoder.decodeObject(forKey: "user_id") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder)
    {
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if msg != nil{
            aCoder.encode(msg, forKey: "msg")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "user_id")
        }

    }

}
