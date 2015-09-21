//
//  UtilityPanelController.swift
//  OSXUtilityPanel
//
//  Created by Andrew Calderbank on 21/09/2015.
//  Copyright © 2015 Andrew Calderbank. All rights reserved.
//

import Cocoa

class UtilityPanelController: NSViewController {
    @IBOutlet weak var utilityStack: NSStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = NSStoryboard(name: "UtilityPanels", bundle: nil)
        
        let box1 = NSBox()
        box1.boxType = NSBoxType.Separator
        box1.translatesAutoresizingMaskIntoConstraints = false
        
        let panel1 = storyboard.instantiateControllerWithIdentifier("Panel1") as! TestPanel1Controller
        
        if #available(OSX 10.11, *) {
            self.utilityStack.addArrangedSubview(panel1.view)
        } else {
            // Fallback on earlier versions
        }
        
        if #available(OSX 10.11, *) {
            self.utilityStack.addArrangedSubview(box1)
        } else {
            // Fallback on earlier versions
        }

        let panel2 = storyboard.instantiateControllerWithIdentifier("Panel2") as! TestPanel2Controller
        if #available(OSX 10.11, *) {
            self.utilityStack.addArrangedSubview(panel2.view)
        } else {
            // Fallback on earlier versions
        }
        
        
    }
    
}
