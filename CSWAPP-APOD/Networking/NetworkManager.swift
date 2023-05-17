//
//  NetworkManager.swift
//  CSWAPP-APOD
//
//  Created by Colton Swapp on 5/17/23.
//

import Combine
import Foundation
import UIKit.UIImage

class NetworkManager {
    
    static let baseURL: String = "https://api.nasa.gov/planetary/apod"
    static let apiKeyKey: String = "api_key"
    static let apiKeyActual: String = "ceGhnhjBQjTbQv8v0OPAghl96Q91uDlF0njKzCcs"
    static let startDateKey: String = "start_date"
    static let endDateKey: String = "end_date"
    
    static let cache = NSCache<NSString, UIImage>()
    
    static func fetch() -> AnyPublisher<[Entry], Error> {
        guard var url = URL(string: NetworkManager.baseURL) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        let dateRange = getStartEndDates()
        
        let apiQueryItem: URLQueryItem = URLQueryItem(name: NetworkManager.apiKeyKey, value: NetworkManager.apiKeyActual)
        let startQueryItem: URLQueryItem = URLQueryItem(name: NetworkManager.startDateKey, value: dateRange.1)
        let endQueryItem: URLQueryItem = URLQueryItem(name: NetworkManager.endDateKey, value: dateRange.0)
        url.append(queryItems: [apiQueryItem, startQueryItem, endQueryItem])
        
        print(url)
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Entry].self, decoder: JSONDecoder())
            .mapError { error in
                return NetworkError.invalidData(error: error)
            }
            
            .eraseToAnyPublisher()
        
    }
    
    static func fetchImage(url: String) -> AnyPublisher<UIImage, Error> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .map { (UIImage(data: $0.data) ?? UIImage(systemName: "globe"))! }
            .mapError({ error in
                return NetworkError.invalidData(error: error)
            })
            .eraseToAnyPublisher()
    }
    
    static func getStartEndDates() -> (String, String) {
        let today = Date()
        let cal = NSCalendar.current
        var start = cal.startOfDay(for: today)
        var end = cal.date(byAdding: .day, value: -7, to: start)!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return (formatter.string(from: start), formatter.string(from: end))
    }
    
}

enum NetworkError: Error {
    case invalidURL
    case invalidData(error: Error)
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidData(let error):
            return "The data was invalid or unable to be decoded, \(error.localizedDescription)"
        }
    }
}
