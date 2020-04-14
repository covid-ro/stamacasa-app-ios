//
//  StamAcasaSingleton.swift
//  Stam Acasa
//
//  Created by Macbook on 4/8/20.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import Foundation

final class StamAcasaSingleton {
    static let sharedInstance = StamAcasaSingleton()
    var questionAnswers: [ResponseData.Answer]?
    
    func saveToUserDefaults(_ key:String,value: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    func getFromUserDefaults(_ key:String)->String {
        let userDefaults = UserDefaults.standard
        if(userDefaults.object(forKey: key) == nil) {
            return ""
        } else {
            let value = userDefaults.string(forKey: key)
            return String(value!)
        }
    }
    
    func saveToUserDefaults(_ key:String,value: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    func getFromUserDefaults(_ key:String)->Bool? {
        let userDefaults = UserDefaults.standard
        if(userDefaults.object(forKey: key) == nil) {
            return nil
        } else {
            let value = userDefaults.bool(forKey: key)
            return value
        }
    }
    
    func readJSONFromFile(fileName: String) -> Any?
    {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data)
            } catch {
                // Handle error here
            }
        }
        return json
    }

    
}
