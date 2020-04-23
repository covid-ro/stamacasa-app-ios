//
//  AltePersoaneViewController.swift
//  Stam Acasa
//
//  Created by Sebi on 13/04/2020.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import Foundation
import UIKit

class AltePersoaneViewController: UIViewController, ProfileActionButton {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    var accounts: [AccountData] = []
    var forms: [ResponseData] = []
    @IBOutlet weak var adaugaAltePersoaneButton: UIButton!
    var yPositionToAddViews: CGFloat = 0
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func adaugaAltePersoaneTapped(_ sender: Any) {
        
        let vc = UIStoryboard.Main.instantiateFlowStepVc()
        
        vc.passedFlowId = "registration"
        vc.passedSectionId = "date_personale"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.translatesAutoresizingMaskIntoConstraints = true
        contentView.frame.size.height -= 175.0 //fix because of homeVc header
        contentViewHeight.constant = contentView.frame.size.height
        self.contentView.frame.size.width = UIScreen.main.bounds.width
        
        yPositionToAddViews = adaugaAltePersoaneButton.frame.origin.y + adaugaAltePersoaneButton.frame.size.height + 30.0
        
       if let encodedData = UserDefaults.standard.object(forKey: "accounts") as? Data {
            let decoder = JSONDecoder()
            if let acx = try? decoder.decode([AccountData].self, from: encodedData) {
                accounts = acx
            }
        }
        
        var idCounter = 0
        for account in accounts{
            let profileView = Bundle.main.loadNibNamed("ProfileView", owner: self, options: nil)?.first as! ProfileView
            profileView.translatesAutoresizingMaskIntoConstraints = true
            profileView.tag = idCounter
            
            profileView.frame = CGRect(x: 20.0, y: yPositionToAddViews, width: self.view.frame.size.width - 40.0, height: 140.0)
            yPositionToAddViews += profileView.frame.size.height + 30.0
            
            profileView.profileName.text = account.numePrenume
            profileView.profileLocation.text = account.localitate
            profileView.lastFormDate.text = account.responses?.last?.dateWithHour
            
            profileView.delegate = self
            
            self.contentView.addSubview(profileView)
            
            idCounter += 1
            
            contentView.frame.size.height += profileView.frame.size.height + 30.0
            contentViewHeight.constant = contentView.frame.size.height
            
        }
        // Do any additional setup after loading the view.
    }
    
    func actionButtonTapped(tag: Int) {
        let profileViewActionView = Bundle.main.loadNibNamed("ProfileViewActionView", owner: self, options: nil)?.first as! ProfileViewActionView
        profileViewActionView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height - 175.0)
        
        self.view.addSubview(profileViewActionView)
    }
    
}

protocol ProfileActionButton{
    func actionButtonTapped(tag: Int)
}
