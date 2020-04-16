//
//  Answer.swift
//  Stam Acasa
//
//  Created by Macbook on 4/13/20.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import Foundation
import UIKit


public struct ResponseData: Codable,Hashable {
    var date: String?
    var flow_id: String?
    var responses : [Answer]?

    public struct Answer: Codable,Hashable {
        var section_id: String?
        var question_id: Int?
        var question_text: String?
        var answer_id: Int?
        var answer_text: String?
        var answer_extra: String?
        
        public static func ==(left:Answer, right:Answer) -> Bool {
            return left.section_id == right.section_id && left.question_id == right.question_id && left.question_text == right.question_text && left.answer_id == right.answer_id && left.answer_text == right.answer_text && left.answer_extra == right.answer_extra
        }
    }
    
    public struct Movement: Codable, Hashable{
        var date: String!
        var leaveTime: String!
        var arriveTime: String!
        var reason: String!
        var directContact: Bool!
        
    }
}


public struct AccountData: Codable,Hashable {
    var primary:Bool?
    var accountId:Int?
    var numePrenume: String?
    var numarTelefon: String?
    var judet: String?
    var localitate: String?
    var varsta: String?
    var gen: String?
    var accountCreationResponses: ResponseData?
    var registrationDate: String?
    
}
