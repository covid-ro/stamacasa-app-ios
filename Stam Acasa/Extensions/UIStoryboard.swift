//
//  UIStoryboard.swift
//  Stam Acasa
//
//  Created by Macbook on 4/8/20.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    struct Main {
        static func instantiateFlowStepVc() -> FlowStepViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "flowStepVc") as! FlowStepViewController
            return controller
        }
        
        static func instantiateProfilCompletVc() -> ProfilCompletViewController{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "profilCompletVc") as! ProfilCompletViewController
            return controller
        }
        
        static func instantiateFormulareleMeleVC() -> FormulareleMeleViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "formulareleMeleVc") as! FormulareleMeleViewController
            return controller
        }
        
        static func instantiateAltePersoaneVc() -> AltePersoaneViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "altePersoaneVc") as! AltePersoaneViewController
            return controller
        }
    }
}
