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
    
    var passedFlowId: String?
    var passedSectionId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                        for step in pageControlView.controlSteps{
                            step.backgroundColor = UIColor.gray
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

                            //print(questionView.frame)
                            
                            questionView.translatesAutoresizingMaskIntoConstraints = true
                            //contentView.addSubview(questionView)
                            //yPositionOfAddingInContentView += questionView.frame.size.height + 30.0
                            
                            qYPosition = questionView.frame.size.height + 20.0
                            qView.intrebareView = questionView
                            
                            var totalAnswersPerQuestion: [AnswerView] = []
                            for answer in question.question_answers ?? [] {
                                let answerView = Bundle.main.loadNibNamed("AnswerView", owner: self, options: nil)?.first as! AnswerView
                                
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

        
        if yPositionOfAddingInContentView > contentView.frame.size.height{

            contentViewHeight.constant = yPositionOfAddingInContentView
            contentView.frame.size.height = yPositionOfAddingInContentView
        }
        index += 1
    }
    
    
    
    @objc func answerViewTapped(_ sender: Any){
        let view = (sender as? UITapGestureRecognizer)?.view as? AnswerView
        
        print("tap pe accessibilityIdentifier:\(view?.accessibilityIdentifier)")
        
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
                    print(answer.decision)
                    removeQuestion(idQuestion: (answer.decision?.answer_question_id)!)
                }
            }
        }
        
        
        if view?.backgroundColor == .white{
            view?.backgroundColor = .gray
        } else{
            view?.backgroundColor = .white
        }
        
        
        var responseDecisionObj = view?.decision
        if view?.backgroundColor == .gray && responseDecisionObj?.answer_input == "question-activate" {
            insertQuestion(idQuestion: (responseDecisionObj?.answer_question_id)!)
        }
        
    }
    
    func removeQuestion(idQuestion: Int){
        print("removing \(idQuestion)")
        
        var moveLayoutFrom = 5000 as CGFloat
        var increment = 0 as CGFloat
        
        for view in contentView.subviews{
            
            if view.frame.origin.y > moveLayoutFrom {
                print(view.frame)
                view.frame.origin.y -= increment
                print(view.frame)
            }
            
            if view is QuestionPanelView{
                
                print("QuestionPanelView frame:\(view.frame)")
                let thisView = view as! QuestionPanelView
                
                if thisView.question_id == idQuestion && thisView.isHidden == false{
                    
                    //print("bingo frame:\(thisView.frame)")
                    
                    thisView.isHidden = true
                    
                    moveLayoutFrom = thisView.frame.origin.y
                    increment = thisView.totalHeight!
                    
                    contentView.frame.size.height -= thisView.totalHeight!
                }
                
            }
        }
    }
    
    func insertQuestion(idQuestion: Int){
        print("inserting \(idQuestion)")
        
        var moveLayoutFrom = 5000 as CGFloat
        var increment = 0 as CGFloat
        
        for view in contentView.subviews{
            
            if view.frame.origin.y > moveLayoutFrom {
                print(view.frame)
                view.frame.origin.y += increment
                print(view.frame)
            }
            
            if view is QuestionPanelView{
                
                print("QuestionPanelView frame:\(view.frame)")
                let thisView = view as! QuestionPanelView
                
                if thisView.question_id == idQuestion && thisView.isHidden == true{
                    
                    //print("bingo frame:\(thisView.frame)")
                    
                    thisView.isHidden = false
                    
                    moveLayoutFrom = thisView.frame.origin.y
                    increment = thisView.totalHeight!
                    
                    contentView.frame.size.height += thisView.totalHeight!
                }
            }
        }
    }
    
    
    
    func dateNecesareContinueTapped(){
        for view in contentView.subviews{
            view.removeFromSuperview()
        }
        populateScrollViewWithFlowSection(flowId: "registration", sectionId: "stare_sanatate")
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
                if answer.backgroundColor == UIColor.gray{
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
                for viewLevel2 in viewLevel1.subviews.filter{$0 is AnswerView}{
                    //print("gasit AnswerView")
                    
                    if viewLevel2.backgroundColor == UIColor.gray{
                        var answer = ResponseData.Answer()
                        let ids = viewLevel2.accessibilityIdentifier?.components(separatedBy: " ")
                        //answer.flow_id = ids![0]
                        answer.section_id = ids![1]
                        answer.question_id = Int(ids![2])
                        answer.answer_id = Int(ids![3])
                        answersToStore.append(answer)
                        
                        print("storing")
                    }
                    
                }
                viewLevel1.removeFromSuperview()
            }
            
            scrollView.setContentOffset(CGPoint.zero, animated: false)
            if sectionId != "stop"{
                populateScrollViewWithFlowSection(flowId: passedFlowId!, sectionId: sectionId)
            } else {
                
                print("answersToStore:\(answersToStore)")
                
                if passedFlowId == "registration" {
                    StamAcasaSingleton.sharedInstance.questionAnswers = answersToStore
                    let vc = UIStoryboard.Main.instantiateProfilCompletVc()
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    saveData(answersToStore: answersToStore)
                    let vc = UIStoryboard.Main.instantiateHomeVc()
                    vc.message = "Raport evaluare complet"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    func saveData(answersToStore:[ResponseData.Answer]) {
        
        var responses : [ResponseData]?
        responses = []
        
        if let encodedData = UserDefaults.standard.object(forKey: "resps") as? Data {
            let decoder = JSONDecoder()
            if let rsx = try? decoder.decode([ResponseData].self, from: encodedData) {
                responses = rsx
            }
        }
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM\nHH:mm"

        let newResponseData = ResponseData(date:  formatter.string(from: date), flow_id: passedFlowId, responses: answersToStore)
        //responses?.append(newResponseData)
        responses?.insert(newResponseData, at: 0)
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(responses) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "resps")
        }
        UserDefaults.standard.synchronize()
    }
}

protocol DateNecesareContinue{
    func dateNecesareContinueTapped()
    func validationFormAlert()
}
