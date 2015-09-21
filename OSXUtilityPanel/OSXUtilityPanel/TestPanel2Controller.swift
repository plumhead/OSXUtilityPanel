//
//  TestPanel2Controller.swift
//  OSXUtilityPanel
//
//  Created by Andrew Calderbank on 21/09/2015.
//  Copyright © 2015 Andrew Calderbank. All rights reserved.
//

import Cocoa

class TestPanel2Controller: UtilityItemController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collapsed = false
        panelTitle = "Panel Two"
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.greenColor().CGColor
    }
    
}
