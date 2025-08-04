//
//	TIMyVehicleInsuranceVehicleClaim.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TIMyVehicleInsuranceVehicleClaim : NSObject, NSCoding{

	var vehicle : [TIMyVehicleInsuranceVehicle]!


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
		vehicle = [TIMyVehicleInsuranceVehicle]()
		if let vehicleArray = dictionary["vehicle"] as? [NSDictionary]{
			for dic in vehicleArray{
				let value = TIMyVehicleInsuranceVehicle(fromDictionary: dic)
				vehicle.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if vehicle != nil{
			var dictionaryElements = [NSDictionary]()
			for vehicleElement in vehicle {
				dictionaryElements.append(vehicleElement.toDictionary())
			}
			dictionary["vehicle"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         vehicle = aDecoder.decodeObject(forKey: "vehicle") as? [TIMyVehicleInsuranceVehicle]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if vehicle != nil{
			aCoder.encode(vehicle, forKey: "vehicle")
		}

	}

}