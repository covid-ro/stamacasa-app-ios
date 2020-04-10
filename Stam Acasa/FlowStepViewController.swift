//
//  FlowStepViewController.swift
//  Stam Acasa
//
//  Created by Sebi on 08/04/2020.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import UIKit

class FlowStepViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    
    var decodedData: MyData?
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    //var yPositionOfAddingInContentView: CGFloat = 20.0
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*
        let flowContentView = Bundle.main.loadNibNamed("FlowContentView", owner: self, options: nil)?.first as! FlowContentView
        
        flowContentView.frame = CGRect(x: 20.0, y: 20.0, width: 50.0, height: 50.0)
        contentView.addSubview(flowContentView)
        */
        
        
//        let datePersonale = Bundle.main.loadNibNamed("DatePersonale", owner: self, options: nil)?.first as! DatePersonale
//        
//        datePersonale.frame = CGRect(x: 0, y: 0.0, width: self.contentView.frame.size.width, height: 550)
//        contentView.addSubview(datePersonale)
        
        //populateScrollView(index: 1)
        
        
        populateScrollViewWithFlowSection(flowId: "registration", sectionId: "stare_sanatate")
        //populateScrollViewWithFlowSection1(flowId: "registration", sectionId: "stare_sanatate")

    }
    
    func populateScrollView(index: Int){
        let pageControlView = Bundle.main.loadNibNamed("PageControlView", owner: self, options: nil)?.first as! PageControlView

        var yPositionOfAddingInContentView: CGFloat = 20.0
        
        pageControlView.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.contentView.frame.size.width - 40.0, height: 50.0)
        contentView.addSubview(pageControlView)
        yPositionOfAddingInContentView += pageControlView.frame.size.height + 20.0
        for step in pageControlView.controlSteps{
            step.backgroundColor = UIColor.gray
        }
        
        pageControlView.controlSteps[index].backgroundColor = UIColor(red: 79.0/255.0, green: 59.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        
        guard let flows = decodedData?.data?.flows else {
            return
        }
        if flows.count > index {
            for section in flows[index].flow_sections ?? []{
               
                
                
                for question in section.questions ?? []{
                    let questionView = Bundle.main.loadNibNamed("SectionView", owner: self, options: nil)?.first as! SectionView

                    questionView.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.contentView.frame.size.width - 40.0, height: 50.0)
                    questionView.textLabel.text = question.question_text
                    
                    
                    questionView.textLabel.numberOfLines = 0
                    let hlbl = questionView.textLabel.frame.size.height
                    
                    questionView.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.contentView.frame.size.width - 40.0, height: hlbl+20)
                    
                    contentView.addSubview(questionView)
                    yPositionOfAddingInContentView += questionView.frame.size.height + 20.0

                    
                    
                    

                    for answer in question.question_answers ?? [] {
                        let answerView = Bundle.main.loadNibNamed("AnswerView", owner: self, options: nil)?.first as! AnswerView

                        answerView.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.contentView.frame.size.width - 40.0, height: 50.0)
                        answerView.textLabel.text = answer.answer_text
                        contentView.addSubview(answerView)
                        yPositionOfAddingInContentView += answerView.frame.size.height + 20.0
                    }
                }
            }
            if yPositionOfAddingInContentView > contentView.frame.size.height{

                contentViewHeight.constant = yPositionOfAddingInContentView
                contentView.frame.size.height = yPositionOfAddingInContentView
                scrollView.contentSize.height = yPositionOfAddingInContentView
            }
        }
    }
    
    func populateScrollViewWithFlowSection(flowId: String,sectionId: String){
        var yPositionOfAddingInContentView: CGFloat = 20.0
        var index: Int
        index=1
        
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
                            let questionView = Bundle.main.loadNibNamed("SectionView", owner: self, options: nil)?.first as! SectionView

                            questionView.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.view.frame.size.width - 40.0, height: 50.0)
                            questionView.textLabel.text = question.question_text
                            
                            questionView.textLabel.numberOfLines = 0
                            let hlbl = questionView.textLabel.frame.size.height
                            
                            questionView.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.view.frame.size.width - 40.0, height: hlbl+30)
                            
                            contentView.addSubview(questionView)
                            yPositionOfAddingInContentView += questionView.frame.size.height + 20.0
                            questionView.translatesAutoresizingMaskIntoConstraints = true
                            
                            
                            

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
                            }
                        }
                    }
                }
            }
        }
        
        if yPositionOfAddingInContentView > contentView.frame.size.height{

           contentViewHeight.constant = yPositionOfAddingInContentView
           contentView.frame.size.height = yPositionOfAddingInContentView
        }
        
    }
    
    func populateScrollViewWithFlowSection1(flowId: String,sectionId: String){
        contentView.translatesAutoresizingMaskIntoConstraints = true
        var yPositionOfAddingInContentView: CGFloat = 20.0
        var index: Int
        index=1
        
        guard let flows = decodedData?.data?.flows else {
            return
        }
        
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
//                        let pageControlView = Bundle.main.loadNibNamed("PageControlView", owner: self, options: nil)?.first as! PageControlView
//                        pageControlView.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.contentView.frame.size.width - 40.0, height: 50.0)
//                        contentView.addSubview(pageControlView)
//                        yPositionOfAddingInContentView += pageControlView.frame.size.height + 20.0
//                        for step in pageControlView.controlSteps{
//                           step.backgroundColor = UIColor.gray
//                        }
//                        pageControlView.controlSteps?[index].backgroundColor = UIColor(red: 79.0/255.0, green: 59.0/255.0, blue: 100.0/255.0, alpha: 1.0)
//                        pageControlView.translatesAutoresizingMaskIntoConstraints = false
                        
                        //section name
//                        let sectionNameView = Bundle.main.loadNibNamed("SectionView", owner: self, options: nil)?.first as! SectionView
                        let sectionNameLabel = UILabel()
                        sectionNameLabel.backgroundColor = UIColor(red: 79.0/255.0, green: 59.0/255.0, blue: 100.0/255.0, alpha: 1.0)
                        sectionNameLabel.textColor = UIColor.white
                        sectionNameLabel.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.view.frame.size.width - 40.0, height: 30.0)
                        sectionNameLabel.text = section.section_name
                        sectionNameLabel.numberOfLines = 0
                        sectionNameLabel.translatesAutoresizingMaskIntoConstraints = true
