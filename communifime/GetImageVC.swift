//
//  GetImageVC.swift
//  communifime
//
//  Created by Michael Litman on 4/1/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import CLImageEditor

class GetImageVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLImageEditorDelegate
{
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var editButton : UIButton!
    var buttonForImage : UIButton!
    let imagePicker = UIImagePickerController()
    var currImage : UIImage?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.editButton.enabled = false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        if(currImage != nil)
        {
            self.imageView.image = self.currImage
            self.editButton.enabled = true

        }
        // Do any additional setup after loading the view.
    }

    @IBAction func editButtonPressed()
    {
        let editor = CLImageEditor(image: self.imageView.image, delegate: self)
        self.presentViewController(editor, animated: true, completion: nil)
    }
    
    func imageEditor(editor: CLImageEditor!, didFinishEdittingWithImage image: UIImage!)
    {
        self.imageView.image = image
        self.editButton.enabled = true
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveImageButtonPressed(sender: UIButton)
    {
        self.buttonForImage.setBackgroundImage(self.imageView.image, forState: .Normal)
        self.buttonForImage.setBackgroundImage(self.imageView.image, forState: .Highlighted)
        self.buttonForImage.setBackgroundImage(self.imageView.image, forState: .Selected)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func loadImageFromCameraRollButtonPressed(sender: UIButton)
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func loadImageFromCameraButtonPressed(sender: UIButton)
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
            self.editButton.enabled = true

        }
        
        dismissViewControllerAnimated(true, completion: nil)
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
