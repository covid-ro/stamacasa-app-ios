//
//  MyData.swift
//  Stam Acasa
//
//  Created by Macbook on 4/8/20.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import Foundation

struct MyData: Decodable,Hashable,Encodable {
    let meta: Meta?
    let data: Data?
    
    init(){
        meta = Meta()
        data = Data()
    }
    
    static func ==(left:MyData, right:MyData) -> Bool {
        return left.meta == right.meta &&
            left.data == right.data
        
    }
    
    struct Meta:Decodable,Hashable,Encodable {
        var version: String?
        var succes: String?
        var code: String?
        var message: String?
        
        init(){
        }
        
        static func ==(left:Meta, right:Meta) -> Bool {
            return left.version == right.version &&
                left.succes == right.succes &&
                left.code == right.code &&
                left.message == right.message
            
        }
    }
    
    struct Data:Decodable,Hashable,Encodable {
        var flows: [Flow]?
        
        init(){
        }
        
        static func ==(left:Data, right:Data) -> Bool {
            return left.flows == right.flows
            
        }
        
        struct Flow: Decodable,Hashable,Encodable{
            var flow_id: String?
            var flow_name: String?
            var flow_sections: [FlowSection]?
            
            init(){
            }
            
            static func ==(left:Flow, right:Flow) -> Bool {
                return left.flow_id == right.flow_id &&
                    left.flow_name == right.flow_name &&
                    left.flow_sections == right.flow_sections
            }
            
            struct FlowSection: Decodable,Hashable,Encodable{
                var section_id: String?
                var section_name: String?
                var section_next_id: String?
                var section_text: String?
                var questions: [Question]?
                
                init(){
                }
                
                static func ==(left:FlowSection, right:FlowSection) -> Bool {
                    return left.section_id == right.section_id &&
                        left.section_name == right.section_name &&
                        left.section_next_id == right.section_next_id &&
                        left.questions == right.questions
                }
                
                struct Question: Decodable,Hashable,Encodable{
                    var question_id: Int?
                    var question_order: Int?
                    var question_hidden: Bool?
                    var question_type: String?
                    var question_text: String?
                    var question_answers: [QuestionAnswer]?
                    
                    init(){
                    }
                    
                    static func ==(left:Question, right:Question) -> Bool {
                        return left.question_id == right.question_id &&
                            left.question_order == right.question_order &&
                            left.question_hidden == right.question_hidden &&
                            left.question_type == right.question_type &&
                            left.question_text == right.question_text &&
                            left.question_answers == right.question_answers
                    }
                    
                    struct QuestionAnswer: Decodable,Hashable,Encodable{
                        var answer_id: Int?
                        var answer_text: String?
                        var answer_decision: AnswerDecision?
                        
                        init(){
                        }
                        
                        static func ==(left:QuestionAnswer, right:QuestionAnswer) -> Bool {
                            return left.answer_id == right.answer_id &&
                                left.answer_text == right.answer_text &&
                                left.answer_decision == right.answer_decision
                        }
                        
                        struct AnswerDecision: Decodable,Hashable,Encodable{
                            var answer_input: String?
                            var answer_question_id: Int?
                            var answer_hint: String?
                            
                            init(){
                            }
                            
                            static func ==(left:AnswerDecision, right:AnswerDecision) -> Bool {
                                return left.answer_input == right.answer_input &&
                                    left.answer_question_id == right.answer_question_id
                            }
                        }
                        
                    }
                }
            }
        }
    }
}
