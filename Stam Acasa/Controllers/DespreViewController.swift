//
//  DespreViewController.swift
//  Stam Acasa
//
//  Created by Macbook on 4/15/20.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import UIKit

class DespreViewController: UIViewController {
    @IBOutlet weak var versionNumberLabel: UILabel!
    @IBOutlet weak var govButton: UIButton!
    @IBOutlet weak var frameworksUsedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        versionNumberLabel.text = "Versiunea \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)" 
        // Do any additional setup after loading the view.
    }
    
    @IBAction func govButtonTapped(_ sender: Any) {
        guard let url = URL(string: govButton!.titleLabel!.text!) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
