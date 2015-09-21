//
//  UtilityItemController.swift
//  OSXUtilityPanel
//
//  Created by Andrew Calderbank on 21/09/2015.
//  Copyright © 2015 Andrew Calderbank. All rights reserved.
//

import Cocoa

class UtilityItemController: NSViewController {

    @IBOutlet weak var contentView : NSView!
    var headerView : NSView!
    var panelBtn : NSButton!
    var panelLabel : NSTextField!
    var viewMetrics : [String:NSNumber] = [:]
    var btnTgt : UtilityItemController!

    var showLabel = "show"
    var hideLabel = "hide"
    var headerHeight : CGFloat = 40.0 { didSet{ refreshViewMetrics() } }
    var minimumPanelWidth = 150.0 { didSet{ refreshViewMetrics() } }
    var maximumPanelWidth = 1000.0 { didSet{ refreshViewMetrics() } }
    
    var panelTitle : String = "" {
        didSet {
            guard viewLoaded else {return}
            
            updateUI()
        }
    }
    
    var collapsed = false {
        didSet {
            updateUI()
        }
    }
    
    var headerHorizConstraints : [NSLayoutConstraint] = []
    var contentHorizConstraints : [NSLayoutConstraint] = []
    var headerVertConstraints : [NSLayoutConstraint] = []
    var headerContentVertConstraints : [NSLayoutConstraint] = []
    
    func updateUI() {
        guard viewLoaded else {return}
        
        panelLabel.stringValue = panelTitle
        togglePanelDisplay(collapsed)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnTgt = self
        let f = self.view.frame
        let adjustedFrame = NSRect(x: f.origin.x, y: f.origin.y, width: f.size.width, height: f.size.height + headerHeight)
        
        refreshViewMetrics()
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.wantsLayer = true
        self.contentView.layer?.backgroundColor = NSColor.controlColor().CGColor
        self.contentView.setContentHuggingPriority(250, forOrientation: NSLayoutConstraintOrientation.Horizontal)
        
        headerView = NSView()
        headerView.wantsLayer = true
        headerView.layer?.backgroundColor = NSColor.controlColor().CGColor
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.setContentHuggingPriority(250, forOrientation: NSLayoutConstraintOrientation.Horizontal)
        
        panelBtn = NSButton()
        panelBtn.title = ""
        panelBtn.action = Selector("toggleInfoPanel:")
        panelBtn.target = self
        panelBtn.translatesAutoresizingMaskIntoConstraints = false
        panelBtn.bezelStyle = NSBezelStyle.RoundRectBezelStyle
        panelBtn.bordered = false
        panelBtn.font = NSFont.systemFontOfSize(9)
        
        panelLabel = NSTextField()
        panelLabel.enabled = true
        panelLabel.editable = false
        panelLabel.alignment = NSTextAlignment.Natural
        panelLabel.drawsBackground = false
        panelLabel.bezeled = false
        panelLabel.translatesAutoresizingMaskIntoConstraints = false
        panelLabel.font = NSFont.boldSystemFontOfSize(10.0)
        
        headerView.addSubview(panelBtn)
        headerView.addSubview(panelLabel)
        
        let hv = ["btn":panelBtn, "label" : panelLabel]
        
        let hv1 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[label(>=100@251)]-(>=5)-[btn(==40)]-5-|", options: NSLayoutFormatOptions(), metrics: viewMetrics, views: hv)
        let hv2 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[btn]-5-|", options: NSLayoutFormatOptions(), metrics: viewMetrics, views: hv)
        let hv3 = NSLayoutConstraint(item: panelLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self.headerView, attribute: .CenterY, multiplier: 1, constant: 0)
        
        self.headerView.addConstraints(hv1)
        self.headerView.addConstraints(hv2)
        self.headerView.addConstraint(hv3)
        
        let v = ["hdr":headerView, "content":self.contentView]
        
        self.view.addSubview(headerView)
        self.view.frame = adjustedFrame
        
        self.headerHorizConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[hdr(>=minWidth)]|", options: NSLayoutFormatOptions(), metrics: viewMetrics, views: v)
        self.contentHorizConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[content(>=minWidth)]|", options: NSLayoutFormatOptions(), metrics: viewMetrics, views: v)
        self.headerContentVertConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[hdr(==headerHeight)][content(contentHeight)]|", options: NSLayoutFormatOptions(), metrics: viewMetrics, views: v)
        self.headerVertConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[hdr(==headerHeight)]|", options: NSLayoutFormatOptions(), metrics: viewMetrics, views: v)
        
        self.view.removeConstraints(self.view.constraints)
        self.view.addConstraints(self.headerHorizConstraints)
        self.view.addConstraints(self.contentHorizConstraints)
        self.view.addConstraints(self.headerContentVertConstraints)
        
        self.view.updateConstraints()
        
        let tracker = NSTrackingArea(rect: headerView.bounds, options: [NSTrackingAreaOptions.MouseEnteredAndExited, NSTrackingAreaOptions.ActiveAlways, NSTrackingAreaOptions.InVisibleRect], owner: self , userInfo: nil)
        headerView.addTrackingArea(tracker)
    }
    
    func refreshViewMetrics() {
        self.viewMetrics = [
            "contentHeight" : self.contentView.frame.size.height,
            "minWidth"      : self.minimumPanelWidth,
            "maxWidth"      : self.maximumPanelWidth,
            "headerHeight"  : self.headerHeight
        ]
    }
    
    override func mouseEntered(theEvent: NSEvent) {
        super.mouseEntered(theEvent)
        panelBtn.title = collapsed ? showLabel : hideLabel
    }
    
    override func mouseExited(theEvent: NSEvent) {
        super.mouseExited(theEvent)
        panelBtn.title = ""
    }
    
    func togglePanelDisplay(collapse : Bool) {
        self.contentView.hidden = collapse
        
        if collapse {
            self.view.removeConstraints(self.headerContentVertConstraints + self.contentHorizConstraints)
            self.view.addConstraints(self.headerVertConstraints)
        }
        else {
            self.view.removeConstraints(self.headerVertConstraints)
            self.view.addConstraints(self.headerContentVertConstraints + self.contentHorizConstraints)
        }
    }
    
    func toggleInfoPanel(sender: AnyObject) {
        collapsed = !self.contentView.hidden
        panelBtn.title = collapsed ? showLabel : hideLabel
    }

}
