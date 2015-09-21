//
//  UtilityWindowController.swift
//  OSXUtilityPanel
//
//  Created by Andrew Calderbank on 21/09/2015.
//  Copyright © 2015 Andrew Calderbank. All rights reserved.
//

import Cocoa

class UtilityWindowController: NSWindowController {
    
    lazy var mainStoryboard : NSStoryboard = {
        let story = NSStoryboard(name: "Main", bundle: nil)
        return story
        }()
    
    lazy var editController : ViewController = {
        let edit = self.mainStoryboard.instantiateControllerWithIdentifier("Editor") as! ViewController
        return edit
        }()

    lazy var utilityController : UtilityPanelController = {
        let inspect = self.mainStoryboard.instantiateControllerWithIdentifier("UtilityPanel") as! UtilityPanelController
        return inspect
        }()
    
    lazy var splitController : NSSplitViewController = {
        let split = NSSplitViewController()
        
        split.view.wantsLayer = true
        
        let editItem = NSSplitViewItem(viewController: self.editController)
        split.addSplitViewItem(editItem)
        
        let insItem = NSSplitViewItem(viewController: self.utilityController)
        insItem.canCollapse = true
        split.addSplitViewItem(insItem)
        
        return split
    }()
    

    override func windowDidLoad() {
        super.windowDidLoad()
    
        guard let window = window else {
            fatalError("`window` is expected to be non nil by this time.")
        }
        
        let frameSize = window.contentRectForFrameRect(window.frame).size
        splitController.view.setFrameSize(frameSize)
        
        self.windowFrameAutosaveName = "Window Frame"
        window.contentViewController = splitController
    }

}
