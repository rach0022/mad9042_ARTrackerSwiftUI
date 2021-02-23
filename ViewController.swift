//
//  ViewController.swift
//  ARTracker
//
//  Created by Ravi Rachamalla on 2021-02-23.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        // set up the images to track to our AR Resource Group
        if let trackingImageRepo = ARReferenceImage.referenceImages(inGroupNamed: "AR Ressources", bundle: Bundle.main) {
            
            // bind our AR Configuration to the tracking image repo and
            // tell the AR kit how many images we want to track. In this case 1
            // but we can track up to 100
            configuration.trackingImages = trackingImageRepo
            configuration.maximumNumberOfTrackedImages = 1
            
        }
        

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
     //Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor){
        guard anchor is ARImageAnchor else { return }
        
        // make sure the image we match is the one we want
        guard let trackingImage = sceneView.scene.rootNode.childNode(withName: "oasis_DigOutYourSoul-Art", recursively: false) else { return }
        // remove the tracking image from the view and hide it
        trackingImage.removeFromParentNode()
        node.addChildNode(trackingImage)
        
        trackingImage.isHidden = false
        
        let videoURL = Bundle.main.url(forResource: "FallingDown-Live", withExtension: "mp4")!
        let videoPlayer = AVPlayer(url: videoURL)
        
        let videoScene = SKScene(size: CGSize(width: 360.0, height: 640.0))
        
        // set up the video node
        let videoNode = SKVideoNode(avPlayer: videoPlayer)
        videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
        videoNode.size = videoScene.size
        videoNode.yScale = -1
        videoNode.play()
        
        videoScene.addChild(videoNode)
        
        guard let video = trackingImage.childNode(withName: "video", recursively: true) else { return }
        video.geometry?.firstMaterial?.diffuse.contents = videoScene
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
