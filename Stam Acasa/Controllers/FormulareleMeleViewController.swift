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
        
        //istoricHeight.constant = 0;
        //self.view.layoutIfNeeded()
        //istoricView.removeFromSuperview()
        drawIstoric()
        
        //scrollView.contentSize.height = 1070
        contentView.translatesAutoresizingMaskIntoConstraints = true
        scrollviewHeight.constant = 1350
        contentView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: scrollviewHeight.constant)
        //scrollviewHeight.priority = .defaultHigh
        //self.view.layoutIfNeeded()
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
           
           for report in 0...responses!.count-1 where report < 3 {
               
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
    
    @IBAction func formulareEvaluareTapped(_ sender: Any) {
        let vc = UIStoryboard.Main.instantiateFlowStepVc()
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

