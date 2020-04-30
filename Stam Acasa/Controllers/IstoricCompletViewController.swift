//
//  IstoricCompletViewController.swift
//  Stam Acasa
//
//  Created by Sebi on 14/04/2020.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import Foundation
import UIKit

class IstoricCompletViewController: UIViewController{

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var menuLogoButton: UIImageView!
    @IBOutlet weak var stamAcasaLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StamAcasaSingleton.sharedInstance.actualAccountId = 0
        
        menuLogoButton.isUserInteractionEnabled = true
        let menuTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.menuTapped(_:)))
        menuLogoButton.addGestureRecognizer(menuTapGesture)
        
        
        var accounts = [] as [AccountData]?
        
        if let encodedData = UserDefaults.standard.object(forKey: "accounts") as? Data {
            let decoder = JSONDecoder()
            if let acx = try? decoder.decode([AccountData].self, from: encodedData) {
                accounts = acx
            }
        }
        
        for i in 0..<(accounts?.count ?? 0){
            if accounts![i].accountId == StamAcasaSingleton.sharedInstance.actualAccountId{
                
                for report in 0..<accounts![i].responses!.count  {
                    
                    var columnView = UIView.init(frame: CGRect.init(x: report*60, y: 0, width: 60, height: 420))
                    
                    var dataLabel = UILabel(frame: CGRect(x:0, y:0, width:60, height:60))
                    dataLabel.textAlignment = NSTextAlignment.center
                    dataLabel.text = accounts![i].responses![report].date
                    dataLabel.numberOfLines = 1
                    columnView.addSubview(dataLabel)
                    
                    var separator = UIView.init(frame: CGRect.init(x: 0, y: 59, width: 60, height: 1))
                    separator.backgroundColor = .lightGray
                    columnView.addSubview(separator)
                    
                    var rsps = accounts![i].responses![report].responses! as [ResponseData.Answer]
                    
                    for i in 1...6 {
                        var field = "NU" as String
                        
                        for ans in 0...rsps.count-1{
                            if rsps[ans].question_id == 10 && rsps[ans].answer_id == i {
                                field = "DA"
                            }
                        }
                        
                        var label = UILabel(frame: CGRect(x:0, y:i*60, width:60, height:60))
                        label.textAlignment = NSTextAlignment.center
                        label.font = UIFont.italicSystemFont(ofSize: 14)
                        label.text = field
                        if field=="DA" {
                            label.textColor = UIColor.red
                        }
                        columnView.addSubview(label)
                    }
                    scrollView.addSubview(columnView)
                }
                scrollView.contentSize = CGSize.init(width: accounts![i].responses!.count * 60, height: 420)
                
                break
            }
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        StamAcasaSingleton.sharedInstance.actualAccountId = 0
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

extension IstoricCompletViewController: SideMenu{
    func profilulMeuTapped() {
        let vc = UIStoryboard.Main.instantiateHomeVc()
        vc.formulareleMele = true
        vc.altePersoane = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileAltePersoaneTapped() {
        let vc = UIStoryboard.Main.instantiateHomeVc()
        vc.formulareleMele = false
        vc.altePersoane = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func istoricPersonalTapped() {
        
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
