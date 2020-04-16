//
//  ProfilCompletViewController.swift
//  Stam Acasa
//
//  Created by Macbook on 4/10/20.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import UIKit

class ProfilCompletViewController: UIViewController {
    @IBOutlet weak var stamAcasaLogo: UIImageView!
    
    @IBAction func continuaTapped(_ sender: Any) {
        let vc = UIStoryboard.Main.instantiateHomeVc()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stamAcasaLogo.isUserInteractionEnabled = true
        let menuTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.menuTapped(_:)))
        stamAcasaLogo.addGestureRecognizer(menuTapGesture)
        // Do any additional setup after loading the view.
    }

    @objc func menuTapped(_ sender : UITapGestureRecognizer){
           let menuView = Bundle.main.loadNibNamed("SideMenuView", owner: self, options: nil)?.first as! SideMenuView
           menuView.frame.size.width = self.view.frame.size.width
           menuView.frame.size.height = self.view.frame.size.height
           menuView.frame.origin.y = 0.0
           menuView.frame.origin.x = -UIScreen.main.bounds.width
           menuView.delegate = self
           self.view.addSubview(menuView)
           UIView.animate(withDuration: 1.0, animations: {
               menuView.frame.origin.x = 0.0
           })
       }
}

extension ProfilCompletViewController: SideMenu{
    func profilulMeuTapped() {
        let vc = UIStoryboard.Main.instantiateHomeVc()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            vc.pageMenu!.moveToPage(0)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileAltePersoaneTapped() {
        let vc = UIStoryboard.Main.instantiateHomeVc()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            vc.pageMenu!.moveToPage(1)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func istoricPersonalTapped() {
        let vc = UIStoryboard.Main.instantiateIstoricCompletVc()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func despreTapped() {
        let vc = UIStoryboard.Main.instantiateDespreVc()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setariTapped() {
        let vc = UIStoryboard.Main.instantiateSetariVc()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
