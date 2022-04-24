//
//  appTestApp.swift
//  appTest
//
//  Created by Daniel Spalek on 23/04/2022.
//

import SwiftUI
import Firebase

@main
struct appTestApp: App {
    
    init() {
        FirebaseApp.configure()
      }
    
    var body: some Scene {
        WindowGroup {
            MotherView().environmentObject(ViewModel())
        }
    }
}
