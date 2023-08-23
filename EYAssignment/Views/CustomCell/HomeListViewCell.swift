//
//  HomeListViewCell.swift
//  EYAssignment
//
//  Created by Admin on 19/08/23.
//

import SwiftUI
import SDWebImageSwiftUI


struct HomeListViewCell: View {
    
    @EnvironmentObject var favouriteVM: FavouriteViewModel
    
    let trendingItem: TrendingItem
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            ZStack(alignment: .topTrailing) {
                LazyReleaseableWebImage {
                    WebImage(url: URL(string: trendingItem.images?.original?.url ?? ""))
                        .resizable()
                } placeholder: {
                    
                }
                .scaledToFit()
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

struct HomeListViewCell_Previews: PreviewProvider {
    
    @StateObject static var favouriteVM = FavouriteViewModel.shared
    
    static var previews: some View {
        NavigationView {
            List {
                HomeListViewCell(trendingItem: .previewData[0])
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.plain)
        }
        .environmentObject(favouriteVM)
    }
}
