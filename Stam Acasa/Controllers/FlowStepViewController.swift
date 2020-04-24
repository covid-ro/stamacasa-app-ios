//
//  FlowStepViewController.swift
//  Stam Acasa
//
//  Created by Sebi on 08/04/2020.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import UIKit

class FlowStepViewController: UIViewController , DateNecesareContinue{
    @IBOutlet weak var contentView: UIView!
    
    var decodedData: MyData?
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    //var yPositionOfAddingInContentView: CGFloat = 20.0
    @IBOutlet weak var scrollView: UIScrollView!
    var answersToStore: [ResponseData.Answer] = []
    var questionDataAnswersViewsDictionary: [MyData.Data.Flow.FlowSection.Question : [AnswerView]] = [:]
    
    var questionsPanelViews: [QuestionPanelView] = []
    
    var account : AccountData?
    
    var passedFlowId: String?
    var passedSectionId: String?
    var selectedColor: UIColor?
    @IBOutlet weak var stamAcasaLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedColor = UIColor(red: 189.0/255.0, green: 146.0/255.0, blue: 190.0/255.0, alpha: 1.0)
        
        stamAcasaLogo.isUserInteractionEnabled = true
        let menuTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.menuTapped(_:)))
        stamAcasaLogo.addGestureRecognizer(menuTapGesture)
        
        decodedData = StamAcasaSingleton.sharedInstance.decodedData
        
        if passedFlowId == "registration" && passedSectionId == "date_personale"{
            let datePersonale = Bundle.main.loadNibNamed("DatePersonale", owner: self, options: nil)?.first as! DatePersonale
            datePersonale.translatesAutoresizingMaskIntoConstraints = true
            
            datePersonale.frame = CGRect(x: 0, y: 0.0, width: self.view.frame.size.width, height: 550)
            datePersonale.delegate = self
            contentView.addSubview(datePersonale)
        
        } else {
            
            populateScrollViewWithFlowSection(flowId: passedFlowId!, sectionId: passedSectionId!)
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
    
    var index: Int = 0
    func populateScrollViewWithFlowSection(flowId: String,sectionId: String){
        var yPositionOfAddingInContentView: CGFloat = 20.0

        guard let flows = decodedData?.data?.flows else {
            return
        }
        
        contentView.translatesAutoresizingMaskIntoConstraints = true
        for flow in flows ?? []{
            if(flow.flow_id == flowId){
                for section in flow.flow_sections ?? []{
                    if(section.section_id == sectionId){
                        
                        //flow title
                        let labelFlow = UILabel(frame: CGRect(x: 30, y: yPositionOfAddingInContentView, width: self.view.frame.size.width - 60.0, height: 60))
                        labelFlow.textAlignment = .left
                        labelFlow.font = labelFlow.font.withSize(24)
                        labelFlow.numberOfLines = 0
                        labelFlow.text = flow.flow_name
                        let hlblF = labelFlow.frame.size.height

                        yPositionOfAddingInContentView += hlblF + 20.0
                        contentView.addSubview(labelFlow)

                        //section info text
                        let labelInfo = UILabel(frame: CGRect(x: 30, y: yPositionOfAddingInContentView, width: self.view.frame.size.width - 60.0, height: 80))
                        labelInfo.textAlignment = .center
                        labelInfo.numberOfLines = 0
                        labelInfo.text = section.section_text
                        let hlblN = labelInfo.frame.size.height

                        yPositionOfAddingInContentView += hlblN + 20.0
                        contentView.addSubview(labelInfo)

                        //position indicator
                        let pageControlView = Bundle.main.loadNibNamed("PageControlView", owner: self, options: nil)?.first as! PageControlView
                        pageControlView.translatesAutoresizingMaskIntoConstraints = true
                        pageControlView.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.view.frame.size.width - 40.0, height: 50.0)
                        contentView.addSubview(pageControlView)
                        yPositionOfAddingInContentView += pageControlView.frame.size.height + 20.0
                        
                        var nrs = 0 as Int
                        for step in pageControlView.controlSteps{
                            step.backgroundColor = selectedColor
                            nrs+=1
                            if nrs > flow.flow_sections!.count {
                                step.removeFromSuperview()
                            }
                        }
                        
                        for step in pageControlView.controlSteps{
                            step.backgroundColor = selectedColor
                        }
                        pageControlView.controlSteps?[index].backgroundColor = UIColor(red: 79.0/255.0, green: 59.0/255.0, blue: 100.0/255.0, alpha: 1.0)
                        pageControlView.translatesAutoresizingMaskIntoConstraints = true

                        //section name
                        let sectionNameView = Bundle.main.loadNibNamed("SectionView", owner: self, options: nil)?.first as! SectionView
                        
                        sectionNameView.translatesAutoresizingMaskIntoConstraints = true
                        sectionNameView.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.view.frame.size.width - 40.0, height: 30.0)
                        sectionNameView.textLabel.text = section.section_name
                        sectionNameView.textLabel.numberOfLines = 0
                        let hlblS = sectionNameView.textLabel.labelHeight()
                        sectionNameView.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.view.frame.size.width - 40.0, height: hlblS + 30.0)
                        contentView.addSubview(sectionNameView)
                        yPositionOfAddingInContentView += sectionNameView.frame.size.height + 30.0

                        //questions
                        for question in section.questions ?? []{
                        //    if !(question.question_hidden ?? true) {
                            
                            let qView = QuestionPanelView.init(frame: CGRect.init(x: 0, y: yPositionOfAddingInContentView, width: self.view.frame.size.width, height: 500))
                            qView.translatesAutoresizingMaskIntoConstraints = true
                            qView.question_id = question.question_id!
                            qView.ascuns = question.question_hidden
                            
                            var qYPosition : CGFloat
                            
                            let questionView = Bundle.main.loadNibNamed("SectionView", owner: self, options: nil)?.first as! SectionView

                            questionView.frame = CGRect(x: 20.0, y: 0, width: self.view.frame.size.width - 40.0, height: 50.0)
                            questionView.textLabel.text = question.question_text
                            
                            qView.addSubview(questionView)
                            
                            questionView.textLabel.numberOfLines = 0
                            let hlbl = questionView.textLabel.labelHeight()

                            questionView.frame = CGRect(x: 20.0, y: 0, width: self.view.frame.size.width - 40.0, height: hlbl+30)

                            
                            questionView.translatesAutoresizingMaskIntoConstraints = true
                            //contentView.addSubview(questionView)
                            //yPositionOfAddingInContentView += questionView.frame.size.height + 30.0
                            
                            qYPosition = questionView.frame.size.height + 20.0
                            qView.intrebareView = questionView
                            
                            var totalAnswersPerQuestion: [AnswerView] = []
                            for answer in question.question_answers ?? [] {
                                let answerView = Bundle.main.loadNibNamed("AnswerView", owner: self, options: nil)?.first as! AnswerView
                                
                                answerView.section_id = section.section_id
                                answerView.section_name = section.section_name
                                answerView.question_id = question.question_id
                                answerView.question_text = question.question_text
                                answerView.answer_id = answer.answer_id
                                answerView.answer_text = answer.answer_text
                                
                                answerView.decision = answer.answer_decision
                                answerView.frame = CGRect(x: 20.0, y: qYPosition, width: self.view.frame.size.width - 40.0, height: 30.0)
                                answerView.textLabel.numberOfLines = 0
                                answerView.textLabel.text = answer.answer_text
                                answerView.backgroundColor = .white
                                let hlba = answerView.textLabel.labelHeight()

                                answerView.frame = CGRect(x: 20.0, y: qYPosition, width: self.view.frame.size.width - 40.0, height: hlba+20)
                                
                                answerView.translatesAutoresizingMaskIntoConstraints = true
                                qView.addSubview(answerView)
                                
                                //yPositionOfAddingInContentView += answerView.frame.size.height + 10.0
                                qYPosition += answerView.frame.size.height + 10.0
                                
                                var ids = (flow.flow_id ?? "flow_id_null") + " " + (section.section_id ?? "section_id_null") + " "
                                ids += "\((question.question_id ?? 0))" + " "
                                ids += "\(answer.answer_id ?? 0)"
                                answerView.accessibilityIdentifier = ids
                                totalAnswersPerQuestion.append(answerView)
                                
                                let tapTouchUpInside = UITapGestureRecognizer(target: self, action: #selector(answerViewTapped(_:)))
                                answerView.addGestureRecognizer(tapTouchUpInside)
                            }
                            
                            questionDataAnswersViewsDictionary[question] = totalAnswersPerQuestion
                            questionView.accessibilityIdentifier = "\((question.question_id ?? 0))"
                            
                            questionsPanelViews.append(qView)
                            
                            
                            qYPosition += 20
                            
                            
                            qView.totalHeight = qYPosition
                            //qView.frame.size.height = 300
                            //qView.layoutSubviews()
                            
                            contentView.addSubview(qView)
                            
                            if !(question.question_hidden ?? true) {
                                yPositionOfAddingInContentView += qYPosition
                            } else {
                                yPositionOfAddingInContentView += 1
                                qView.isHidden = true
                            }
                        }
                        
                        let continueButton = UIButton()
                        continueButton.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.view.frame.size.width - 40.0, height: 40.0)
                        continueButton.backgroundColor = UIColor(red: 255.0/255.0, green: 189.0/255.0, blue: 89.0/255.0, alpha: 1.0)
                        continueButton.setTitleColor(.black, for: .normal)
                        continueButton.setTitle("Continua", for: .normal)
                        continueButton.addTarget(self, action: #selector(continueButtonTapped(_:)), for: .touchUpInside)
                        yPositionOfAddingInContentView += continueButton.frame.size.height + 20.0
                        continueButton.accessibilityIdentifier = section.section_next_id
                        contentView.addSubview(continueButton)
                    }
                }
            }
        }

        
        //if yPositionOfAddingInContentView > contentView.frame.size.height{

            contentViewHeight.constant = yPositionOfAddingInContentView
            contentView.frame.size.height = yPositionOfAddingInContentView
        //}
        index += 1
    }
    
    
    
    @objc func answerViewTapped(_ sender: Any){
        let view = (sender as? UITapGestureRecognizer)?.view as? AnswerView
        
        var answeredForThisQuestion = MyData.Data.Flow.FlowSection.Question()
        for (question,answers) in questionDataAnswersViewsDictionary{
            for answer in answers{
                if answer.accessibilityIdentifier == view?.accessibilityIdentifier{
                    answeredForThisQuestion = question
                    
                    break
                }
            }
        }
        
        
        if answeredForThisQuestion.question_type == "single-choice"{
            for answer in questionDataAnswersViewsDictionary[answeredForThisQuestion] ?? []{
                answer.backgroundColor = UIColor.white
                if answer.decision?.answer_input == "question-activate" {
                    removeQuestion(idQuestion: (answer.decision?.answer_question_id)!)
                }
            }
        }
        
        
        if view?.backgroundColor == .white{
            view?.backgroundColor = selectedColor
        } else{
            view?.backgroundColor = .white
        }
        
        
        var responseDecisionObj = view?.decision
        if view?.backgroundColor == selectedColor && responseDecisionObj?.answer_input == "question-activate" {
            insertQuestion(idQuestion: (responseDecisionObj?.answer_question_id)!)
        }
        
        if view?.backgroundColor == selectedColor && responseDecisionObj?.answer_input == "text-area" {
            
            let alertController = UIAlertController(title: responseDecisionObj?.answer_hint, message: "", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { alert -> Void in
                let textField = alertController.textFields![0] as UITextField
                view?.answer_extra = textField.text
                //print(textField.text)
            }))
            alertController.addAction(UIAlertAction(title: "Anuleaza", style: .cancel, handler: { alert -> Void in
                view?.backgroundColor = .white
            }))
            alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
                //textField.placeholder = "hint"
            })
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        if view?.backgroundColor == selectedColor && responseDecisionObj?.answer_input == "text-input-numeric" {
            
            let alertController = UIAlertController(title: responseDecisionObj?.answer_hint, message: "", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { alert -> Void in
                let textField = alertController.textFields![0] as UITextField
                view?.answer_extra = textField.text
                //print(textField.text)
            }))
            alertController.addAction(UIAlertAction(title: "Anuleaza", style: .cancel, handler: { alert -> Void in
                view?.backgroundColor = .white
            }))
            alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
                //textField.placeholder = "hint"
                textField.keyboardType = UIKeyboardType.decimalPad
            })
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        if view?.backgroundColor == .white && responseDecisionObj?.answer_input == "question-activate" {
            removeQuestion(idQuestion: (responseDecisionObj?.answer_question_id)!)
        }
        
    }
    
    
    func removeQuestion(idQuestion: Int){
        
        var moveLayoutFrom = 5000 as CGFloat
        var increment = 0 as CGFloat
        
        for view in contentView.subviews{
            
            if view.frame.origin.y > moveLayoutFrom {
                view.frame.origin.y -= increment
            }
            
            if view is QuestionPanelView{
                
                let thisView = view as! QuestionPanelView
                
                if thisView.question_id == idQuestion && thisView.isHidden == false{
                    
                    thisView.isHidden = true
                    
                    moveLayoutFrom = thisView.frame.origin.y
                    increment = thisView.totalHeight!
                    
                    contentView.frame.size.height -= thisView.totalHeight!
                }
                
            }
        }
    }
    
    func insertQuestion(idQuestion: Int){
        
        var moveLayoutFrom = 5000 as CGFloat
        var increment = 0 as CGFloat
        
        for view in contentView.subviews{
            
            if view.frame.origin.y > moveLayoutFrom {
                view.frame.origin.y += increment
            }
            
            if view is QuestionPanelView{
                
                let thisView = view as! QuestionPanelView
                
                if thisView.question_id == idQuestion && thisView.isHidden == true{
                    
                    thisView.isHidden = false
                    
                    moveLayoutFrom = thisView.frame.origin.y
                    increment = thisView.totalHeight!
                    
                    contentView.frame.size.height += thisView.totalHeight!
                }
            }
        }
    }
    
    
    
    func dateNecesareContinueTapped(){
        
        /*
         public struct AccountData: Codable,Hashable {
             var primary:Bool?
             var accountId:Int?
             var numePrenume: String?
             var numarTelefon: String?
             var judet: String?
             var localitate: String?
             var varsta: String?
             var gen: String?
             var accountCreationResponses: [ResponseData]?
         }

         @IBOutlet weak var textNumePrenume: UITextField!
            @IBOutlet weak var textNumarTelefon: UITextField!
            @IBOutlet weak var dropDownJudet: DropDown!
            @IBOutlet weak var dropDownLocalitate: DropDown!
            @IBOutlet weak var dropDownVarsta: DropDown!
            @IBOutlet weak var dropDownGen: DropDown!
         */
        
        
        for view in contentView.subviews.filter({$0 is DatePersonale}){
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
                                               
            let dpv = view as! DatePersonale
            
            account = AccountData(accountId: getMaxId(), numePrenume: dpv.textNumePrenume.text, numarTelefon: dpv.textNumarTelefon.text, judet: dpv.dropDownJudet.text, localitate: dpv.dropDownLocalitate.text, varsta: dpv.dropDownVarsta.text, gen: dpv.dropDownGen.text, responses:[], registrationDate: formatter.string(from: date),movements: [])
            
            view.removeFromSuperview()
        }
        populateScrollViewWithFlowSection(flowId: "registration", sectionId: "stare_sanatate")
    }
    
    func getMaxId() -> Int{
        var accounts: [AccountData]?
        if let encodedData = UserDefaults.standard.object(forKey: "accounts") as? Data {
            let decoder = JSONDecoder()
            if let acx = try? decoder.decode([AccountData].self, from: encodedData) {
                accounts = acx
            }
        }
        if (accounts?.count ?? 0) > 0{
            return accounts!.count
        } else{
            return 0
        }
    }
    
    func validationFormAlert(){
        let alert = UIAlertController(title: "EROARE", message: "Formularul nu este valid", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_: UIAlertAction) in
            self.navigationController?.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func continueButtonTapped(_ sender: Any){
        var formValidated = true
        
        for (question,answers) in questionDataAnswersViewsDictionary{
            var isQuestionAnswered = false
            for answer in answers{
                if answer.backgroundColor == selectedColor{
                    isQuestionAnswered = true
                    break
                }
            }
            
            for qView in questionsPanelViews{
                if question.question_id == Int(qView.intrebareView!.accessibilityIdentifier ?? "0"){
                    if !isQuestionAnswered && question.question_type == "single-choice"  && !qView.isHidden {
                        qView.intrebareView!.backgroundColor = UIColor.red
                        formValidated = false
                        validationFormAlert()
                    } else {
                        qView.intrebareView!.backgroundColor = UIColor(red: 79.0/255.0, green: 59.0/255.0, blue: 100.0/255.0, alpha: 1.0)
                    }
                }
                
            }
            
            
            
        }     // validate that questions have been answered
        
        if formValidated{
            
            let sectionId = (sender as! UIButton).accessibilityIdentifier ?? ""
            for viewLevel1 in contentView.subviews{
                for viewLevel2 in viewLevel1.subviews.filter({$0 is AnswerView}){
                    if viewLevel2.backgroundColor == selectedColor{
                        let ansv = viewLevel2 as? AnswerView
                        
                        var answer = ResponseData.Answer()
                        let ids = viewLevel2.accessibilityIdentifier?.components(separatedBy: " ")
                        
                        answer.section_id = ansv?.section_id
                        answer.section_name = ansv?.section_name
                        answer.question_id = ansv?.question_id
                        answer.question_text = ansv?.question_text
                        answer.answer_id = ansv?.answer_id
                        answer.answer_text = ansv?.answer_text
                        answer.answer_extra = ansv?.answer_extra
                        
                        answersToStore.append(answer)
                        
                    }
                    
                }
                viewLevel1.removeFromSuperview()
            }
            
            scrollView.setContentOffset(CGPoint.zero, animated: false)
            if sectionId != "stop"{
                populateScrollViewWithFlowSection(flowId: passedFlowId!, sectionId: sectionId)
            } else {
                
                if passedFlowId == "registration" {
                    
                    saveAccount(answersToStore: answersToStore)
                    
                    let vc = UIStoryboard.Main.instantiateProfilCompletVc()
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    saveResponseData(answersToStore: answersToStore)
                    let vc = UIStoryboard.Main.instantiateHomeVc()
                    vc.message = "Raport evaluare complet"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        vc.pageMenu!.moveToPage(1)
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
     func saveAccount(answersToStore:[ResponseData.Answer]) {
        var accounts = [] as [AccountData]?
        
        if let encodedData = UserDefaults.standard.object(forKey: "accounts") as? Data {
            let decoder = JSONDecoder()
            if let acx = try? decoder.decode([AccountData].self, from: encodedData) {
                accounts = acx
            }
        }
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        
        let formatterHour = DateFormatter()
        formatterHour.dateFormat = "dd.MM HH:mm"
        
        let newResponseData = ResponseData(date:  formatter.string(from: date),dateWithHour: formatterHour.string(from: date), flow_id: passedFlowId, responses: answersToStore)
        
        account?.responses?.append(newResponseData)
        
        accounts?.append(account!)
        //print(accounts)
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(accounts) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "accounts")
        }
        UserDefaults.standard.synchronize()
    
    }
    
    func saveResponseData(answersToStore:[ResponseData.Answer]) {
        var accounts = [] as [AccountData]?
        var responses : [ResponseData]?
        responses = []
        
        if let encodedData = UserDefaults.standard.object(forKey: "accounts") as? Data {
            let decoder = JSONDecoder()
            if let acx = try? decoder.decode([AccountData].self, from: encodedData) {
                accounts = acx
            }
        }
        
        for i in 0..<(accounts?.count ?? 0){
            if accounts![i].accountId == StamAcasaSingleton.sharedInstance.actualAccountId{
                
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM"
                
                let formatterHour = DateFormatter()
                formatterHour.dateFormat = "dd.MM HH:mm"
                
                let newResponseData = ResponseData(date:  formatter.string(from: date),dateWithHour: formatterHour.string(from: date), flow_id: passedFlowId, responses: answersToStore)
                //responses?.append(newResponseData)
                accounts![i].responses?.insert(newResponseData, at: 0)
                
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(accounts) {
                        let defaults = UserDefaults.standard
                        defaults.set(encoded, forKey: "accounts")
                    }
                    UserDefaults.standard.synchronize()
                    
                    break
                }
            }
    }
}

extension FlowStepViewController: SideMenu{
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


protocol DateNecesareContinue{
    func dateNecesareContinueTapped()
    func validationFormAlert()
}
