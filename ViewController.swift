//
//  ViewController.swift
//  iCar
//
//  Created by Henry on 11/21/22.
//

import Combine
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



        // Do any additional setup after loading the view.
    }
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        imageView.image = session.currentFrame?.depthMapTransformedImage(orientation: orientation, viewPort: self.imageView.bounds)
    }

}

//protocol ARDataReceiver: AnyObject {
//    func onNewARData(arData: ARData)
//}
//
//
//final class ARData {
//    var depthImage: CVPixelBuffer?
//    var depthSmoothImage: CVPixelBuffer?
//    var colorImage: CVPixelBuffer?
//    var cameraIntrinsics = simd_float3x3()
//    var cameraResolution = CGSize()
//}
//
//
//final class ARReceiver: NSObject, ARSessionDelegate {
//    var arData = ARData()
//    var arSession = ARSession()
//    weak var delegate: ARDataReceiver?
//
//
//    override init() {
//        super.init()
//        arSession.delegate = self
//        start()
//    }
//
//    func start() {
//        let config = ARWorldTrackingConfiguration()
//        config.frameSemantics = .smoothedSceneDepth
//        arSession.run(config)
//    }
//
//    func pause() {
//        arSession.pause()
//    }
//
//
//    func session(_ session: ARSession, didUpdate frame: ARFrame) {
//        if(frame.sceneDepth != nil) && (frame.smoothedSceneDepth != nil) {
//            arData.depthImage = frame.sceneDepth?.depthMap
//            arData.depthSmoothImage = frame.smoothedSceneDepth?.depthMap
//            arData.colorImage = frame.capturedImage
//            arData.cameraIntrinsics = frame.camera.intrinsics
//            arData.cameraResolution = frame.camera.imageResolution
//            delegate?.onNewARData(arData: arData)
//        }
//    }
//}
