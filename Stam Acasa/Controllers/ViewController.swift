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
    var task: URLSessionDataTask!
    
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
        
        checkForceUpdate(url: "http://95.216.200.50/AUTOEVAL/boot.php")
    }
    
    func continueFlow(){
        var accounts = [] as [AccountData]?
        
        if let encodedData = UserDefaults.standard.object(forKey: "accounts") as? Data {
            let decoder = JSONDecoder()
            if let acx = try? decoder.decode([AccountData].self, from: encodedData) {
                accounts = acx
            }
        }
        
        if accounts!.count > 0 {
            let vc = UIStoryboard.Main.instantiateHomeVc()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let profilulTauTapGesture = UITapGestureRecognizer(target: self, action: #selector(profilulTauTapped(sender:)))
        profilulTauView.addGestureRecognizer(profilulTauTapGesture)
        
    }
    
    @objc func profilulTauTapped(sender: UITapGestureRecognizer) {
        let vc = UIStoryboard.Main.instantiateFlowStepVc()
        
        vc.passedFlowId = "registration"
        vc.passedSectionId = "date_personale"
        //vc.passedSectionId = "stare_sanatate"
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    var shouldUpdate = true
    func checkForceUpdate(url: String){
        guard let sUrl = URL(string: url) else {return}
        
        if(task != nil) {
            task.cancel()
        }
        
        let session = URLSessionConfiguration.default
        session.timeoutIntervalForRequest = 5
        session.timeoutIntervalForResource = 5
        task = URLSession(configuration: session).dataTask(with: sUrl) { (data,response,error) in
            self.task = nil
            if error != nil {
                print(error!.localizedDescription)
                DispatchQueue.main.async {
                    self.continueFlow()
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.continueFlow()
                }
                return
            }
            
            do {
                let jsonData = try JSONDecoder().decode(ForceUpdate.self, from: data)
                DispatchQueue.main.async {
                    var currentVersion = Bundle.main.object(forInfoDictionaryKey:     "CFBundleShortVersionString") as? String
                    for version in jsonData.data?.ios?.allowedversions ?? []{
                        if currentVersion == version{
                            self.shouldUpdate = false
                        }
                    }
                    
                    if self.shouldUpdate{
                        self.createUpdateAlert()
                    } else{
                        self.continueFlow()
                    }
                }
            } catch let jsonError {
                print(jsonError)
                DispatchQueue.main.async {
                    self.continueFlow()
                }
            }
        }
        task.resume()
    }
    
    func createUpdateAlert(){
        let alertController = UIAlertController(title: "ALERTĂ", message: "Această versiune a aplicației nu mai este suportată.Vă rugăm să actualizați aplicația din Apple Store.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            exit(0)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

