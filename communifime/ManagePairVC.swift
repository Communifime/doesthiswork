//
//  ManagePairVC.swift
//  communifime
//
//  Created by Michael Litman on 4/6/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class ManagePairVC: UIViewController
{
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var value: UITextField!
    @IBOutlet weak var navBar: UINavigationBar!
    var varName = "New Label"
    var parentPairList : PairList!
    var editMode = false
    var editPair : Pair!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if(editMode)
        {
            self.navBar.topItem?.title = "Edit \(self.varName)"
            self.name.text = self.editPair.name
            self.value.text = self.editPair.value
            self.deleteButton.hidden = false
        }
        else
        {
        
            self.navBar.topItem?.title = "New \(self.varName)"
            self.deleteButton.hidden = true
        }
        self.name.maskWithUnderline()
        self.value.maskWithUnderline()
        self.name.becomeFirstResponder()
    }
    
    @IBAction func deleteButtonPressed(sender: AnyObject)
    {
        let vc = UIAlertController(title: "Delete Confirm", message: "Are you sure you want to delete this entry?", preferredStyle: .Alert)
        let confirm = UIAlertAction(title: "Confirm", style: .Default) { (action) in
            //do delete code
            
            let data = self.parentPairList.data
            var newData = [Pair]()
            for datum in data
            {
                if(datum != self.editPair)
                {
                    newData.append(datum)
                }
            }
            self.parentPairList.data = newData
            self.parentPairList.tableView.reloadData()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        vc.addAction(confirm)
        vc.addAction(cancel)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func validateForm() -> Bool
    {
        return true
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject)
    {
        if(self.validateForm())
        {
            if(editMode)
            {
                self.editPair.name = self.name.text!
                self.editPair.value = self.value.text!
                self.parentPairList.tableView.reloadData()
            }
            else
            {
                self.parentPairList.addPair(self.name.text!, value: self.value.text!)
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
