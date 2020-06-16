//
//  ViewController.swift
//  ARStamp
//
//  Created by 西岡亮太 on 2020/06/16.
//  Copyright © 2020 西岡亮太. All rights reserved.
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
            
            // Show statistics such as fps and timing information
            sceneView.showsStatistics = true
            
            // Create a new scene
            //let scene = SCNScene(named: "art.scnassets/ship.scn")!
            
            // Set the scene to the view
            //sceneView.scene = scene
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            // Create a session configuration
            let defaultConfiguration: ARWorldTrackingConfiguration = {
            let configuration = ARWorldTrackingConfiguration()
            configuration.planeDetection = [.horizontal, .vertical]
            configuration.environmentTexturing = .automatic
            configuration.frameSemantics = .personSegmentationWithDepth
            return configuration
            }()
                
            // Run the view's session
            sceneView.session.run(defaultConfiguration)
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            // Pause the view's session
            sceneView.session.pause()
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            var textNode = SCNNode()
            
            let iValue = Int.random(in: 1 ... 10)
            
            
            if (iValue <= 3){
            let textGeometry = SCNText(string: "オラァ！", extrusionDepth: 1)
            textGeometry.firstMaterial?.diffuse.contents = UIColor.blue
                textGeometry.firstMaterial?.diffuse.contents = UIFont.italicSystemFont
            textNode = SCNNode(geometry: textGeometry)
            textNode.scale = SCNVector3(0.0005, 0.0005, 0.0005)
            }else if(iValue > 3 && iValue <= 5){
            let textGeometry = SCNText(string: "オラオラオラァァァ！", extrusionDepth: 1)
                textGeometry.firstMaterial?.diffuse.contents = UIFont.boldSystemFont
            textGeometry.firstMaterial?.diffuse.contents = UIColor.blue
            textNode = SCNNode(geometry: textGeometry)
            textNode.scale = SCNVector3(0.0007, 0.0007, 0.0007)

            }else if(iValue > 5 && iValue <= 8){
            let textGeometry = SCNText(string: "無駄ァ！", extrusionDepth: 1)
                textGeometry.firstMaterial?.diffuse.contents = UIFont.boldSystemFont
            textGeometry.firstMaterial?.diffuse.contents = UIColor.red
            textNode = SCNNode(geometry: textGeometry)
            textNode.scale = SCNVector3(0.0005, 0.0005, 0.0005)

            }else if(iValue > 8 && iValue <= 10){
            let textGeometry = SCNText(string: "無駄無駄無駄ァァァ！", extrusionDepth: 1)
                textGeometry.firstMaterial?.diffuse.contents = UIFont.boldSystemFont
                textGeometry.firstMaterial?.diffuse.contents = UIColor.red
                textNode = SCNNode(geometry: textGeometry)
                textNode.scale = SCNVector3(0.0007, 0.0007, 0.0007)
            }else{
           let textGeometry = SCNText(string: "すこ♥", extrusionDepth: 1)
               textGeometry.firstMaterial?.diffuse.contents = UIFont.boldSystemFont
               textGeometry.firstMaterial?.diffuse.contents = UIColor.yellow
               textNode = SCNNode(geometry: textGeometry)
               textNode.scale = SCNVector3(0.01, 0.01, 0.01)

            }
            
            
            //カメラ座標系で50センチ前
            let infrontCamera = SCNVector3Make(0, 0, -0.5)
            guard let cameraNode = sceneView.pointOfView else {
                return
            }
            
            //ワールド座標系に変換
            
            let pointInWorld = cameraNode.convertPosition(infrontCamera, to: nil)
            
            //スクリーン座標系へ変換
            var screenPositon = sceneView.projectPoint(pointInWorld)
            
            //スクリーン座標系
              guard let location = touches.first?.location(in: sceneView) else{
                  return
              }
            screenPositon.x = Float(location.x)
            screenPositon.y = Float(location.y)
            
            //ワールド座標系
            let finalPosition = sceneView.unprojectPoint(screenPositon)
           
            textNode.eulerAngles = cameraNode.eulerAngles
          
            textNode.position = finalPosition
            sceneView.scene.rootNode.addChildNode(textNode)
        }

        // MARK: - ARSCNViewDelegate
        
    
//        // Override to create and configure nodes for anchors added to the view's session.
//    func renderer(_ renderer: SCNSceneRenderer, didAdd node: anchor: ARAnchor){
//            let node = SCNNode()
//
//            return node
//        }
    
        
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
