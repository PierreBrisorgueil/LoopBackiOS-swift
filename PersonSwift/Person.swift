//
//  Person.swift
//  PersonSwift
//
//  Created by RYPE on 26/04/2015.
//  Copyright (c) 2015 weareopensource. All rights reserved.
//

import Foundation

struct Person {
    let firstname: String
    let mail: String
    
    init(firstname: String, mail: String) {
        self.firstname = firstname
        self.mail = mail
    }
    
    /*************************************************/
    // Functions
    /*************************************************/
    static func GETpeoples(results: NSArray) -> [Person] {
        var persons = [Person]()
        
        if results.count>0 {
            for result in results {
                var firstname = result["firstname"] as? String
                var mail = result["mail"] as? String
                var newPerson = Person(
                        firstname: firstname!,
                        mail: mail!)
                persons.append(newPerson)
            }
        }
        return persons
    }
    
}
