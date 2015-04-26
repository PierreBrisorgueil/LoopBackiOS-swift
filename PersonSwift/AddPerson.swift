//
//  AddPerson.swift
//  PersonSwift
//
//  Created by RYPE on 26/04/2015.
//  Copyright (c) 2015 weareopensource. All rights reserved.
//

import UIKit

class AddPerson: UIViewController, APIControllerProtocol {
    
    /*************************************************/
    // Main
    /*************************************************/
    
    // Boulet
    /*************************/
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var mailField: UITextField!
    
    // Var
    /*************************/
    lazy var api : APIController = APIController(delegate: self)
    
    // Base
    /*************************/
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*************************************************/
    // Functions
    /*************************************************/
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        api = APIController(delegate: self)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        var newPerson = [
            "firstname": firstnameField.text,
            "mail": mailField.text
        ]
        api.postModel("people", data: newPerson)
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func didReceiveAPIResults(results: NSArray) {
        dispatch_async(dispatch_get_main_queue(), {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
}