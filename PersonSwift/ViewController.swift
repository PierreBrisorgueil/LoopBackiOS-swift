//
//  ViewController.swift
//  PersonSwift
//
//  Created by RYPE on 26/04/2015.
//  Copyright (c) 2015 weareopensource. All rights reserved.
//

import UIKit

class ViewController: UIViewController, APIControllerProtocol {

    /*************************************************/
    // Main
    /*************************************************/
    
    // Boulet
    /*************************/
    @IBOutlet weak var appsTableView: UITableView!
    
    // Var
    /*************************/
    var api : APIController!
    var persons = [Person]()
    let kCellIdentifier: String = "ResultCell"
    
    // Base
    /*************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        getPerson()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Buttons actions
    /**************************************/
    @IBAction func actionGetPerson(sender: AnyObject) {
        getPerson()
    }
    
    @IBAction func unwindToSegue (segue : UIStoryboardSegue) {
        getPerson()
    }

    
    // TableView
    /*************************/
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as! UITableViewCell
        let person = self.persons[indexPath.row]
        
        cell.detailTextLabel?.text = person.mail
        cell.textLabel?.text = person.firstname
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
    
    /*************************************************/
    // Functions
    /*************************************************/
    
    func getPerson() {
        api = APIController(delegate: self)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        api.getModel("people")
    }
    
    func didReceiveAPIResults(results: NSArray) {
        dispatch_async(dispatch_get_main_queue(), {
            self.persons = Person.GETpeoples(results)
            self.appsTableView!.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }


}

