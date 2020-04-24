//
//  IstoricAltePersoaneViewController.swift
//  Stam Acasa
//
//  Created by Sebi on 23/04/2020.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import UIKit

class IstoricAltePersoaneViewController: UIViewController {

    @IBOutlet weak var stamAcasaLogo: UIImageView!
    @IBOutlet weak var scrollViewSimptome: UIScrollView!
    
    @IBOutlet weak var scrollviewHeight: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //StamAcasaSingleton.sharedInstance.actualAccountId = 0
        
        stamAcasaLogo.isUserInteractionEnabled = true
        let menuTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.menuTapped(_:)))
        stamAcasaLogo.addGestureRecognizer(menuTapGesture)
        
        
        populateIstoricSimptome()
        
        contentView.translatesAutoresizingMaskIntoConstraints = true
        scrollviewHeight.constant = 630
        contentView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: scrollviewHeight.constant)
        
        populateIstoricDeplasari()
        
    }
    
    func populateIstoricSimptome(){
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
                            //print(ans)
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
                    scrollViewSimptome.addSubview(columnView)
                }
                scrollViewSimptome.contentSize = CGSize.init(width: accounts![i].responses!.count * 60, height: 420)
                
                break
            }
        }
    }
    
       func populateIstoricDeplasari(){
        var accounts: [AccountData] = []
        if let encodedData = UserDefaults.standard.object(forKey: "accounts") as? Data {
            let decoder = JSONDecoder()
            if let accs = try? decoder.decode([AccountData].self, from: encodedData) {
                accounts = accs
            }
        }
        
        for account in accounts{
            if StamAcasaSingleton.sharedInstance.actualAccountId == account.accountId && account.movements!.count > 0 {
                
                var yPositionInContentView: CGFloat = 565.0
                
                let istoricDeplasariRow = Bundle.main.loadNibNamed("IstoricDeplasariRow", owner: self, options: nil)?.first as! IstoricDeplasariRow
                istoricDeplasariRow.translatesAutoresizingMaskIntoConstraints = true
                istoricDeplasariRow.frame = CGRect(x: 20.0, y: yPositionInContentView, width: UIScreen.main.bounds.width - 40.0, height: 60.0)
                istoricDeplasariRow.separatorView.isHidden = false
                istoricDeplasariRow.dateLabel.text = "Data"
                istoricDeplasariRow.leaveLabel.text = "Plecare"
                istoricDeplasariRow.arrivalLabel.text = "Sosire"
                istoricDeplasariRow.reasonLabel.text = "Motiv"
                istoricDeplasariRow.contactLabel.text = "Contact"
                contentView.addSubview(istoricDeplasariRow)
                
                yPositionInContentView += istoricDeplasariRow.frame.size.height

                for movement in account.movements ?? []{
                    
                    print(movement)
                    
                    let istoricDeplasariRow = Bundle.main.loadNibNamed("IstoricDeplasariRow", owner: self, options: nil)?.first as! IstoricDeplasariRow
                    
                    istoricDeplasariRow.translatesAutoresizingMaskIntoConstraints = true
                    
                    istoricDeplasariRow.frame = CGRect(x: 20.0, y: yPositionInContentView, width: UIScreen.main.bounds.width - 40.0, height: 60.0)
                    istoricDeplasariRow.separatorView.isHidden = true
                    istoricDeplasariRow.dateLabel.text = movement.date
                    istoricDeplasariRow.leaveLabel.text = movement.leaveTime
                    istoricDeplasariRow.arrivalLabel.text = movement.arriveTime
                    istoricDeplasariRow.reasonLabel.text = movement.reason
                    istoricDeplasariRow.contactLabel.text = movement.directContact
                    contentView.addSubview(istoricDeplasariRow)
                    
                    yPositionInContentView += istoricDeplasariRow.frame.size.height
                    
                    scrollviewHeight.constant += istoricDeplasariRow.frame.size.height
                    contentView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: scrollviewHeight.constant)
                }
                break
            }
        }
        
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

extension IstoricAltePersoaneViewController: SideMenu{
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
