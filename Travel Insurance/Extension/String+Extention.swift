//
//  String+Extention.swift
//  Hamraa Insurance
//
//  Created by Ankit Gabani on 07/08/25.
//

import Foundation

extension String {
    
    /// Generates a random boundary string for multipart/form-data requests
    static func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
    /// Generates a random alphanumeric string of specified length
    static func randomString(of length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).compactMap { _ in letters.randomElement() })
    }
}

extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
