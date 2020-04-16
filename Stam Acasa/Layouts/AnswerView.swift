//
//  AnswerView.swift
//  Stam Acasa
//
//  Created by Macbook on 4/9/20.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import Foundation
import UIKit

class AnswerView: UIView {
    @IBOutlet weak var textLabel: UILabel!
    var decision: MyData.Data.Flow.FlowSection.Question.QuestionAnswer.AnswerDecision?
    
    var section_id: String?
    var question_id: Int?
    var question_text: String?
    var answer_id: Int?
    var answer_text: String?
    var answer_extra: String?
    
    override func awakeFromNib() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowRadius = 3.0;
        self.layer.shadowOpacity = 0.5;
        
    }
    
    
    
    
}
