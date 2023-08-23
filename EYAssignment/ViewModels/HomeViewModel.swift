//
//  HomeViewModel.swift
//  EYAssignment
//
//  Created by Admin on 19/08/23.
//

import Foundation

enum DataFetchPhase<T> {
    
    case empty
    case success(T)
    case failure(Error)
}
struct FetchTaskToken: Equatable {
    var token: Date
}


@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var phase = DataFetchPhase<[TrendingItem]>.empty
    @Published var fetchTaskToken: FetchTaskToken
    private let gifAPI = GifAPI.shared
    
    init(trendingItems: [TrendingItem]? = nil) {
        if let trendingItems = trendingItems {
            self.phase = .success(trendingItems)
        } else {
            self.phase = .empty
        }
        self.fetchTaskToken = FetchTaskToken(token: Date())
       
    }
    func fetchTrendingItems() async {
        if Task.isCancelled { return }
        phase = .empty
        do {
            let trendingItems = try await gifAPI.fetch()
            if Task.isCancelled { return }
            phase = .success(trendingItems)
        } catch {
            if Task.isCancelled { return }
            print(error.localizedDescription)
            phase = .failure(error)
        }
    }
}
