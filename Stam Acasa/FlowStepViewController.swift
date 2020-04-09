//
//  FlowStepViewController.swift
//  Stam Acasa
//
//  Created by Sebi on 08/04/2020.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import UIKit

class FlowStepViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*
        let flowContentView = Bundle.main.loadNibNamed("FlowContentView", owner: self, options: nil)?.first as! FlowContentView
        
        flowContentView.frame = CGRect(x: 20.0, y: 20.0, width: 50.0, height: 50.0)
        contentView.addSubview(flowContentView)
        */
        
        /*
        let datePersonale = Bundle.main.loadNibNamed("DatePersonale", owner: self, options: nil)?.first as! DatePersonale
        
        datePersonale.frame = CGRect(x: 0, y: 0.0, width: self.contentView.frame.size.width, height: 550)
        contentView.addSubview(datePersonale)
        */
        
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
