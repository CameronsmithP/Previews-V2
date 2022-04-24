//
//  ViewController.swift
//  Previews V2
//
//  Created by Cameron Smith on 4/15/22.
//

import UIKit
import ARKit
import RealityKit
class ViewController: UIViewController, ARSessionDelegate {
    
    
    @IBOutlet var arView: ARView!

//private var imageAnchorToEntity: [ARImageAnchor: AnchorEntity] = [:]


    let boxAnchor = try! Experience.loadLibrary1()
        var imageAnchorToEntity: [ARImageAnchor: AnchorEntity] = [:]
       
        override func viewDidLoad() {
            super.viewDidLoad()
           
            arView.scene.addAnchor(boxAnchor)
            arView.session.delegate = self
        }
       
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            anchors.compactMap { $0 as? ARImageAnchor }.forEach {
                let anchorEntity = AnchorEntity()
                let modelEntity = boxAnchor.timsLiberal!
                anchorEntity.addChild(modelEntity)
                arView.scene.addAnchor(anchorEntity)
                anchorEntity.transform.matrix = $0.transform
                imageAnchorToEntity[$0] = anchorEntity
            }
        }

        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            anchors.compactMap { $0 as? ARImageAnchor }.forEach {
                let anchorEntity = imageAnchorToEntity[$0]
                anchorEntity?.transform.matrix = $0.transform
            }
        }

    //func resetTrackingConfig() {
//Maybe this will make it so it doesnt need to keep resetting the tracking of the image
        
       // guard let refImg = ARReferenceImage.referenceImages(inGroupNamed: "AR Resource",
                        //                                          bundle: nil)
       // else { return }

       /* let config = ARWorldTrackingConfiguration()
       // config.detectionImages = refImg
        config.maximumNumberOfTrackedImages = 1

        let options = [ARSession.RunOptions.removeExistingAnchors,
                       ARSession.RunOptions.resetTracking]

        arView.session.run(config, options: ARSession.RunOptions(options))
    }*/
        
}


