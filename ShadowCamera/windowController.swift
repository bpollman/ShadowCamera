//
//  windowController.swift
//  ShadowCamera
//
//  Created by Bernard Pollman on 9/6/16.
//  Copyright © 2016 Bernard Pollman. All rights reserved.
//

import AppKit

class WindowController: NSWindowController
{
    
    override init(window: NSWindow!) {
        super.init(window: window)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        if let screen = NSScreen.main() {
            window?.setFrame(screen.visibleFrame, display: true, animate: true)
        }
    }
}
