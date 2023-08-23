//
//  TrendingModel.swift
//  EYAssignment
//
//  Created by Nilesh Jaiswal on 19/08/23.
//

import Foundation

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()
// MARK: - TrendingGIF
struct TrendingModel: Codable {
    let data: [TrendingItem]?
    let pagination: Pagination?
    let meta: Meta?
}

// MARK: - Analytics
struct Analytics: Codable {
    let onload, onclick, onsent: Onclick?
}

// MARK: - Onclick
struct Onclick: Codable {
    let url: String?
}

// MARK: - User
struct User: Codable {
    let avatarURL: String?
    let bannerImage, bannerURL: String?
    let profileURL: String?
    let username, displayName, description: String?
    let instagramURL: String?
    let websiteURL: String?
    let isVerified: Bool?
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case bannerImage = "banner_image"
        case bannerURL = "banner_url"
        case profileURL = "profile_url"
        case username
        case displayName = "display_name"
        case description
        case instagramURL = "instagram_url"
        case websiteURL = "website_url"
        case isVerified = "is_verified"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let status: Int?
    let msg, responseID: String?
    
    enum CodingKeys: String, CodingKey {
        case status, msg
        case responseID = "response_id"
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    let totalCount, count, offset: Int?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case count, offset
    }
}


struct TrendingItem {
    
    let type, id: String?
    let url: String?
    let images: Images?
    
    enum CodingKeys: String, CodingKey {
        case type, id
        case url
        case images
    }
}
struct Images {
    let original: FixedHeight?
    
    enum CodingKeys: String, CodingKey {
        case original
        
    }
}
struct FixedHeight: Codable {
    let url: String?
    enum CodingKeys: String, CodingKey {
        case url
        
    }
}
extension Images: Codable {}
extension Images: Equatable {}
extension FixedHeight: Equatable {}
extension TrendingItem: Codable {}
extension TrendingItem: Equatable {}
extension TrendingItem: Identifiable {}

extension TrendingItem {
    
    static var previewData: [TrendingItem] {
        let previewDataURL = Bundle.main.url(forResource: "samplePost", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        let apiResponse = try! jsonDecoder.decode(TrendingModel.self, from: data)
        return apiResponse.data ?? []
    }
    
}


struct Source {
    let name: String
}

extension Source: Codable {}
extension Source: Equatable {}


