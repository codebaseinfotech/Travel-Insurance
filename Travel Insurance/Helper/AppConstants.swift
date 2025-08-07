//
//  AppConstants.swift
//  FolkEvent
//
//  Created by Ankit Gabani on 11/07/23.
//

import Foundation
import UIKit

let CURRENT_USER_DATA = "currentUserData"

let CURRENT_MAIN_DATA = "MainData"

let PRIMARY_COLOR = UIColor(red: 28/255, green: 72/255, blue: 218/255, alpha: 1)

class AppManger {
    static var shared = AppManger()
    
    var isCarInsurance = true
    let vehicleStoryboard = UIStoryboard(name: "Vehicle", bundle: nil)
    
    // Vehicle details
    var vehicle_make: String = ""
    var vehicle_type: String = "2"
    var vehicle_no: String = ""
    var vehicle_plan_id: Int = 2
    var vehicle_brand: Int = 0
    var vehicle_model: String = ""
    var model_year: String = ""
    var registration_date: String = ""
    var fuel_type: String = ""
    var color: String = ""
    var engine_no: String = ""
    var chassis_no: String = ""
    var engine_size: Int = 0
    var vehicle_value: Int = 0
    var vehicle_age: Int = 0
    
    // Insurance premium
    var base_premium: Float = 0.0
    var agency_repair: Float = 0.0
    var total_premium: Float = 0.0
    
    // User information
    var name: String = ""
    var email: String = ""
    var dail_code: String = ""
    var phone_no: String = ""
    var dob: String = ""
    var policy_start_date: String = ""
    
    // Add-ons
    var addOnIds: [Int] = []
    var addOnPrices: [Int] = []
    
    // Transaction
    var txn_id: String = "12"
    var txn_data: String = "23"
    
    // Policy duration
    var duration: Int = 0
    
    var arrSelectAddOns: [TIGetAddOnVehicleAddOn] = []
    var dicGetPremium = THGerPremiumCalculationData()
    var arrAddAllPic: [UploadField] = []
}

