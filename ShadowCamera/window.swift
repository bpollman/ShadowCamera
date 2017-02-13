//
//  window.swift
//  ShadowCamera
//
//  Created by Bernard Pollman on 9/5/16.
//  Copyright © 2016 Bernard Pollman. All rights reserved.
//

import Cocoa
import AVFoundation

class TransparentWindow : NSWindow {
    
    override init(contentRect: NSRect, styleMask aStyle: NSWindowStyleMask, backing bufferingType: NSBackingStoreType, defer flag: Bool) {
        
        super.init(contentRect: contentRect, styleMask: aStyle, backing: bufferingType, defer: false)

        
        // Set up transparency
        alphaValue = 0.10
        isOpaque = false
        
        // Make transparent to mouse events
        ignoresMouseEvents = true
        
        // Bring to front of all windows
        makeKeyAndOrderFront(nil)
        
        // Make it always on top of other windows
        level = Int(CGWindowLevelForKey(CGWindowLevelKey.statusWindow))
        
        
    }
    }
