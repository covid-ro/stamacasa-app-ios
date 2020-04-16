//
//  DatePersonale.swift
//  Stam Acasa
//
//  Created by Sebi on 08/04/2020.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import Foundation
import UIKit

class DatePersonale: UIView {
    
    @IBOutlet weak var textNumePrenume: UITextField!
    
    @IBOutlet weak var textNumarTelefon: UITextField!
    
    @IBOutlet weak var dropDownJudet: DropDown!
    
    @IBOutlet weak var dropDownLocalitate: DropDown!
    
    @IBOutlet weak var dropDownVarsta: DropDown!
    
    @IBOutlet weak var dropDownGen: DropDown!


    var judetData: [String] = [String]()
    
    var localitateData: [String] = [String]()
    
    var genData: [String] = [String]()
    
    var decodedData: LocalitatiStruct?
    
    var delegate: DateNecesareContinue?
    
    override func awakeFromNib() {

        let json = StamAcasaSingleton.sharedInstance.readJSONFromFile(fileName: "localitati")
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            do{
                decodedData = try JSONDecoder().decode(LocalitatiStruct.self,from: data)
                }
//                completion(decodedData)
            catch let jsonError{
                print(jsonError)
            }
        } catch var myJSONError {
            print(myJSONError)
        }
        
        var jdt = decodedData?.judete as [LocalitatiStruct.Judet]?
        
        for i in jdt!{
            judetData.append(i.nume!)
        }
        
        genData.append("Barbat")
        genData.append("Femeie")
        
        dropDownVarsta.scrollToMiddle = true
        dropDownVarsta.selectedRowColor = UIColor(red: 242/255, green: 201/255, blue: 76/255, alpha: 1)
        dropDownVarsta.optionArray = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"]
        dropDownVarsta.isSearchEnable = false
        dropDownVarsta.listDidAppear {
            //print("Selected Varsta:r")
        }
        dropDownVarsta.didSelect{(selectedText , index ,id) in
            //print("Selected Varsta: \(selectedText) \n index: \(index)")
        }
        dropDownVarsta.listWillAppear(completion: {
            self.textNumePrenume.resignFirstResponder()
            self.textNumarTelefon.resignFirstResponder()
        })

        dropDownJudet.optionArray = judetData
        dropDownJudet.selectedRowColor = UIColor(red: 242/255, green: 201/255, blue: 76/255, alpha: 1)
        dropDownJudet.isSearchEnable = false
        dropDownJudet.didSelect{(selectedText , index ,id) in
            //print("Selected Judet: \(selectedText) \n index: \(index)")
            var x = (self.decodedData?.judete?[index])!  as LocalitatiStruct.Judet
            var loca = x.localitati as [LocalitatiStruct.Judet.Localitate]?
            for j in loca!{
                if j.comuna == nil {
                    self.localitateData.append(j.nume!)
                }
            }
            self.dropDownLocalitate.optionArray = self.localitateData
        }
        dropDownJudet.listWillAppear(completion: {
            self.textNumePrenume.resignFirstResponder()
            self.textNumarTelefon.resignFirstResponder()
        })
        
        dropDownLocalitate.optionArray = []
        dropDownLocalitate.selectedRowColor = UIColor(red: 242/255, green: 201/255, blue: 76/255, alpha: 1)
        dropDownLocalitate.isSearchEnable = false
        dropDownLocalitate.didSelect{(selectedText , index ,id) in
            //print( "Selected Localitate: \(selectedText) \n index: \(index)")
        }
        dropDownLocalitate.listWillAppear(completion: {
            self.textNumePrenume.resignFirstResponder()
            self.textNumarTelefon.resignFirstResponder()
        })
        
        dropDownGen.optionArray = genData
        dropDownGen.selectedRowColor = UIColor(red: 242/255, green: 201/255, blue: 76/255, alpha: 1)
        dropDownGen.isSearchEnable = false
        dropDownGen.didSelect{(selectedText , index ,id) in
            //print( "Selected Gen: \(selectedText) \n index: \(index)")
        }
        dropDownGen.listWillAppear(completion: {
            self.textNumePrenume.resignFirstResponder()
            self.textNumarTelefon.resignFirstResponder()
        })
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:))))
        
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.textNumePrenume.resignFirstResponder()
        self.textNumarTelefon.resignFirstResponder()
    }
    
    @IBAction func continuaTapped(_ sender: Any) {
        var formValidated = true
        if textNumePrenume.text == ""{
            textNumePrenume.backgroundColor = UIColor.red
            delegate?.validationFormAlert()
            formValidated = false
        } else{
            textNumePrenume.backgroundColor = UIColor.white
        }
        
        if textNumarTelefon.text == ""{
            textNumarTelefon.backgroundColor = UIColor.red
            delegate?.validationFormAlert()
            formValidated = false
        }else{
            textNumarTelefon.backgroundColor = UIColor.white
        }
        
        if dropDownJudet.text == ""{
            dropDownJudet.backgroundColor = UIColor.red
            delegate?.validationFormAlert()
            formValidated = false
        }else{
            dropDownJudet.backgroundColor = UIColor.white
        }
        
        if dropDownLocalitate.text == ""{
            dropDownLocalitate.backgroundColor = UIColor.red
            delegate?.validationFormAlert()
            formValidated = false
        }else{
            dropDownLocalitate.backgroundColor = UIColor.white
        }
        
        if dropDownVarsta.text == ""{
            dropDownVarsta.backgroundColor = UIColor.red
            delegate?.validationFormAlert()
            formValidated = false
        }else{
            dropDownVarsta.backgroundColor = UIColor.white
        }
        
        if dropDownGen.text == ""{
            dropDownGen.backgroundColor = UIColor.red
            delegate?.validationFormAlert()
            formValidated = false
        }else{
            dropDownGen.backgroundColor = UIColor.white
        }
        
        //if formValidated{
            delegate?.dateNecesareContinueTapped()
        //}
    }
    
}
