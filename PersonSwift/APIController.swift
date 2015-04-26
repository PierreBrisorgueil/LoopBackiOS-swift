//
//  APIController.swift
//  PersonSwift
//
//  Created by RYPE on 26/04/2015.
//  Copyright (c) 2015 weareopensource. All rights reserved.
//

import Foundation
import Alamofire


/**************************************************************************************************/
// Protocol
/**************************************************************************************************/
protocol APIControllerProtocol {
    func didReceiveAPIResults(results: NSArray)
}

/**************************************************************************************************/
// Class
/**************************************************************************************************/
class APIController {
    
    /*************************************************/
    // Main
    /*************************************************/
    
    // Var
    /*************************/
    var delegate: APIControllerProtocol
    
    // init
    /*************************/
    init(delegate: APIControllerProtocol) {
        self.delegate = delegate
    }
    
    /*************************************************/
    // Functions
    /*************************************************/
    
    // actions
    /*************************/
    func get(path: String) {
        Alamofire.request(.GET, path)
            .responseJSON { (_, _, JSON, error) in
                if(error != nil) {
                    println("JSON Error \(error)")
                }
                if let results: NSArray = JSON as? NSArray {
                    self.delegate.didReceiveAPIResults(results)
                }
            }
    }
    
    func post(path: String, push: [String: AnyObject]?) {
        Alamofire.request(.POST, path, parameters: push, encoding: .JSON)
            .responseJSON { (_, _, JSON, error) in
                if(error != nil) {
                    println("JSON Error \(error)")
                }
                else{
                    self.delegate.didReceiveAPIResults(["ok"])
                }
        }
    }
    
    // requests
    /*************************/
    func getModel(model: String) {
        let urlPath = "http://localhost:3000/api/\(model)"
        get(urlPath)
    }
    
    func postModel(model: String, data: [String: AnyObject]?) {
        let urlPath = "http://localhost:3000/api/\(model)"
        post(urlPath, push: data)
    }
    
}