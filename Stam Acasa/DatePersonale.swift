//
//  DatePersonale.swift
//  Stam Acasa
//
//  Created by Sebi on 08/04/2020.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import Foundation
import UIKit

class DatePersonale: UIView, UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var judet: UIPickerView!
    
    @IBOutlet weak var localitate: UIPickerView!
    
    var judetData: [String] = [String]()
    
    var localitateData: [String] = [String]()
    
    override func awakeFromNib() {

        print("loaded date personale")
        
        judetData = ["Bucuresti", "Alba", "Arad", "Argeș", "Bacău", "Bihor", "Bistrița-Năsăud", "Botoșani", "Brașov", "Brăila", "Buzău", "Caraș-Severin", "Călărași", "Cluj", "Constanța", "Covasna", "Dâmbovița", "Dolj", "Galați", "Giurgiu", "Gorj", "Harghita", "Hunedoara", "Ialomița", "Iași", "Ilfov", "Maramureș", "Mehedinți", "Mureș", "Neamț", "Olt", "Prahova", "Satu Mare", "Sălaj", "Sibiu", "Suceava", "Teleorman", "Timiș", "Tulcea", "Vaslui", "Vâlcea", "Vrancea"]
        
        localitateData =  ["loc 1", "loc 2", "loc 3", "loc 4", "loc 5", "loc 6"]
        
        self.judet.delegate = self
        self.judet.dataSource = self
        
        self.localitate.delegate = self
        self.localitate.dataSource = self
        
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView==judet {
            return judetData.count
        } else if pickerView==localitate {
            return localitateData.count
        } else {
            return 0
        }
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView==judet {
            return judetData[row]
        } else if pickerView==localitate {
            return localitateData[row]
        } else {
            return ""
        }
    }
    
}
