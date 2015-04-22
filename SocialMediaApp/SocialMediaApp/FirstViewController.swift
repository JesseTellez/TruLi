//
//  FirstViewController.swift
//  SocialMediaApp
//
//  Created by Samuel Hooker on 30/01/15.
//  Copyright (c) 2015 Jocus Interactive. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var listOfEveryting:[PFObject]! = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.pullData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "feedToTextPostSegue") {
            
            var view = segue.destinationViewController as textPostViewController
            view.object = sender as PFObject
            
        } else if (segue.identifier == "feedToImagePostSegue") {
            
            var view = segue.destinationViewController as imagePostViewController
            view.object = sender as PFObject
            
        }
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return listOfEveryting.count + 1
        
    
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        //nil
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0{
            //do nothing
        }
        
        else if (listOfEveryting[indexPath.row - 1].objectForKey("text")[0] as Int) == 1{
            
            //text cell tapped
            self.performSegueWithIdentifier("feedToTextPostSegue", sender: listOfEveryting[indexPath.row - 1] as PFObject)
            
        } else{
            
            //image cell tapped
            self.performSegueWithIdentifier("feedToImagePostSegue", sender: listOfEveryting[indexPath.row - 1] as PFObject)
            
        }
        
        
    }
    
    

    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //var cell:UITableViewCell!
        
        if indexPath.row == 0{
            var cell = tableView.dequeueReusableCellWithIdentifier("headerCell") as HeaderTableViewCell
            return cell
        }else{
            
           
            
            var a = listOfEveryting[indexPath.row - 1]
            
            var text:Int = a.objectForKey("text")[0] as Int
            
            
            if text == 1 {
                var cell = tableView.dequeueReusableCellWithIdentifier("textCell") as TextCell
                
                
                cell.object = listOfEveryting[indexPath.row - 1] as PFObject
                
                
                return cell
            }else{
                
                var cell = tableView.dequeueReusableCellWithIdentifier("imageCell") as ContentCell
                
                
                cell.object = listOfEveryting[indexPath.row - 1] as PFObject
                
                
                return cell
                
            }
            
            
        
            
            
        }
        
    }
    
    
    
    
    
    
    override func viewDidAppear(animated: Bool) {
        pullData()
        tableView.reloadData()
    }
    
    
    
    
    
    
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        
        if indexPath.row == 0 {
            return 185
        }
        else if (listOfEveryting[indexPath.row - 1].objectForKey("text")[0] as Int) == 1{
            return 136
        }else{
            return 224
        }
        
        
        
    }
    
    
    
    
    func pullData(){
        
        var query = PFQuery(className: "Posts")
        query.addDescendingOrder("createdAt")
        query.limit = 30
        
        query.findObjectsInBackgroundWithBlock { (objects:[AnyObject]!, error:NSError!) -> Void in
            
            if error == nil {
                
                self.listOfEveryting = objects as? [PFObject]
                self.tableView.reloadData()
                
            }else{
                
                println("error retrieving data: \(error.localizedDescription)")
                
            }
            
        }
        
        
        
        
        
    }


}

