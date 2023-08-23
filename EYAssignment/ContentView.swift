//
//  ContentView.swift
//  EYAssignment
//
//  Created by Nilesh Jaiswal on 19/08/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            FavouriteView()
                .tabItem {
                    Label("Favourite", systemImage: "heart")
                }
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
