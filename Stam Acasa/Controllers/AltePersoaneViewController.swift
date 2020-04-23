//
//  AltePersoaneViewController.swift
//  Stam Acasa
//
//  Created by Sebi on 13/04/2020.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import Foundation
import UIKit

class AltePersoaneViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    var accounts: [AccountData] = []
    var forms: [ResponseData] = []
    
    @IBAction func adaugaAltePersoaneTapped(_ sender: Any) {
        
        let vc = UIStoryboard.Main.instantiateFlowStepVc()
        
        vc.passedFlowId = "registration"
        vc.passedSectionId = "date_personale"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       if let encodedData = UserDefaults.standard.object(forKey: "accounts") as? Data {
            let decoder = JSONDecoder()
            if let acx = try? decoder.decode([AccountData].self, from: encodedData) {
                accounts = acx
            }
        }
        
        if let encodedData = UserDefaults.standard.object(forKey: "resps") as? Data {
            let decoder = JSONDecoder()
            if let rsx = try? decoder.decode([ResponseData].self, from: encodedData) {
                forms = rsx
            }
        }
        // Do any additional setup after loading the view.
    }

}
