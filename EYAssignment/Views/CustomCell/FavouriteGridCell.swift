//
//  FavouriteGridCell.swift
//  EYAssignment
//
//  Created by Nilesh Jaiswal on 22/08/23.
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
    private func toggleBookmark(for trendingItem: TrendingItem) {
        if favouriteVM.isBookmarked(for: trendingItem) {
            favouriteVM.removeBookmark(for: trendingItem)
        } else {
            favouriteVM.addBookmark(for: trendingItem)
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

