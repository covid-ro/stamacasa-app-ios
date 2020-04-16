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
    @IBOutlet weak var profilulTauView: UIView!
    
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
        
        StamAcasaSingleton.sharedInstance.decodedData = decodedData
     
        let profilulTauTapGesture = UITapGestureRecognizer(target: self, action: #selector(profilulTauTapped(sender:)))
        profilulTauView.addGestureRecognizer(profilulTauTapGesture)
    }
    
    @objc func profilulTauTapped(sender: UITapGestureRecognizer) {
        let vc = UIStoryboard.Main.instantiateFlowStepVc()
        
        vc.passedFlowId = "registration"
        //vc.passedSectionId = "date_personale"
        vc.passedSectionId = "stare_sanatate"
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
        
        
}

