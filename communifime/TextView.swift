//
//  TextView.swift
//  communifime
//
//  Created by Michael Litman on 4/5/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit

class TextView: UIViewController
{
    @IBOutlet weak var tf: UITextField!
    var name = "Default Name"
    var placeholder = "Default Placeholder"
    var value = "Default Value"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tf.placeholder = self.placeholder
        tf.text = self.value
        tf.maskWithUnderline()
    }

    func getView() -> UIView
    {
        return self.tf
    }
    
    func setRect(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)
    {
        self.tf.setRect(x, y: y, width: width, height: height)
    }
    
    override func didReceiveMemoryWarning() {
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
