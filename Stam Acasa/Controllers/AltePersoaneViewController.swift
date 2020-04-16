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

    @IBAction func adaugaAltePersoaneTapped(_ sender: Any) {
        
        let vc = UIStoryboard.Main.instantiateFlowStepVc()
        
        vc.passedFlowId = "registration"
        vc.passedSectionId = "date_personale"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
