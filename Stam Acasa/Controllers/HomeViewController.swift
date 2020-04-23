//
//  HomeViewController.swift
//  Stam Acasa
//
//  Created by Sebi on 11/04/2020.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import Foundation
import UIKit


class HomeViewController: UIViewController, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var PageViewOutlet: UIView!
    var pageMenu : CAPSPageMenu?
    var fm : FormulareleMeleViewController?
    var ap : AltePersoaneViewController?
    @IBOutlet weak var stamAcasaLogo: UIImageView!
    @IBOutlet weak var stamAcasaView: UIView!
    var movementFormsFromUserDefaults: [AccountData.Movement]?
    var message: String?
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (message?.count ?? 0 )>0 {
            let alert = UIAlertController(title: message, message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_: UIAlertAction) in
                self.message=""
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        stamAcasaLogo.isUserInteractionEnabled = true
        let menuTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.menuTapped(_:)))
        stamAcasaLogo.addGestureRecognizer(menuTapGesture)
        
        
        // MARK: - UI Setup
        
        self.title = "PAGE MENU"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        //self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orange]
        
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<-", style: UIBarButtonItemStyle.done, target: self, action: #selector(ViewController.didTapGoToLeft))
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "->", style: UIBarButtonItemStyle.done, target: self, action: #selector(ViewController.didTapGoToRight))
        
        // MARK: - Scroll menu setup
        
        // Initialize view controllers to display and place in array
        var controllerArray : [UIViewController] = []
        
        let fm = UIStoryboard.Main.instantiateFormulareleMeleVC()
        fm.title = "Formularele mele"
        controllerArray.append(fm)
        
        let ap = UIStoryboard.Main.instantiateAltePersoaneVc()
        ap.title = "Alte Persoane"
        controllerArray.append(ap)
        
        /*
        let controller3 : UIViewController = UIViewController.init()
        controller3.view.backgroundColor = UIColor(red: 248.0/255.0, green: 247.0/255.0, blue: 248.0/255.0, alpha: 1.0)
               controller3.title = "Formularele mele"
               controllerArray.append(controller3)
        
        let controller4 : UIViewController = UIViewController.init()
        controller4.view.backgroundColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
               controller4.title = "Alte Persoane"
               controllerArray.append(controller4)
        */
        
        
        // Customize menu (Optional)
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor(red: 248.0/255.0, green: 247.0/255.0, blue: 248.0/255.0, alpha: 1.0)),
            .viewBackgroundColor(UIColor(red: 248.0/255.0, green: 247.0/255.0, blue: 248.0/255.0, alpha: 1.0)),
            .selectedMenuItemLabelColor(UIColor(red: 60.0/255.0, green: 38.0/255.0, blue: 83.0/255.0, alpha: 1.0)),
            .selectionIndicatorColor(UIColor(red: 60.0/255.0, green: 38.0/255.0, blue: 83.0/255.0, alpha: 1.0)),
            .bottomMenuHairlineColor(UIColor.clear),
            .menuItemFont(UIFont(name: "HelveticaNeue", size: 17.0)!),
            .menuHeight(50.0),
            .menuItemWidth(150.0),
            .centerMenuItems(true)
        ]
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)

        self.addChild(pageMenu!)
        //self.view.addSubview(pageMenu!.view)
        PageViewOutlet.addSubview(pageMenu!.view)
        
        pageMenu!.didMove(toParent: self)
        
        populateMovementForms()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func didTapGoToLeft() {
        let currentIndex = pageMenu!.currentPageIndex
        
        if currentIndex > 0 {
            pageMenu!.moveToPage(currentIndex - 1)
        }
    }
    
    func didTapGoToRight() {
        let currentIndex = pageMenu!.currentPageIndex
        
        if currentIndex < pageMenu!.controllerArray.count {
            pageMenu!.moveToPage(currentIndex + 1)
        }
    }
    
    func populateMovementForms(){
        if let encodedData = UserDefaults.standard.object(forKey: "movementForms") as? Data {
            let decoder = JSONDecoder()
            if let movementForms = try? decoder.decode([AccountData.Movement].self, from: encodedData) {
                movementFormsFromUserDefaults = movementForms
            }
        }
    }
    // MARK: - Container View Controller

    //COULD NOT RESOLVE
//    override func shouldAutomaticallyForwardAppearanceMethods() -> Bool {
//        return true
//    }
    
    override func shouldAutomaticallyForwardRotationMethods() -> Bool {
        return true
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

extension HomeViewController: SideMenu{
    func profilulMeuTapped() {
         pageMenu!.moveToPage(0)
    }
    
    func profileAltePersoaneTapped() {
         pageMenu!.moveToPage(1)
    }
    
    func istoricPersonalTapped() {
        let vc = UIStoryboard.Main.instantiateIstoricCompletVc()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func despreTapped(){
        let vc = UIStoryboard.Main.instantiateDespreVc()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setariTapped(){
        let vc = UIStoryboard.Main.instantiateSetariVc()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


protocol SideMenu{
    func profilulMeuTapped()
    func profileAltePersoaneTapped()
    func istoricPersonalTapped()
    func despreTapped()
    func setariTapped()
}



/*

UIViewController {
    //var pageMenu : CAPSPageMenu?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var parameters = [CAPSPageMenuOptionScrollMenuBackgroundColor: UIColor.black,          CAPSPageMenuOptionViewBackgroundColor: UIColor.white,
            CAPSPageMenuOptionSelectionIndicatorColor:UIColor.red,
            CAPSPageMenuOptionMenuHeight:40,
            CAPSPageMenuOptionMenuItemWidth:90,
            CAPSPageMenuOptionCenterMenuItems:true] as [String : Any]
        
        let vc1 = UIViewController.init()
        vc1.view.frame = CGRect.init(x: 0, y: 0, width: 300, height: 300)
        vc1.view.backgroundColor = UIColor.red
        vc1.title = "vc1"
        
        let vc2 = UIViewController.init()
        vc2.view.frame = CGRect.init(x: 0, y: 0, width: 300, height: 300)
        vc2.view.backgroundColor = UIColor.yellow
        vc2.title = "vc2"
        
        pageMenu = CAPSPageMenu.init(viewControllers: [vc1,vc2], frame: CGRect.init(x: 0, y: 0, width: 300, height: 300), options: parameters)
        self.view.addSubview((pageMenu?.view)!)
        
    }
}
*/




