//
//  ViewController.swift
//  Exercise  8 UI Elements
//
//  Created by Abhishek Maurya on 12/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class Exercise8: UIViewController {

    @IBOutlet weak var task3Selector: UISwitch!
    @IBOutlet weak var task3Answer: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func taskthree() {
        if task3Selector.isOn == true {
            task3Answer.text = """
            Bounds: of an UIView is the rectangle, expressed as a location (x,y) and size (width,height) relative to its own coordinate system (0,0).
            Frame: of an UIView is the rectangle, expressed as a location (x,y) and size (width,height) relative to the superview it is contained within.
            Clipstobounds : with clipsToBounds set to YES, I'll only see the part of the subview that fits within the bounds of the superview. Otherwise, if clipsToBounds is set to NO, I'll see the entire subview, even the parts outside the superview
            Maskstobounds: If the masksToBounds property is set to YES, any sublayers of the layer that extend outside its boundaries will be clipped to those boundaries. Think of the layer, in that case, as a window onto its sublayers; anything outside the edges of the window will not be visible.
            Strong property: means that you want to “own” the object. Only when you set the property to nil will the object be  destroyed. Unless one or more objects also have a strong reference to the object. This is the one you will use in most cases.
            Weak property: means you don’t want to have control over the objects lifecycle. The object only lives on while another objects has a strong reference to it. If there are no strong references to the object then it will be destroyed.
            """
        }else {
            task3Answer.text = ""
        }
    }
    @IBAction func openTaskOne() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Task1ViewController")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func openTaskTwo() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Task2ViewController")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func openTaskFour() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Task4PageController")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func openTaskFive() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Task5PageViewController")
        self.navigationController?.pushViewController(controller, animated: true)
    }


}

