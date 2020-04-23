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
        
        static func instantiateDespreVc() -> DespreViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "despreVc") as! DespreViewController
            return controller
        }
        
        static func instantiateSetariVc() -> SetariViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "setariVc") as! SetariViewController
            return controller
        }
        
        static func instantiateIstoricCompletVc() -> IstoricCompletViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "istoricCompletVc") as! IstoricCompletViewController
            return controller
        }
        
        static func instantiateHomeVc() -> HomeViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "homeVc") as! HomeViewController
            return controller
        }
        
        static func instantiateFormularDeplasariVc() -> FormularDeplasariViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "formularDeplasariVc") as! FormularDeplasariViewController
            return controller
        }
        
        static func instantiateDetaliiContViewController() -> DetaliiContViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "detaliiContVc") as! DetaliiContViewController
            return controller
        }
        
        static func instantiateIstoricAltePersoaneVc() -> IstoricAltePersoaneViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "istoricAltePersoaneVc") as! IstoricAltePersoaneViewController
            return controller
        }
    }
}
