//
//  FavouriteGridView.swift
//  EYAssignment
//
//  Created by Nilesh Jaiswal on 19/08/23.
//

import SwiftUI

struct FavouriteGridView: View {
    let trendingItem: [TrendingItem]
    @State var mode = 0
    
    var body: some View {
        let columns = [
                GridItem(.adaptive(minimum: 160))
            ]
        ScrollView {
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(trendingItem) { items in
                FavouriteGridCell(trendingItem: items)
                    
                }
                
            }
        }
    }
}

struct FavouriteGridView_Previews: PreviewProvider {
    @StateObject static var favVM = FavouriteViewModel.shared
    static var previews: some View {
        FavouriteGridView(trendingItem: TrendingItem.previewData)
            .environmentObject(favVM)
    }
}
