//
//  AnswerView.swift
//  Stam Acasa
//
//  Created by Macbook on 4/9/20.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import Foundation
import UIKit

class AnswerView: UIView {
    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowRadius = 3.0;
        self.layer.shadowOpacity = 0.5;
        
    }
    
    
    
    
}
