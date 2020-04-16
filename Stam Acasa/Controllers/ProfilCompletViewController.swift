//
//  ProfilCompletViewController.swift
//  Stam Acasa
//
//  Created by Macbook on 4/10/20.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import UIKit

class ProfilCompletViewController: UIViewController {

    @IBAction func continuaTapped(_ sender: Any) {
        let vc = UIStoryboard.Main.instantiateHomeVc()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

}
