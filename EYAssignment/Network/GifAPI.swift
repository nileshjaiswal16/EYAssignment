//
//  GifAPI.swift
//  EYAssignment
//
//  Created by Nilesh Jaiswal on 19/08/23.
//

import Foundation

protocol ServiceProtocol {
    
    func search(for query: String) async throws -> [TrendingItem]
    func fetch() async throws -> [TrendingItem]
    func fetchTrendingGif(from url: URL) async throws -> [TrendingItem]
    func generateSearchURL(from query: String) -> URL
    func generateTrendingURL() -> URL
   
}

final class GifAPI: ServiceProtocol {
    
   // static let shared = GifAPI()
    //private init() {}
    
    private let apiKey = "6IDzHHc87gA5fUXk0jIe6afMSwpKUCam"
    private let session = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func fetch() async throws -> [TrendingItem] {
        try await fetchTrendingGif(from: generateTrendingURL())
    }
    
    func search(for query: String) async throws -> [TrendingItem] {
        try await fetchTrendingGif(from: generateSearchURL(from: query))
    }
    
    func fetchTrendingGif(from url: URL) async throws -> [TrendingItem] {
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw generateError(description: "Bad Response")
        }
        
        switch response.statusCode {
            
        case (200...299), (400...499):
            let apiResponse = try jsonDecoder.decode(TrendingModel.self, from: data)
            if apiResponse.meta?.status == 200 {
                return apiResponse.data ?? []
            } else {
                throw generateError(description: apiResponse.meta?.msg ?? "An error occured")
            }
        default:
            throw generateError(description: "A server error occured")
        }
    }
    
    private func generateError(code: Int = 1, description: String) -> Error {
        NSError(domain: "GIFAPI", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    func generateSearchURL(from query: String) -> URL {
        let percentEncodedString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        
        let url = "https://api.giphy.com/v1/gifs/search?api_key=6IDzHHc87gA5fUXk0jIe6afMSwpKUCam&q=\(percentEncodedString)&limit=10&offset=0&rating=g&lang=en&bundle=messaging_non_clips"
       
        return URL(string: url) ?? URL(fileURLWithPath: "")
    }
    
    func generateTrendingURL() -> URL {
        let url = "https://api.giphy.com/v1/gifs/trending?api_key=6IDzHHc87gA5fUXk0jIe6afMSwpKUCam&limit=10&offset=0&rating=g&bundle=messaging_non_clips"
       
        return URL(string: url) ?? URL(fileURLWithPath: "")
    }
}
