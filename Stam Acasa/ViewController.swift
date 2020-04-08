//
//  ViewController.swift
//  Stam Acasa
//
//  Created by Macbook on 4/7/20.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var decodedData: MyData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let json = StamAcasaSingleton.sharedInstance.readJSONFromFile(fileName: "json_stam_acasa_alternativa")
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            do{
                decodedData = try JSONDecoder().decode(MyData.self,from: data)
                }
//                completion(decodedData)
            catch let jsonError{
                print(jsonError)
            }
        } catch var myJSONError {
            print(myJSONError)
        }
        
    }
    
}

