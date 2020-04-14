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
    var questionsViews: [SectionView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let datePersonale = Bundle.main.loadNibNamed("DatePersonale", owner: self, options: nil)?.first as! DatePersonale
        
        datePersonale.frame = CGRect(x: 0, y: 0.0, width: self.contentView.frame.size.width, height: 550)
        datePersonale.delegate = self
        contentView.addSubview(datePersonale)
        
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
                        labelFlow.text = flow.flow_name
                        labelFlow.numberOfLines = 0
                        let hlblF = labelFlow.frame.size.height

                        yPositionOfAddingInContentView += hlblF + 20.0
                        contentView.addSubview(labelFlow)

                        //section info text
                        let labelInfo = UILabel(frame: CGRect(x: 30, y: yPositionOfAddingInContentView, width: self.view.frame.size.width - 60.0, height: 80))
                        labelInfo.textAlignment = .center
                        labelInfo.text = section.section_text
                        labelInfo.numberOfLines = 0
                        let hlblN = labelInfo.frame.size.height

                        yPositionOfAddingInContentView += hlblN + 20.0
                        contentView.addSubview(labelInfo)

                        //position indicator
                        let pageControlView = Bundle.main.loadNibNamed("PageControlView", owner: self, options: nil)?.first as! PageControlView
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
                        sectionNameView.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.view.frame.size.width - 40.0, height: 30.0)
                        sectionNameView.textLabel.text = section.section_name
                        sectionNameView.textLabel.numberOfLines = 0
                        let hlblS = sectionNameView.textLabel.frame.size.height
                        sectionNameView.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.view.frame.size.width - 40.0, height: hlblS + 30.0)
                        contentView.addSubview(sectionNameView)
                        yPositionOfAddingInContentView += sectionNameView.frame.size.height + 20.0
                        sectionNameView.translatesAutoresizingMaskIntoConstraints = true

                        //questions
                        for question in section.questions ?? []{
                            if !(question.question_hidden ?? true) {
                            let questionView = Bundle.main.loadNibNamed("SectionView", owner: self, options: nil)?.first as! SectionView

                            questionView.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.view.frame.size.width - 40.0, height: 50.0)
                            questionView.textLabel.text = question.question_text

                            questionView.textLabel.numberOfLines = 0
                            let hlbl = questionView.textLabel.frame.size.height

                            questionView.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.view.frame.size.width - 40.0, height: hlbl+30)

                            contentView.addSubview(questionView)
                            yPositionOfAddingInContentView += questionView.frame.size.height + 20.0
                            questionView.translatesAutoresizingMaskIntoConstraints = true

                            var totalAnswersPerQuestion: [AnswerView] = []
                            for answer in question.question_answers ?? [] {
                                let answerView = Bundle.main.loadNibNamed("AnswerView", owner: self, options: nil)?.first as! AnswerView

                                answerView.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.view.frame.size.width - 40.0, height: 30.0)
                                answerView.textLabel.numberOfLines = 0
                                answerView.textLabel.text = answer.answer_text
                                let hlba = answerView.textLabel.frame.size.height

                                answerView.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.view.frame.size.width - 40.0, height: hlba+20)
                                contentView.addSubview(answerView)
                                yPositionOfAddingInContentView += answerView.frame.size.height + 20.0
                                answerView.translatesAutoresizingMaskIntoConstraints = true
                                
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
                                questionsViews.append(questionView)
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
            }
        }
        
        if view?.backgroundColor == UIColor.white{
            view?.backgroundColor = UIColor.gray
        } else{
            view?.backgroundColor = UIColor.white
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
            
            for questionView in questionsViews{
                if question.question_id == Int(questionView.accessibilityIdentifier ?? "0"){

                    if !isQuestionAnswered {
                        questionView.backgroundColor = UIColor.red
                        formValidated = false
                        validationFormAlert()
                    } else{
                        questionView.backgroundColor = UIColor(red: 79.0/255.0, green: 59.0/255.0, blue: 100.0/255.0, alpha: 1.0)
                    }
                }
            }
        }     // validate that questions have been answered
        
        if formValidated{
            
            let sectionId = (sender as! UIButton).accessibilityIdentifier ?? ""
            for view in contentView.subviews{
                if view is AnswerView{
                    if view.backgroundColor == UIColor.gray{
                        var answer = ResponseData.Answer()
                        let ids = view.accessibilityIdentifier?.components(separatedBy: " ")
                        //answer.flow_id = ids![0]
                        answer.section_id = ids![1]
                        answer.question_id = ids![2]
                        answer.answer_id = ids![3]
                        answersToStore.append(answer)
                    }
                }
                view.removeFromSuperview()
            }
            
            scrollView.setContentOffset(CGPoint.zero, animated: false)
            if sectionId != "stop"{
                populateScrollViewWithFlowSection(flowId: "registration", sectionId: sectionId)
            } else {
                StamAcasaSingleton.sharedInstance.questionAnswers = answersToStore
                let vc = UIStoryboard.Main.instantiateProfilCompletVc()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

protocol DateNecesareContinue{
    func dateNecesareContinueTapped()
    func validationFormAlert()
}
