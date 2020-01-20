//
//  NetService.swift
//  Load Images by Combine
//
//  Created by Dmitry Novosyolov on 20/01/2020.
//  Copyright © 2020 Dmitry Novosyolov. All rights reserved.
//

import UIKit.UIImage
import Combine

final class NetService {
    
    private let imageCache = NSCache<NSString, UIImage>()
    private enum UrlType: String {
        case albumsURL = "https://jsonplaceholder.typicode.com/albums"
        case photosURL = "https://jsonplaceholder.typicode.com/photos"
    }
    
    func loadZip() -> AnyPublisher<([Album], [Photo]), Error> {
        let albumsPublisher = urlSession(for: [Album].self, with: URL(string: UrlType.albumsURL.rawValue)!)
        let photosPublisher = urlSession(for: [Photo].self, with: URL(string: UrlType.photosURL.rawValue)!)
        return
            Publishers
                .Zip(albumsPublisher, photosPublisher)
                .eraseToAnyPublisher()
    }
    
    func loadImage(from urlString: String) -> AnyPublisher<UIImage?, Never> {
        guard
            imageCache
                .object(forKey: urlString as NSString) == nil else {
                    return
                        Just(imageCache.object(forKey: urlString as NSString))
                            .eraseToAnyPublisher()
        }
        guard
            let url = URL(string: urlString) else { fatalError("Invalid URL!")}
        return
            URLSession
                .shared
                .dataTaskPublisher(for: url)
                .map { UIImage(data: $0.data)}
                .catch { _ in Just(nil)}
                .map { [unowned self] in
                    guard $0 != nil else { return nil }
                    self.imageCache.setObject($0!, forKey: urlString as NSString)
                    return $0
            }
            .subscribe(on: RunLoop.current)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}

extension NetService {
    private func urlSession<T: Codable>(for type: T.Type, with url: URL) -> AnyPublisher<T, Error> {
        URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: type.self, decoder: JSONDecoder())
            .subscribe(on: RunLoop.current)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
