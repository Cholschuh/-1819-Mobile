//
//  AppDelegate.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 1/25/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import UIKit
import CoreData
import KontaktSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Kontakt.setAPIKey("GqntkJyqoHowcAjaKwOXijUvNAOhlrgh")
        preloadData()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
      if let rootViewController = self.topViewControllerWithRootViewController(rootViewController: window?.rootViewController) {
        if (rootViewController.responds(to: Selector(("canRotate")))) {
          // Unlock landscape view orientations for this view controller
          return .allButUpsideDown;
        }
      }
      
      // Only allow portrait (standard behaviour)
      return .portrait;
    }
    
    private func topViewControllerWithRootViewController(rootViewController: UIViewController!) -> UIViewController? {
      if (rootViewController == nil) { return nil }
      if (rootViewController.isKind(of: UITabBarController.self)) {
        return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UITabBarController).selectedViewController)
      } else if (rootViewController.isKind(of: UINavigationController.self)) {
        return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UINavigationController).visibleViewController)
      } else if (rootViewController.presentedViewController != nil) {
        return topViewControllerWithRootViewController(rootViewController: rootViewController.presentedViewController)
      }
      return rootViewController
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "_1819_Mobile")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func preloadData(){
        //Check to see if the preloadedDataKey is set to True if not then it will upload data and mark key as true.
        
        let preloadedDataKey = "didPreloadData"
        let userDefaults = UserDefaults.standard
        
        if userDefaults.bool(forKey: preloadedDataKey) == false {
            //preload
            guard let fileUrl = Bundle.main.path(forResource: "FloorAndRoomData", ofType: "json") else {
                print("Unable to find file, Could not load data.")
                return
            }
            // gets readable URL
            let dataURL = URL(fileURLWithPath: fileUrl)
            
            let backgroundContext = persistentContainer.newBackgroundContext()
            persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
            
            backgroundContext.perform {
                var floors = [floor]()
                let task = URLSession.shared.dataTask(with: dataURL) { (data, response, error) in
                    
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    if let data = data {
                        //Decodes Json to room objects and stores in the Rooms array of room objets
                        do {
                            floors = try JSONDecoder().decode([floor].self, from: data)
                            for floor in floors{
                                let floorObj = FloorsMO(context: backgroundContext)
                                floorObj.name = floor.name
                                floorObj.mapImage = floor.mapImage
                                for room in floor.rooms{
                                    let roomObj = RoomsMO(context: backgroundContext)
                                    roomObj.name = room.name
                                    roomObj.roomNumber = room.roomNumber
                                    roomObj.information = room.information
                                    roomObj.beaconMajorVal = room.beaconMajorVal
                                    roomObj.beaconMinorVal = room.beaconMinorVal
                                    for photo in room.photos{
                                        let photoObj = PhotosMO(context: backgroundContext)
                                        photoObj.altText = photo.altText
                                        photoObj.path = photo.path
                                        roomObj.addToRawPhotos(photoObj)
                                    }
                                    floorObj.addToRawRooms(roomObj)
                                }
                            }
                            try backgroundContext.save()
                        }catch {
                            print(error.localizedDescription)
                        }
                    }
                    
                }
                task.resume()
                userDefaults.set(true, forKey: preloadedDataKey)
            }
            
        }else{
            //print("Data already loaded")
            
        }
    }
    
}

