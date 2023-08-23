//
//  HomeView.swift
//  EYAssignment
//
//  Created by Admin on 19/08/23.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.isSearching) private var isSearching
    @State private var searchText: String = ""
    @StateObject var searchVM = SearchViewModel.shared
    @StateObject var trendingItemVM = HomeViewModel( gifAPI: GifAPI())
   
    var body: some View {
        NavigationView {
            SearchView(searchText: $searchText)
                .searchable(text: $searchVM.searchQuery)
                .onChange(of: searchVM.searchQuery) { newValue in
                    if newValue.isEmpty {
                        searchVM.phase = .empty
                    }
                }
                .onSubmit(of: .search, search)
                HomeListView(trendingItems: trendingItems)
                    .overlay(overlayView)
                    .task(id: trendingItemVM.fetchTaskToken, loadTask)
            
                
        }
        
    }
    @ViewBuilder
    private var overlayView: some View {
        
        switch trendingItemVM.phase {
        case .empty:
            ProgressView()
        case .success(let articles) where articles.isEmpty:
            EmptyPlaceholderView(text: "No Articles", image: nil)
        case .failure(_):
            EmptyView()
        default: EmptyView()
        }
    }
    private func search() {
       Task {
           await searchVM.searchItems()
        }
    }
    private var trendingItems: [TrendingItem] {
        if case let .success(trendingItems) = trendingItemVM.phase {
            return trendingItems
        } else {
            return []
        }
    }
    @Sendable
    private func loadTask() async {
        await trendingItemVM.fetchTrendingItems()
    }
    
}

struct HomeView_Previews: PreviewProvider {
    
    @StateObject static var favouriteVM = FavouriteViewModel.shared
    @State static var searchText = ""
    
    static var previews: some View {
        HomeView(trendingItemVM: HomeViewModel(trendingItems: TrendingItem.previewData, gifAPI: GifAPI()))
            .environmentObject(favouriteVM)
    }
}
