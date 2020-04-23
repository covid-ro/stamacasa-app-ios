//
//  ProfileViewActionView.swift
//  Stam Acasa
//
//  Created by Macbook on 4/23/20.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import Foundation
import UIKit

public class ProfileViewActionView: UIView{
    
    override public func awakeFromNib() {
        let cancelTapGesture = UITapGestureRecognizer(target: self, action: #selector(cancelTapped))
        self.addGestureRecognizer(cancelTapGesture)
    }
    
    @IBAction func detaliiProfilTapped(_ sender: Any) {
        
    }
    
    @IBAction func adaugareInfoEvaluareTapped(_ sender: Any) {
        
    }
    
    @IBAction func adaugareInformatiiDeplasariTapped(_ sender: Any) {
    }
    
    @IBAction func istoricRaportariTapped(_ sender: Any) {
        
    }
    
    @objc func cancelTapped(){
        self.removeFromSuperview()
    }
}
