//
//  TestPanel2Controller.swift
//  OSXUtilityPanel
//
//  Created by Andrew Calderbank on 21/09/2015.
//  Copyright © 2015 Andrew Calderbank. All rights reserved.
//

import Cocoa

class TestPanel2Controller: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.greenColor().CGColor
    }
    
}
