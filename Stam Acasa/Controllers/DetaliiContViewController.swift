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
    
    @IBOutlet weak var labelDetalii: UILabel!
    @IBOutlet weak var stamAcasaLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stamAcasaLogo.isUserInteractionEnabled = true
        let menuTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.menuTapped(_:)))
        stamAcasaLogo.addGestureRecognizer(menuTapGesture)
        
        ///de sters urmatoarea linie:
        StamAcasaSingleton.sharedInstance.actualAccountId = 0
        
        let titleAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.init(red: 60.0/255, green: 38.0/255, blue: 83.0/255, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)]
        
        let questionAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 15)]
        
        let answerAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]

        let carnat = NSMutableAttributedString(string: "Date Personame\n ", attributes: titleAttributes)
        
        //.font: UIFont.boldSystemFont(ofSize: 36)
        
        
        var accounts = [] as [AccountData]?
        
        if let encodedData = UserDefaults.standard.object(forKey: "accounts") as? Data {
            let decoder = JSONDecoder()
            if let acx = try? decoder.decode([AccountData].self, from: encodedData) {
                accounts = acx
            }
        }
        
        for i in 0..<(accounts?.count ?? 0){
            if accounts![i].accountId == StamAcasaSingleton.sharedInstance.actualAccountId{
                
                let datePersonale = NSAttributedString(string:
                    "\nNume: "+accounts![i].numePrenume!+"\nNumar Telefon:"+accounts![i].numarTelefon!+"\nJudet:"+accounts![i].judet!+"\nLocalitate:"+accounts![i].localitate!+"\nVarsta:"+accounts![i].varsta!+"\nGen:"+accounts![i].gen!+"\n"
                
                )
                carnat.append(datePersonale)
                
                
                
                for report in 0..<accounts![i].responses!.count  {
                    if accounts![i].responses![report].flow_id == "registration" {
                        
                        var lastSectionId = "" as String
                        var lastQuestionId = -1 as Int
                        
                        var rsps = accounts![i].responses![report].responses! as [ResponseData.Answer]
                        for ans in 0...rsps.count-1{
                            if rsps[ans].section_id != lastSectionId {
                                let sectiune = NSMutableAttributedString(string: "\n\n " + rsps[ans].section_name!+"\n ", attributes: titleAttributes)
                                carnat.append(sectiune)
                            }
                            
                            if rsps[ans].question_id != lastQuestionId {
                                let intrebare = NSMutableAttributedString(string: "\n " + rsps[ans].question_text!+"\n ", attributes: questionAttributes)
                                carnat.append(intrebare)
                            }
                            
                            let raspuns = NSMutableAttributedString(string: rsps[ans].answer_text!+"\n ", attributes: answerAttributes)
                            carnat.append(raspuns)
                            
                            lastSectionId = rsps[ans].section_id!
                            lastQuestionId = rsps[ans].question_id!
                        }
                        
                    }
                    
                }
                
                
                break
            }
        }
        
        
        labelDetalii.attributedText = carnat
        
        
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


extension DetaliiContViewController: SideMenu{
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
