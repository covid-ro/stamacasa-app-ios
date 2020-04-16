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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawIstoric()
        
        //scrollView.contentSize.height = 1070
        contentView.translatesAutoresizingMaskIntoConstraints = true
        scrollviewHeight.constant = 1200
        contentView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: scrollviewHeight.constant)
        
        populateIstoricDeplasari()
    }
    
    func drawIstoric() {
       super.viewDidLoad()
       
       var responses : [ResponseData]?
       responses = []
       
       if let encodedData = UserDefaults.standard.object(forKey: "resps") as? Data {
           let decoder = JSONDecoder()
           if let rsx = try? decoder.decode([ResponseData].self, from: encodedData) {
               responses = rsx
           }
       }
       
       
       for report in 0..<responses!.count where report < 3 {
           
           var columnView = UIView.init(frame: CGRect.init(x: report*60, y: 0, width: 60, height: 420))
           
           var dataLabel = UILabel(frame: CGRect(x:0, y:0, width:60, height:60))
           dataLabel.textAlignment = NSTextAlignment.center
           dataLabel.text = responses![report].date
           dataLabel.numberOfLines = 1
           columnView.addSubview(dataLabel)
           
           var separator = UIView.init(frame: CGRect.init(x: 0, y: 59, width: 60, height: 1))
           separator.backgroundColor = .lightGray
           columnView.addSubview(separator)
           
           var rsps = responses![report].responses! as [ResponseData.Answer]
           
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
           columnsView.addSubview(columnView)
       }
       //scrollView.contentSize = CGSize.init(width: responses!.count * 60, height: 420)
    }
    
    func populateIstoricDeplasari(){
        var movementFormsFromUserDefaults: [ResponseData.Movement] = []
        if let encodedData = UserDefaults.standard.object(forKey: "movementForms") as? Data {
            let decoder = JSONDecoder()
            if let movementForms = try? decoder.decode([ResponseData.Movement].self, from: encodedData) {
                movementFormsFromUserDefaults = movementForms
            }
        }
        
        var yPositionInContentView: CGFloat = 890.0
        
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

        var counter: Int = 0
        for movement in movementFormsFromUserDefaults{
            
            let istoricDeplasariRow = Bundle.main.loadNibNamed("IstoricDeplasariRow", owner: self, options: nil)?.first as! IstoricDeplasariRow
            
            istoricDeplasariRow.translatesAutoresizingMaskIntoConstraints = true
            
            istoricDeplasariRow.frame = CGRect(x: 20.0, y: yPositionInContentView, width: UIScreen.main.bounds.width - 40.0, height: 60.0)
            istoricDeplasariRow.separatorView.isHidden = true
            istoricDeplasariRow.dateLabel.text = movementFormsFromUserDefaults[counter].date
            istoricDeplasariRow.leaveLabel.text = movementFormsFromUserDefaults[counter].leaveTime
            istoricDeplasariRow.arrivalLabel.text = movementFormsFromUserDefaults[counter].arriveTime
            istoricDeplasariRow.reasonLabel.text = movementFormsFromUserDefaults[counter].reason
            istoricDeplasariRow.contactLabel.text = movementFormsFromUserDefaults[counter].directContact
            contentView.addSubview(istoricDeplasariRow)
            
            yPositionInContentView += istoricDeplasariRow.frame.size.height
            counter += 1
            
            scrollviewHeight.constant += istoricDeplasariRow.frame.size.height
            contentView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: scrollviewHeight.constant)
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

