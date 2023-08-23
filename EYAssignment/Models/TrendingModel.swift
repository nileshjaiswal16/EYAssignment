//
//  TrendingModel.swift
//  EYAssignment
//
//  Created by Admin on 19/08/23.
//

import Foundation

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()
// MARK: - TrendingGIF
struct TrendingModel: Codable {
    let data: [TrendingItem]?
    let pagination: Pagination?
    let meta: Meta?
}
/*
// MARK: - Datum
struct Datum: Codable {
    let type, id: String?
    let url: String?
    let slug: String?
    let bitlyGIFURL, bitlyURL, embedURL: String?
    let username: String?
    let source: String?
    let title, rating, contentURL, sourceTLD: String?
    let sourcePostURL: String?
    let isSticker: Int?
    let importDatetime, trendingDatetime: String?
    let images: Images?
    let user: User?
    let analyticsResponsePayload: String?
    let analytics: Analytics?

    enum CodingKeys: String, CodingKey {
        case type, id, url, slug
        case bitlyGIFURL = "bitly_gif_url"
        case bitlyURL = "bitly_url"
        case embedURL = "embed_url"
        case username, source, title, rating
        case contentURL = "content_url"
        case sourceTLD = "source_tld"
        case sourcePostURL = "source_post_url"
        case isSticker = "is_sticker"
        case importDatetime = "import_datetime"
        case trendingDatetime = "trending_datetime"
        case images, user
        case analyticsResponsePayload = "analytics_response_payload"
        case analytics
    }
}
*/
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
        let previewDataURL = Bundle.main.url(forResource: "news", withExtension: "json")!
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


