//
//  MockService.swift
//  EYAssignment
//
//  Created by Nilesh Jaiswal on 23/08/23.
//

import Foundation

class MockService: ServiceProtocol {
    func generateSearchURL(from query: String) -> URL {
        return URL(fileURLWithPath: "")
    }
    
    func generateTrendingURL() -> URL {
       return URL(fileURLWithPath: "")
    }
    
    func search(for query: String) async throws -> [TrendingItem] {
        try await fetchTrendingGif(from: generateSearchURL(from: query))
    }
    
    func fetch() async throws -> [TrendingItem] {
        try await fetchTrendingGif(from: generateTrendingURL())
    }
    
    
    func fetchTrendingGif(from url: URL) async throws -> [TrendingItem] {
        
        guard let sampleData: TrendingItem = readJSONFromFile(fileName: "SamplePost")else {
            throw generateError(description: "A server error occured")
        }
        return [sampleData]

    }
    
    private func generateError(code: Int = 1, description: String) -> Error {
        NSError(domain: "GIFAPI", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
    // Define a generic function that takes a JSON file name and returns a Codable struct
    func readJSONFromFile<T: Codable>(fileName: String) -> T? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        return nil
    }
    
}
