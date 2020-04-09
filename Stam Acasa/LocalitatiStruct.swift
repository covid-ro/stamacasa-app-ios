//
//  localitatiStruct.swift
//  Stam Acasa
//
//  Created by Sebi on 08/04/2020.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import Foundation

struct LocalitatiStruct: Decodable,Hashable,Encodable {
    var judete: [Judet]?

    init(){
    }

    static func ==(left:LocalitatiStruct, right:LocalitatiStruct) -> Bool {
        return left.judete == right.judete
        
    }

    struct Judet: Decodable,Hashable,Encodable{
        var auto: String?
        var nume: String?
        var localitati: [Localitate]?
        
        init(){
        }
        
        static func ==(left:Judet, right:Judet) -> Bool {
            return left.auto == right.auto &&
                left.nume == right.nume &&
                left.localitati == right.localitati
        }
        
        struct Localitate: Decodable,Hashable,Encodable{
            var nume: String?
            var simplu: String?
            var comuna: String?
            
            init(){
            }
            
            static func ==(left:Localitate, right:Localitate) -> Bool {
                return left.nume == right.nume &&
                    left.simplu == right.simplu &&
                    left.comuna == right.comuna
            }
        }
    }
}
