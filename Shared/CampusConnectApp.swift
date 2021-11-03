//
//  CampusConnectApp.swift
//  Shared
//
//  Created by John Park on 10/28/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth
import gRPC_Core


@main
struct CampusConnectApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            let sviewModel = AppViewModel()
            ContentView()
                .environmentObject(sviewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            //FirebaseApp.configure()
            return true
    }
}


