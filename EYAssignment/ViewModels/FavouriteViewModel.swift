//
//  FavouriteViewModel.swift
//  EYAssignment
//
//  Created by Admin on 19/08/23.
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
    
    func isBookmarked(for article: TrendingItem) -> Bool {
        favourites.first { article.id == $0.id } != nil
    }
    
    func addBookmark(for article: TrendingItem) {
        guard !isBookmarked(for: article) else {
            return
        }
        downloadfile(for: article)
        favourites.insert(article, at: 0)
        bookmarkUpdated()
    }
    func downloadfile(for article:TrendingItem) {
        fileManager.download(url: URL(string: article.images?.original?.url ?? "") ?? URL(fileURLWithPath: ""), toFile: article.id ?? "")
    }
    func removeBookmark(for article: TrendingItem) {
        guard let index = favourites.firstIndex(where: { $0.id == article.id }) else {
            return
        }
        fileManager.deleteImage(toFile: article.id ?? "")
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
