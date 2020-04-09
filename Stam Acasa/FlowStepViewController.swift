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
    var yPositionOfAddingInContentView: CGFloat = 20.0
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
        
        populateScrollView(index: 1)
    }
    
    func populateScrollView(index: Int){
        let pageControlView = Bundle.main.loadNibNamed("PageControlView", owner: self, options: nil)?.first as! PageControlView
        
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
                let sectionView = Bundle.main.loadNibNamed("SectionView", owner: self, options: nil)?.first as! SectionView
                
                sectionView.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.contentView.frame.size.width - 40.0, height: 100.0)
                sectionView.textLabel.text = section.section_text
                
                contentView.addSubview(sectionView)
                yPositionOfAddingInContentView += sectionView.frame.size.height + 20.0
                if yPositionOfAddingInContentView > contentView.frame.size.height{
                    scrollView.contentSize.height = yPositionOfAddingInContentView
                    //contentViewHeight.constant = yPositionOfAddingInContentView
                    //contentView.frame.size.height = yPositionOfAddingInContentView
                }

                for question in section.questions ?? []{
                    let sectionView = Bundle.main.loadNibNamed("SectionView", owner: self, options: nil)?.first as! SectionView

                    sectionView.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.contentView.frame.size.width - 40.0, height: 50.0)
                    sectionView.textLabel.text = question.question_text
                    contentView.addSubview(sectionView)
                    yPositionOfAddingInContentView += sectionView.frame.size.height + 20.0
                    if yPositionOfAddingInContentView > contentView.frame.size.height{
                        //contentViewHeight.constant = yPositionOfAddingInContentView
                        //contentView.frame.size.height = yPositionOfAddingInContentView
                        scrollView.contentSize.height = yPositionOfAddingInContentView
                    }

                    for answer in question.question_answers ?? [] {
                        let answerView = Bundle.main.loadNibNamed("AnswerView", owner: self, options: nil)?.first as! AnswerView

                        answerView.frame = CGRect(x: 20.0, y: yPositionOfAddingInContentView, width: self.contentView.frame.size.width - 40.0, height: 50.0)
                        answerView.textLabel.text = answer.answer_text
                        contentView.addSubview(answerView)
                        yPositionOfAddingInContentView += answerView.frame.size.height + 20.0
                        if yPositionOfAddingInContentView > contentView.frame.size.height{

                            //contentViewHeight.constant = yPositionOfAddingInContentView
                            //contentView.frame.size.height = yPositionOfAddingInContentView
                            scrollView.contentSize.height = yPositionOfAddingInContentView
                        }

                    }
                }
            }

        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
