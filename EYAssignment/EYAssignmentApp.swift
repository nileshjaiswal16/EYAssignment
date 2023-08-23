//
//  EYAssignmentApp.swift
//  EYAssignment
//
//  Created by Admin on 19/08/23.
//

import SwiftUI

@main
struct EYAssignmentApp: App {
    
    @StateObject var favouriteVM = FavouriteViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favouriteVM)
        }
    }
}