//                        let hlblS = sectionNameView.textLabel.frame.size.height
//                        sectionNameView.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.view.frame.size.width - 40.0, height: hlblS)
                        contentView.addSubview(sectionNameLabel)
                        yPositionOfAddingInContentView += sectionNameLabel.frame.size.height + 20.0

                        
                        //questions
                        for question in section.questions ?? []{
//                            let questionView = Bundle.main.loadNibNamed("SectionView", owner: self, options: nil)?.first as! SectionView
                            
                            let questionNameLabel = UILabel()
                            questionNameLabel.backgroundColor = UIColor(red: 79.0/255.0, green: 59.0/255.0, blue: 100.0/255.0, alpha: 1.0)
                            questionNameLabel.textColor = UIColor.white
                            questionNameLabel.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.contentView.frame.size.width - 40.0, height: 50.0)
                            questionNameLabel.text = question.question_text
                            
                            
                            questionNameLabel.numberOfLines = 0
//                            let hlbl = questionView.textLabel.frame.size.height
//
//                            questionView.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.view.frame.size.width - 40.0, height: hlbl+20)
//
                            contentView.addSubview(questionNameLabel)
                            yPositionOfAddingInContentView += questionNameLabel.frame.size.height + 20.0

                            
                            
                            

                            for answer in question.question_answers ?? [] {
//                                let answerView = Bundle.main.loadNibNamed("AnswerView", owner: self, options: nil)?.first as! AnswerView
                                let answerLabel = UILabel()
                                answerLabel.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.contentView.frame.size.width - 40.0, height: 50.0)
                                answerLabel.textColor = UIColor.black
                                answerLabel.text = answer.answer_text
                                answerLabel.numberOfLines = 0
                                contentView.addSubview(answerLabel)
                                yPositionOfAddingInContentView += answerLabel.frame.size.height + 20.0
                            }
                        }
                    }
                }
            }
        }
        
        if yPositionOfAddingInContentView > contentView.frame.size.height{

            contentViewHeight.constant = yPositionOfAddingInContentView
            contentView.frame.size.height = yPositionOfAddingInContentView
            scrollView.contentSize.height = yPositionOfAddingInContentView
            contentView.layoutSubviews()
        }
        
    }


}
