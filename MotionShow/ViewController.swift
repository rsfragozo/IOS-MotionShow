//
//  ViewController.swift
//  MotionShow
//
//  Created by vinigodoy on 18/02/16.
//  Copyright © 2016 pucpr. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController{
    @IBOutlet var lblAccX: UILabel!
    @IBOutlet var lblAccY: UILabel!
    @IBOutlet var lblAccZ: UILabel!
    @IBOutlet var lblMaxAccX: UILabel!
    @IBOutlet var lblMaxAccY: UILabel!
    @IBOutlet var lblMaxAccZ: UILabel!
    
    @IBOutlet var lblRotX: UILabel!
    @IBOutlet var lblRotY: UILabel!
    @IBOutlet var lblRotZ: UILabel!
    @IBOutlet var lblMaxRotX: UILabel!
    @IBOutlet var lblMaxRotY: UILabel!
    @IBOutlet var lblMaxRotZ: UILabel!

    var currentMaxAccelX: Double = 0.0
    var currentMaxAccelY: Double = 0.0
    var currentMaxAccelZ: Double = 0.0
    
    var currentMaxRotX: Double = 0.0
    var currentMaxRotY: Double = 0.0
    var currentMaxRotZ: Double = 0.0
    
    var movementManager = CMMotionManager()
    
    
    @IBAction func resetMaxValues(_ sender: AnyObject) {
        currentMaxAccelX = 0
        currentMaxAccelY = 0
        currentMaxAccelZ = 0
        
        currentMaxRotX = 0
        currentMaxRotY = 0
        currentMaxRotZ = 0
    }
    
    override func viewDidLoad() {
        currentMaxAccelX = 0
        currentMaxAccelY = 0
        currentMaxAccelZ = 0
        
        currentMaxRotX = 0
        currentMaxRotY = 0
        currentMaxRotZ = 0
        
        movementManager.gyroUpdateInterval = 0.2
        movementManager.accelerometerUpdateInterval = 0.2
        
        //Inicia o rastreamento do movimento
        movementManager.startAccelerometerUpdates(to: OperationQueue.current!) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
            
            self.outputAccData(accelerometerData!.acceleration)
            if(NSError != nil) {
                print("\(NSError)")
            }
        }
        
        movementManager.startGyroUpdates(to: OperationQueue.current!, withHandler: { (gyroData: CMGyroData?, NSError) -> Void in
            self.outputRotData(gyroData!.rotationRate)
            if (NSError != nil){
                print("\(NSError)")
            }
        })
    }
    
    func outputAccData(_ acceleration: CMAcceleration){
        lblAccX?.text = "\(acceleration.x).2fg"
        if fabs(acceleration.x) > fabs(currentMaxAccelX) {
            currentMaxAccelX = acceleration.x
        }
        
        lblAccY?.text = "\(acceleration.y).2fg"
        if fabs(acceleration.y) > fabs(currentMaxAccelY) {
            currentMaxAccelY = acceleration.y
        }
        
        lblAccZ?.text = "\(acceleration.z).2fg"
        if fabs(acceleration.z) > fabs(currentMaxAccelZ) {
            currentMaxAccelZ = acceleration.z
        }
        
        lblMaxAccX?.text = "\(currentMaxAccelX).2f"
        lblMaxAccY?.text = "\(currentMaxAccelY).2f"
        lblMaxAccZ?.text = "\(currentMaxAccelZ).2f"
    }
    
    func outputRotData(_ rotation: CMRotationRate) {
        lblRotX?.text = "\(rotation.x).2fr/s"
        if fabs(rotation.x) > fabs(currentMaxRotX) {
            currentMaxRotX = rotation.x
        }
        
        lblRotY?.text = "\(rotation.y).2fr/s"
        if fabs(rotation.y) > fabs(currentMaxRotY) {
            currentMaxRotY = rotation.y
        }
        
        lblRotZ?.text = "\(rotation.z).2fr/s"
        if fabs(rotation.z) > fabs(currentMaxRotZ) {
            currentMaxRotZ = rotation.z
        }

        lblMaxRotX?.text = "\(currentMaxRotX).2f"
        lblMaxRotY?.text = "\(currentMaxRotY).2f"
        lblMaxRotZ?.text = "\(currentMaxRotZ).2f"
    }
}
