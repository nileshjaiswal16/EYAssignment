//
//  EYAssignmentApp.swift
//  EYAssignment
//
//  Created by Nilesh Jaiswal on 19/08/23.
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
