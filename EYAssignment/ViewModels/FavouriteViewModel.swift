//
//  FavouriteViewModel.swift
//  EYAssignment
//
//  Created by Nilesh Jaiswal on 19/08/23.
//

import Foundation
import SwiftUI

@MainActor
class FavouriteViewModel: ObservableObject {

   
    @Published private(set) var favourites: [TrendingItem] = []
    private let bookmarkStore = DataStore<[TrendingItem]>(filename: "bookmarks")
    var fileManager = LocalFileManager.instance
    static let shared = FavouriteViewModel()
    private init() {
        Task {
            await load()
        }
    }
    init(fileManager: LocalFileManager) {
        self.fileManager = fileManager
    }
    func load() async {
        favourites = await bookmarkStore.load() ?? []
    }
    
    func isBookmarked(for trendingItem: TrendingItem) -> Bool {
        favourites.first { trendingItem.id == $0.id } != nil
    }
    
    func addBookmark(for trendingItem: TrendingItem) {
        guard !isBookmarked(for: trendingItem) else {
            return
        }
        downloadfile(for: trendingItem)
        favourites.insert(trendingItem, at: 0)
        bookmarkUpdated()
    }
    func downloadfile(for trendingItem:TrendingItem) {
        fileManager.download(url: URL(string: trendingItem.images?.original?.url ?? "") ?? URL(fileURLWithPath: ""), toFile: trendingItem.id ?? "")
    }
    func removeBookmark(for trendingItem: TrendingItem) {
        guard let index = favourites.firstIndex(where: { $0.id == trendingItem.id }) else {
            return
        }
        fileManager.deleteImage(toFile: trendingItem.id ?? "")
        favourites.remove(at: index)
        bookmarkUpdated()
    }
    private func bookmarkUpdated() {
        let bookmarks = self.favourites
        Task {
            await bookmarkStore.save(bookmarks)
        }
    }
    func getImageFromeFileManager(name:String) -> Data {
        if let data = fileManager.loadImage(name: name) {
            return data
        }
        return Data()
    }
}
