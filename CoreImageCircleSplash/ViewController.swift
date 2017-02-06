//
//  ViewController.swift
//  CoreImageCircleSplash
//
//  Created by Mac air on 12/18/16.
//  Copyright © 2016 Mac air. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    
    let filter=CIFilter(name: "CICircleSplashDistortion");
    let context=CIContext(options: nil);
    var extent:CGRect!;
    var scaleFactor:CGFloat!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scaleFactor=UIScreen.main.scale;
        // apply a transformation based on scale factor
        extent=UIScreen.main.bounds.applying(CGAffineTransform(scaleX: scaleFactor, y: scaleFactor));
        
        let ciImage=CIImage(image: imageView.image!);
        
        filter?.setDefaults();
        filter?.setValue(ciImage, forKey: kCIInputImageKey);
        
        imageView.image=UIImage(cgImage: context.createCGImage((filter?.outputImage)!, from: extent)!);
        
        panGesture.addTarget(self, action: #selector(self.panned));
        print("first");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func panned(gesture:UIGestureRecognizer){
        print("second");
        let location=gesture.location(in: imageView);
        let x=location.x;
        // inverted and moving correctly with the user finger
        let y=imageView.bounds.height*scaleFactor-location.y*scaleFactor;
        
        filter?.setValue(CIVector(x:x,y:y), forKey: kCIInputCenterKey);
        
        imageView.image=UIImage(cgImage: context.createCGImage((filter?.outputImage)!, from: extent)!);
    }
    
}

