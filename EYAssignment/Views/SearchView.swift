//
//  SearchView.swift
//  EYAssignment
//
//  Created by Admin on 22/08/23.
//

import SwiftUI



struct SearchView: View {
    @Environment(\.isSearching) private var isSearching
    @Binding var searchText: String
    @StateObject var searchVM = SearchViewModel.shared
    @StateObject var trendingItemVM = HomeViewModel( gifAPI: GifAPI())
    var body: some View {
        if isSearching {
            HomeListView(trendingItems: trendingSearchItems)
                  .task(id: searchVM.searchTaskToken, loadTSearch)
          }
         else {
             HomeListView(trendingItems: trendingItems)
                 .task(id: trendingItemVM.fetchTaskToken, loadTask)
        }
    }
    private var trendingSearchItems: [TrendingItem] {
        if case .success(let searchItem) = searchVM.phase {
            return searchItem
        } else {
            return []
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
    private func loadTSearch() async {
        await searchVM.searchItems()
    }
    @Sendable
    private func loadTask() async {
        await trendingItemVM.fetchTrendingItems()
    }
}



