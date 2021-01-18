//
//  VideoController.swift
//  Sample1
//
//  Created by Cameron Daniels Lawson on 1/14/21.
//  Copyright © 2021 Cameron. All rights reserved.
//

import AppKit
import SwiftUI


final class VideoController: NSViewController {
    let cameraController = VideoCamera()
    var previewView: NSView!
    var inputWidth : CGFloat!
    var inputHeight : CGFloat!
    var metrics : GeometryProxy!
    var cameraSetUp : Bool!
    var previewLock : NSLock!
    
    override func viewWillLayout() {
        super.viewWillLayout()
        print(self.view.bounds.width)
        if(cameraSetUp)
        {
            self.previewView.frame.size = CGSize(width: (self.view.bounds.width), height: (self.view.bounds.height))
           
        }
    }
    
    init(metrics : GeometryProxy)
    {
        super.init(nibName: nil, bundle: nil)
        self.inputWidth = metrics.size.width
        self.inputHeight = metrics.size.height
        self.metrics = metrics
        self.cameraSetUp = false
        self.previewLock = NSLock()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
    }
    
    override func loadView() {
        view = NSView(frame: NSMakeRect(0.0, 0.0, 400.0, 270.0))
        let label = NSTextField(labelWithString: "Another Controller")
        view.addSubview(label)
    }
    
    override func viewDidLoad() {
                
        setPreview()
    }
    func setPreview()
    {
        self.previewLock.lock()
        //previewView = NSView(frame: CGRect(x:0, y:0, width: (NSScreen.main?.frame.size.width)!, height: (NSScreen.main?.frame.size.height)!))
        previewView = NSView(frame: CGRect(x:0, y:0, width: (view.bounds.width), height: view.bounds.height))
        //previewView.contentMode = NSView.ContentMode.scaleAspectFit
        view.addSubview(previewView)
        cameraController.prepare {(error) in
            if let error = error {
                print(error)
            }
            
            try? self.cameraController.displayPreview(on: self.previewView)
        }
        self.cameraSetUp = true
        self.previewLock.unlock()
    }
}


extension VideoController : NSViewControllerRepresentable{
    public typealias NSViewControllerType = VideoController
    
    public func makeNSViewController(context: NSViewControllerRepresentableContext<VideoController>) -> VideoController {
        return VideoController(metrics: self.metrics)
    }
    
    public func updateNSViewController(_ uiViewController: VideoController, context: NSViewControllerRepresentableContext<VideoController>) {
    }
}
