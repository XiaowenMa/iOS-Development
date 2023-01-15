//
//  SceneDelegate.swift
//  XiaowenMa-Lab3
//
//  Created by 马晓雯 on 6/27/20.
//  Copyright © 2020 Xiaowen Ma. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let controller=window?.rootViewController as? ViewController
        /*
        if controller != nil{
            print("yyyyy")
        }
         */
        for button in controller!.buttons{
        button.layer.shadowColor=nil
        button.layer.shadowOffset=CGSize(width: 0, height: 0)
        button.layer.shadowRadius=0
        button.layer.shadowOpacity=0
        }
        
        switch shortcutItem.type{
        case "edu.wustl.XiaowenMa.XiaowenMa-Lab3-drawred":
            controller?.currentButton=controller?.red
            controller?.red.layer.shadowColor=UIColor.black.cgColor
            controller?.red.layer.shadowOffset=CGSize(width: 0, height: 5)
            controller?.red.layer.shadowRadius=3
            controller?.red.layer.shadowOpacity=0.5
            break
        case "edu.wustl.XiaowenMa.XiaowenMa-Lab3-drawblue":
            controller?.currentButton=controller?.blue
            controller?.blue.layer.shadowColor=UIColor.black.cgColor
            controller?.blue.layer.shadowOffset=CGSize(width: 0, height: 5)
            controller?.blue.layer.shadowRadius=3
            controller?.blue.layer.shadowOpacity=0.5
            break
        case "edu.wustl.XiaowenMa.XiaowenMa-Lab3-drawgreen":
            controller?.currentButton=controller?.green
            controller?.green.layer.shadowColor=UIColor.black.cgColor
            controller?.green.layer.shadowOffset=CGSize(width: 0, height: 5)
            controller?.green.layer.shadowRadius=3
            controller?.green.layer.shadowOpacity=0.5
            break
        case "edu.wustl.XiaowenMa.XiaowenMa-Lab3-drawyellow":
            controller?.currentButton=controller?.yellow
            controller?.yellow.layer.shadowColor=UIColor.black.cgColor
            controller?.yellow.layer.shadowOffset=CGSize(width: 0, height: 5)
            controller?.yellow.layer.shadowRadius=3
            controller?.yellow.layer.shadowOpacity=0.5
            break
        default:
            break
        }
 
        

    }
 
    



}

