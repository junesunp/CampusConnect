//
//  CampusConnectApp.swift
//  Shared
//
//  Created by John Park on 10/28/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore


@main
struct CampusConnectApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


