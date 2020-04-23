//
//  DetaliiContViewController.swift
//  Stam Acasa
//
//  Created by Sebi on 23/04/2020.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import UIKit

class DetaliiContViewController: UIViewController {
    
    var passedAccountId: String?
    
    @IBOutlet weak var lbNumePrenume: UILabel!
    @IBOutlet weak var lbTelefon: UILabel!
    @IBOutlet weak var lbLocalitateJudet: UILabel!
    @IBOutlet weak var lbVarsta: UILabel!
    @IBOutlet weak var lbSex: UILabel!
    
    @IBOutlet weak var stamAcasaLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
