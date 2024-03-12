//
//  Convertable.swift
//  Project1
//
//  Created by Xinran Yu on 3/11/24.
//

import Foundation

protocol Convertable: Codable{
    // init object from json
    static func fromJson<T:Codable>(jsonObject:[String:Any])->T?
    
    // object to json
    func toJson() -> [String: Any]?
}

/// default implementation
extension Convertable{
    static func fromJson<T:Codable>(jsonObject:[String:Any])->T?{
        let decoder = JSONDecoder()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options:[]) else {return nil}
        do {
            return try decoder.decode(T.self, from: jsonData)
        } catch{
            print("fromJson error:\(error.localizedDescription)")
        }
        return nil
    }
    
    func toJson() -> [String:Any]?{
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else {return nil}
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
    }
}
