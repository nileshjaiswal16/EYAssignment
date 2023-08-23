//
//  FavouriteGridCell.swift
//  EYAssignment
//
//  Created by Admin on 22/08/23.
//

import SwiftUI



import SwiftUI
import SDWebImageSwiftUI

struct FavouriteGridCell: View {
    
    @EnvironmentObject var favouriteVM: FavouriteViewModel
    let trendingItem: TrendingItem
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ZStack(alignment: .topTrailing) {
                AnimatedImage(data:favouriteVM.getImageFromeFileManager(name: trendingItem.id ?? ""))
                    .resizable()
                    .frame(width: 170, height: 170)
                    .clipped()
                    .padding(8)
                Button {
                    toggleBookmark(for: trendingItem)
                } label: {
                    Image(systemName: favouriteVM.isBookmarked(for: trendingItem) ? "heart.fill" : "heart")
                  }
                .padding(15)
            }
        }
        .padding([.horizontal, .bottom])
        
    }
    private func toggleBookmark(for article: TrendingItem) {
        if favouriteVM.isBookmarked(for: article) {
            favouriteVM.removeBookmark(for: article)
        } else {
            favouriteVM.addBookmark(for: article)
        }
    }
}

struct FavouriteGridCell_Previews: PreviewProvider {
    
    @StateObject static var favVM = FavouriteViewModel.shared
    
    static var previews: some View {
        NavigationView {
            FavouriteGridCell(trendingItem: .previewData[0])
                .environmentObject(favVM)
        }
    }
}

