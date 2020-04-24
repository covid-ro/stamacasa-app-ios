//
//  FormulareleMeleViewController.swift
//  Stam Acasa
//
//  Created by Sebi on 13/04/2020.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import Foundation
import UIKit

class FormulareleMeleViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var istoricView: UIView!
    @IBOutlet weak var columnsView: UIView!
    @IBOutlet weak var istoricHeight: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var scrollviewHeight: NSLayoutConstraint!
    @IBOutlet weak var istoricDeplasariLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StamAcasaSingleton.sharedInstance.actualAccountId = 0
        
        drawIstoric()
        
        populateIstoricDeplasari()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        StamAcasaSingleton.sharedInstance.actualAccountId = 0
    }

    func drawIstoric() {
       super.viewDidLoad()
       
       
        
        
        var accounts = [] as [AccountData]?
        
        if let encodedData = UserDefaults.standard.object(forKey: "accounts") as? Data {
            let decoder = JSONDecoder()
            if let acx = try? decoder.decode([AccountData].self, from: encodedData) {
                accounts = acx
            }
        }
        
        for i in 0..<(accounts?.count ?? 0){
            if accounts![i].accountId == StamAcasaSingleton.sharedInstance.actualAccountId{
                
                for report in 0..<accounts![i].responses!.count where report < 3 {
                    
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
                    columnsView.addSubview(columnView)
                }
                break
            }
        }
        
    }
    
    func populateIstoricDeplasari(){
        
        //scrollView.contentSize.height = 1070
        contentView.translatesAutoresizingMaskIntoConstraints = true
        scrollviewHeight.constant = 1200
        contentView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: scrollviewHeight.constant)
        
        
        var accounts: [AccountData] = []
        if let encodedData = UserDefaults.standard.object(forKey: "accounts") as? Data {
            let decoder = JSONDecoder()
            if let accs = try? decoder.decode([AccountData].self, from: encodedData) {
                accounts = accs
            }
        }
        
        for account in accounts{
            if StamAcasaSingleton.sharedInstance.actualAccountId == account.accountId && account.movements!.count > 0 {
                
                var yPositionInContentView: CGFloat = istoricDeplasariLabel.frame.origin.y + istoricDeplasariLabel.frame.size.height + 10.0
                
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
                scrollviewHeight.constant += istoricDeplasariRow.frame.size.height
                contentView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: scrollviewHeight.constant)

                for movement in account.movements ?? []{
                    
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

    @IBAction func formulareEvaluareTapped(_ sender: Any) {
        let vc = UIStoryboard.Main.instantiateFlowStepVc()
        vc.passedFlowId = "evaluare"
        vc.passedSectionId = "simptome"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func formulareDeplasariTapped(_ sender: Any) {
        let vc = UIStoryboard.Main.instantiateFormularDeplasariVc()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func istoricCompletTapped(_ sender: Any) {
        let vc = UIStoryboard.Main.instantiateIstoricCompletVc()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

