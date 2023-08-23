//
//  FavouriteView.swift
//  EYAssignment
//
//  Created by Nilesh Jaiswal on 19/08/23.
//

import SwiftUI

struct FavouriteView: View {
    @EnvironmentObject var favouriteVM: FavouriteViewModel
    @State private var mode: Int = 0
    var body: some View {
        let trendingItems = self.trendingItems
        
        NavigationView {
            HStack() {
                if mode == 0 {
                    FavouriteGridView(trendingItem: trendingItems)
                }
                if mode == 1 {
                    HomeListView(trendingItems: trendingItems)
                }
                
            }
            .task {
                 await favouriteVM.load()
            }
            .toolbar {
              ToolbarItem(placement: .principal) {
                  Picker("View", selection: $mode) {
                    Text("Grid").tag(0)
                    Text("List").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            }
          }
        }
     }
    private var trendingItems: [TrendingItem] {
        
        return favouriteVM.favourites
          
    }
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            EmptyPlaceholderView(text: "No saved Items", image: Image(systemName: "heart"))
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    
    @StateObject static var favouriteVM = FavouriteViewModel.shared

    static var previews: some View {
        FavouriteView()
            .environmentObject(favouriteVM)
    }
}
