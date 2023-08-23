//
//  FavouriteListCell.swift
//  EYAssignment
//
//  Created by Admin on 22/08/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavouriteListCell: View {
    
    @EnvironmentObject var favouriteVM: FavouriteViewModel
    
    let trendingItem: TrendingItem
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ZStack(alignment: .topTrailing) {
                AnimatedImage(data:favouriteVM.getImageFromeFileManager(name: trendingItem.id ?? "") )
                    .resizable()
                    .frame(minHeight: 300, maxHeight: 300)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.3))
                    .clipped()
            Button {
                toggleBookmark(for: trendingItem)
            } label: {
                Image(systemName: favouriteVM.isBookmarked(for: trendingItem) ? "heart.fill" : "heart")
              }
            .padding(8)
            
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

struct FavouriteListCell_Previews: PreviewProvider {
    
    @StateObject static var favVM = FavouriteViewModel.shared

    static var previews: some View {
        NavigationView {
            List {
                FavouriteListCell(trendingItem: .previewData[0])
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.plain)
        }
        .environmentObject(favVM)
    }
}

