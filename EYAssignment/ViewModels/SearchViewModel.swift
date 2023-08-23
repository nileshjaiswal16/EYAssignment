//
//  SearchViewModel.swift
//  EYAssignment
//
//  Created by Admin on 22/08/23.
//

import Foundation
import SwiftUI

struct SearchTaskToken: Equatable {
    var token: Date
}
@MainActor
class SearchViewModel: ObservableObject {

    @Published var phase: DataFetchPhase<[TrendingItem]> = .empty
    @Published var searchQuery = ""
    @Published var searchTaskToken: SearchTaskToken
    
    private let gifAPI = GifAPI.shared
    
    init(trendingItems: [TrendingItem]? = nil) {
        if let trendingItems = trendingItems {
            self.phase = .success(trendingItems)
        } else {
            self.phase = .empty
            
        }
        self.searchTaskToken = SearchTaskToken(token: Date())
    }
    
    private var trimmedSearchQuery: String {
        searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    static let shared = SearchViewModel()
    
    func searchItems() async {
        if Task.isCancelled { return }
        
        let searchQuery = trimmedSearchQuery
        phase = .empty
        
        if searchQuery.isEmpty {
            return
        }
        
        do {
            let items = try await gifAPI.search(for: searchQuery)
            if Task.isCancelled { return }
            if searchQuery != trimmedSearchQuery {
                return
            }
            phase = .success(items)
        } catch {
            if Task.isCancelled { return }
            if searchQuery != trimmedSearchQuery {
                return
            }
            phase = .failure(error)
        }
    }
    
    
}
