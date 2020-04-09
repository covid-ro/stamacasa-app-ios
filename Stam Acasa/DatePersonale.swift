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
    
    @IBOutlet weak var textVarsta: UITextField!
    
    @IBOutlet weak var dropDownGen: DropDown!


    var judetData: [String] = [String]()
    
    var localitateData: [String] = [String]()
    
    var genData: [String] = [String]()
    
    var decodedData: LocalitatiStruct?
    
    override func awakeFromNib() {

        print("loaded date personale")
        
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
        
        
        
        
        
        
        

        dropDownJudet.optionArray = judetData
        dropDownJudet.isSearchEnable = false
        dropDownJudet.didSelect{(selectedText , index ,id) in
            print( "Selected Judet: \(selectedText) \n index: \(index)")
            var jdt = self.decodedData?.judete as [LocalitatiStruct.Judet]?
            var x = (jdt?[index])! as LocalitatiStruct.Judet
            var lct = x.localitati as [LocalitatiStruct.Judet.Localitate]?
            for j in lct!{
                if j.comuna == nil {
                    self.localitateData.append(j.nume!)
                }
            }
            self.dropDownLocalitate.optionArray = self.localitateData
        }
        
        dropDownLocalitate.optionArray = []
        dropDownLocalitate.isSearchEnable = false
        dropDownLocalitate.didSelect{(selectedText , index ,id) in
            print( "Selected Localitate: \(selectedText) \n index: \(index)")
        }
        
        dropDownGen.optionArray = genData
        dropDownGen.isSearchEnable = false
        dropDownGen.didSelect{(selectedText , index ,id) in
            print( "Selected Gen: \(selectedText) \n index: \(index)")
        }
        
        
    }
    
    /*
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView==judetPicker {
            return judetData.count
        } else if pickerView==localitatePicker {
            return localitateData.count
        } else if pickerView==genPicker {
            return 2
        } else {
            return 0
        }
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView==judetPicker {
            return judetData[row]
        } else if pickerView==localitatePicker {
            return localitateData[row]
        } else if pickerView==genPicker {
            return genData[row]
        } else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if pickerView==judetPicker {
            localitateData.removeAll()
            
            var jdt = decodedData?.judete as [LocalitatiStruct.Judet]?
            for i in jdt!{
                if i.nume!==judetData[row] {
                    var x = (jdt?[row])! as LocalitatiStruct.Judet
                    var lct = x.localitati as [LocalitatiStruct.Judet.Localitate]?
                    for j in lct!{
                        if j.comuna == nil {
                            localitateData.append(j.nume!)
                        }
                    }
                }
            }
            localitatePicker.reloadAllComponents()
        }
    }*/
}
