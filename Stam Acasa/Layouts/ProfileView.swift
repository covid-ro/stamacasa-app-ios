//
//  ProfileView.swift
//  Stam Acasa
//
//  Created by Macbook on 4/23/20.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import Foundation
import UIKit

public class ProfileView: UIView{
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileLocation: UILabel!
    @IBOutlet weak var lastFormDate: UILabel!
    
    var delegate: ProfileActionButton?
    
    override public func awakeFromNib() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowRadius = 1
        self.layer.cornerRadius = 10.0
    }
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        delegate?.actionButtonTapped(accountId: self.tag)
    }
}
