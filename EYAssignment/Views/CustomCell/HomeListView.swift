//
//  HomeListView.swift
//  EYAssignment
//
//  Created by Nilesh Jaiswal on 19/08/23.
//

import SwiftUI

struct HomeListView: View {
    
    let trendingItems: [TrendingItem]
    @State var mode = 0
    
    var body: some View {
        List {
            ForEach(trendingItems) { trendingItem in
                HomeListViewCell(trendingItem: trendingItem)
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        
    }
}

struct HomeListView_Previews: PreviewProvider {
    
    @StateObject static var favouriteVM = FavouriteViewModel.shared
    
    static var previews: some View {
        NavigationView {
            HomeListView(trendingItems: TrendingItem.previewData)
                .environmentObject(favouriteVM)
        }
    }
}
