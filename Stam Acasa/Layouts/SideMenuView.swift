//
//  MenuView.swift
//  Stam Acasa
//
//  Created by Macbook on 4/15/20.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import Foundation
import UIKit

public class SideMenuView: UIView{
    @IBOutlet weak var exitView: UIView!
    var delegate: SideMenu?
    
    public override func awakeFromNib() {
        let exitViewTap = UITapGestureRecognizer(target: self, action: #selector(exitViewTapped(_:)))
        exitView.addGestureRecognizer(exitViewTap)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.exitView.backgroundColor = UIColor.black
            self.exitView.alpha = 0.5
        }
    }
    
    @objc func exitViewTapped(_ sender: UITapGestureRecognizer){
        self.removeFromSuperview()
    }
    
    @IBAction func profilulMeuTapped(_ sender: Any) {
        self.removeFromSuperview()
        delegate?.profilulMeuTapped()
    }
    
    @IBAction func profileAltePersoaneTapped(_ sender: Any) {
        self.removeFromSuperview()
        delegate?.profileAltePersoaneTapped()
    }
    
    @IBAction func istoricPersonalTapped(_ sender: Any) {
        self.removeFromSuperview()
        delegate?.istoricPersonalTapped()
    }
    
    @IBAction func setariTapped(_ sender: Any) {
        delegate?.setariTapped()
    }
    
    @IBAction func despreTapped(_ sender: Any) {
        delegate?.despreTapped()
    }
}


