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
    var accountId: Int = 0
    var delegate: ProfileActionButton?
    
    override public func awakeFromNib() {
        let cancelTapGesture = UITapGestureRecognizer(target: self, action: #selector(cancelTapped))
        self.addGestureRecognizer(cancelTapGesture)
    }
    
    @IBAction func detaliiProfilTapped(_ sender: Any) {
        delegate?.detaliiProfilTapped(accountId: accountId)
    }
    
    @IBAction func adaugareInfoEvaluareTapped(_ sender: Any) {
        delegate?.adaugareInfoEvaluareTapped(accountId: accountId)
    }
    
    @IBAction func adaugareInformatiiDeplasariTapped(_ sender: Any) {
        delegate?.adaugareInformatiiDeplasariTapped(accountId: accountId)
    }
    
    @IBAction func istoricRaportariTapped(_ sender: Any) {
        delegate?.istoricRaportariTapped(accountId: accountId)
    }
    
    @objc func cancelTapped(){
        self.removeFromSuperview()
    }
}
