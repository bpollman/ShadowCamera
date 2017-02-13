//
//  viewcontroller.swift
//  ShadowCamera
//
//  Created by Bernard Pollman on 9/5/16.
//  Copyright © 2016 Bernard Pollman. All rights reserved.
//


import AppKit
import AVFoundation
import CoreImage



let CMYKHalftone = "CMYK Halftone"
let CMYKHalftoneFilter = CIFilter(name: "CICMYKHalftone", withInputParameters: ["inputWidth" : 20, "inputSharpness": 1])

let ComicEffect = "Comic Effect"
let ComicEffectFilter = CIFilter(name: "CIComicEffect")

let Crystallize = "Crystallize"
let CrystallizeFilter = CIFilter(name: "CICrystallize", withInputParameters: ["inputRadius" : 30])

let Edges = "Edges"
let EdgesEffectFilter = CIFilter(name: "CIEdges", withInputParameters: ["inputIntensity" : 10])

let HexagonalPixellate = "Hex Pixellate"
let HexagonalPixellateFilter = CIFilter(name: "CIHexagonalPixellate", withInputParameters: ["inputScale" : 40])

let Invert = "Invert"
let InvertFilter = CIFilter(name: "CIColorInvert")

let Pointillize = "Pointillize"
let PointillizeFilter = CIFilter(name: "CIPointillize", withInputParameters: ["inputRadius" : 30])

let LineOverlay = "Line Overlay"
let LineOverlayFilter = CIFilter(name: "CILineOverlay")

let Posterize = "Posterize"
let PosterizeFilter = CIFilter(name: "CIColorPosterize", withInputParameters: ["inputLevels" : 5])

let Filters = [
    CMYKHalftone: CMYKHalftoneFilter,
    ComicEffect: ComicEffectFilter,
    Crystallize: CrystallizeFilter,
    Edges: EdgesEffectFilter,
    HexagonalPixellate: HexagonalPixellateFilter,
    Invert: InvertFilter,
    Pointillize: PointillizeFilter,
    LineOverlay: LineOverlayFilter,
    Posterize: PosterizeFilter
]

let FilterNames = [String](Filters.keys).sorted()

class ViewController: NSViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    @IBOutlet weak var ImageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCameraSession()
    }
    
    
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
    }
    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.layer?.addSublayer(previewLayer)
        
        cameraSession.startRunning()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
    }
    
    lazy var cameraSession: AVCaptureSession = {
        let s = AVCaptureSession()
        s.sessionPreset = AVCaptureSessionPresetLow
        return s
    }()
    
    lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let preview =  AVCaptureVideoPreviewLayer(session: self.cameraSession)

        let mirror_transform = CATransform3DScale(CATransform3DMakeRotation(0, 0, 0, 0), -1, 1, 1);
        preview?.transform = mirror_transform
        
        preview?.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        preview?.position = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
       // preview.videoGravity = AVLayerVideoGravityResize
        preview?.videoGravity = AVLayerVideoGravityResizeAspectFill
     //   preview.alpha = 0
        
        
        
        return preview!
    }()
    
    func setupCameraSession() {
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) as AVCaptureDevice
        
        do {
            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            
            cameraSession.beginConfiguration()
            
            if (cameraSession.canAddInput(deviceInput) == true) {
                cameraSession.addInput(deviceInput)
            }
            
            let dataOutput = AVCaptureVideoDataOutput()
 
     
          //  dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(unsignedInt: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
            dataOutput.alwaysDiscardsLateVideoFrames = true
            
            cameraSession.sessionPreset = AVCaptureSessionPresetLow
            
            if (cameraSession.canAddOutput(dataOutput) == true) {
                cameraSession.addOutput(dataOutput)
            }
            
            cameraSession.commitConfiguration()
            
            
            let queue = DispatchQueue(label: "com.invasivecode.videoQueue", attributes: [])
            dataOutput.setSampleBufferDelegate(self, queue: queue)
            
        }
        catch let error as NSError {
            NSLog("\(error), \(error.localizedDescription)")
        }
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        // Here you collect each frame and process it
        
//        guard let filter = Filters[FilterNames[3]] else
//        {
//            return
//        }
//        
//        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
//        let cameraImage = CIImage(CVPixelBuffer: pixelBuffer!)
//        
//        filter!.setValue(cameraImage, forKey: kCIInputImageKey)
//        
//        
//       // let filteredImage = CIImage( filter!.valueForKey(kCIOutputImageKey) as NSImage)
//        
//        let filteredImage: NSCIImageRep = NSCIImageRep(CIImage: (filter?.outputImage)!)
//        let nsImage: NSImage = NSImage(size: filteredImage.size)
//        nsImage.addRepresentation(filteredImage)
//        
//        dispatch_async(dispatch_get_main_queue())
//        {
//            self.ImageView.image = nsImage
//        }
        

    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didDrop sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        // Here you can count how many frames are dropped
    }
    
}

