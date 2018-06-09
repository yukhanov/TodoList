//
//  AppDelegate.swift
//  TodoList
//
//  Created by Сергей Юханов on 22.05.2018.
//  Copyright © 2018 Yukhanov. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        
        
        do {
            _ = try Realm()
        } catch {
            print("Ошибка инициализации Realm \(error)")
        }
        
        return true
    }

   

 

}

