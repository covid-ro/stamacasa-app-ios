//
//  FormularDeplasariViewController.swift
//  Stam Acasa
//
//  Created by Macbook on 4/16/20.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import UIKit

class FormularDeplasariViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var motivulDeplasariInputField: UITextField!
    @IBOutlet weak var daView: UIView!
    @IBOutlet weak var nuView: UIView!
    @IBOutlet weak var motivulDeplasariiQuestionView: PaddingLabel!
    @IBOutlet weak var oraPlecariiLabel: UILabel!
    @IBOutlet weak var oraIntoarceriiLabel: UILabel!
    @IBOutlet weak var contactDirectView: PaddingLabel!
    @IBOutlet weak var oraPlecariiDatePicker: UIDatePicker!
    @IBOutlet weak var oraIntoarceriiDatePicker: UIDatePicker!
    @IBOutlet weak var menuLogoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let answerDaTapGesture = UITapGestureRecognizer(target: self, action: #selector(answerTapped(_:)))
        let answerNuTapGesture = UITapGestureRecognizer(target: self, action: #selector(answerTapped(_:)))
        
        daView.addGestureRecognizer(answerDaTapGesture)
        nuView.addGestureRecognizer(answerNuTapGesture)
        
        menuLogoImage.isUserInteractionEnabled = true
        let menuTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.menuTapped(_:)))
        menuLogoImage.addGestureRecognizer(menuTapGesture)
        
        applyShadowForLabel(view: daView)
        applyShadowForLabel(view: nuView)
        
        motivulDeplasariInputField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        motivulDeplasariInputField.resignFirstResponder()
        
        return true
    }
    
    func applyShadowForLabel(view: UIView){
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowRadius = 3.0;
        view.layer.shadowOpacity = 0.5;
    }
    
    func validationFormAlert(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_: UIAlertAction) in
            self.navigationController?.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func answerTapped(_ sender: UITapGestureRecognizer){
        let view = sender.view
        
        daView.backgroundColor = UIColor.white
        nuView.backgroundColor = UIColor.white
        
        view?.backgroundColor = UIColor(red: 189.0/255.0, green: 146.0/255.0, blue: 190.0/255.0, alpha: 1.0)
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
    
    @IBAction func trimiteRaspunsurileTapped(_ sender: Any) {
        var formValidated = true
        if motivulDeplasariInputField.text == ""{
            formValidated = false
            motivulDeplasariiQuestionView.backgroundColor = UIColor.red
        } else{
            motivulDeplasariiQuestionView.backgroundColor = UIColor(red: 79.0/255.0, green: 59.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        }
        
        if (daView.backgroundColor == UIColor.white) && (nuView.backgroundColor == UIColor.white){
            formValidated = false
            contactDirectView.backgroundColor = UIColor.red
        } else{
            contactDirectView.backgroundColor = UIColor(red: 79.0/255.0, green: 59.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        }
        
        if formValidated{
            //validationFormAlert(title: "SUCCES", message: "Formularul dumneavoastra a fost inregistrat cu succes!")
            
            var storeMovement = AccountData.Movement()
            
            let dateFormatterDate : DateFormatter = DateFormatter()
            dateFormatterDate.dateFormat = "dd.MM"
            let date = Date()
            let dateString = dateFormatterDate.string(from: date)
            
            let dateFormatterTime : DateFormatter = DateFormatter()
            dateFormatterTime.dateFormat = "HH:mm"
            let leaveTimeString = dateFormatterTime.string(from: oraPlecariiDatePicker.date)
            let arrivalTimeString = dateFormatterTime.string(from: oraIntoarceriiDatePicker.date)
            
            storeMovement.date = dateString
            storeMovement.leaveTime = leaveTimeString
            storeMovement.arriveTime = arrivalTimeString
            storeMovement.reason = motivulDeplasariInputField.text
            
            if daView.backgroundColor == UIColor(red: 189.0/255.0, green: 146.0/255.0, blue: 190.0/255.0, alpha: 1.0){
                storeMovement.directContact = "DA"
            } else{
                storeMovement.directContact = "NU"
            }
            
            var accounts: [AccountData] = []
            if let encodedData = UserDefaults.standard.object(forKey: "accounts") as? Data {
                let decoder = JSONDecoder()
                if let accs = try? decoder.decode([AccountData].self, from: encodedData) {
                    accounts = accs
                }
            }
            
            for i in 0..<(accounts.count ?? 0){
                if accounts[i].accountId == StamAcasaSingleton.sharedInstance.actualAccountId{
                    accounts[i].movements?.insert(storeMovement, at: 0)
                    break
                }
                
            }
            
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(accounts) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "accounts")
            }
            UserDefaults.standard.synchronize()
            
            let vc = UIStoryboard.Main.instantiateHomeVc()
            vc.message = "Formularul dumneavoastra a fost inregistrat cu succes!"
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else{
            validationFormAlert(title: "EROARE", message: "Formularul nu este valid")
        }
    }
}

extension FormularDeplasariViewController: SideMenu{
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
        let vc = UIStoryboard.Main.instantiateIstoricCompletVc()
        self.navigationController?.pushViewController(vc, animated: true)
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
