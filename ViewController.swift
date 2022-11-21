//
//  ViewController.swift
//  iCar
//
//  Created by Henry on 11/21/22.
//

import UIKit
import ARKit
import RealityKit
import MetalKit
import Metal

class ViewController: UIViewController, ARSessionDelegate {
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var imageView: UIImageView!
    let configuration = ARWorldTrackingConfiguration()
    
    var orientation: UIInterfaceOrientation {
        guard let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation else {
            fatalError()
        }
        return orientation
    }
    
    override func viewDidLoad() {
        func buildConfigure() -> ARWorldTrackingConfiguration {
            let configuration = ARWorldTrackingConfiguration()
            configuration.environmentTexturing = .automatic
            
            configuration.frameSemantics = .smoothedSceneDepth
            

            return configuration
        }
        super.viewDidLoad()
        
        
        sceneView.session.delegate = self
        let configuration = buildConfigure()
        sceneView.session.run(configuration)
        
        self.sceneView.session.run(configuration)
        let metalLibURL: URL = Bundle.module.url(forResource: "MyMetalLib", withExtension: "metallib", subdirectory: "Metal")!

        
        // Do any additional setup after loading the view.
    }
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        imageView.image = session.currentFrame?.depthMapTransformedImage(orientation: orientation, viewPort: self.imageView.bounds)
    }

}

