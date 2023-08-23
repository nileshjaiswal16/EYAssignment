//
//  EYAssignmentTests.swift
//  EYAssignmentTests
//
//  Created by Nilesh Jaiswal on 19/08/23.
//

import XCTest
@testable import EYAssignment


final class EYAssignmentTests: XCTestCase {
    
    func testTrendingItems() async {
        
        var viewModel = await HomeViewModel( gifAPI: MockService())
        
        await viewModel.fetchTrendingItems()
        let loading = await viewModel.isLoading
        let phase = await viewModel.phase
        
        switch phase {
        case .empty:
            XCTAssertFalse(loading, "isLoading should be false")
        case .success(let trendingItem):
            XCTAssertTrue(!trendingItem.isEmpty, "Items should not be empty")
        default: break
        }
        
        
    }
    
}
