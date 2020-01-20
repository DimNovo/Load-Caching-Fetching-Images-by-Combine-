//
//  ViewModel.swift
//  Load Images by Combine
//
//  Created by Dmitry Novosyolov on 20/01/2020.
//  Copyright © 2020 Dmitry Novosyolov. All rights reserved.
//

import UIKit.UIImage
import Combine

final class ViewModel: ObservableObject {
    
    private lazy var netService = NetService()
    private var cancellable: AnyCancellable?
    
    @Published var albums = [Album]()
    @Published var photos = [Photo]()
    
    init() {
        cancellable =
            netService
                .loadZip()
                .catch { _ in Just((self.albums, self.photos))}
                .sink {
                    self.albums = $0.0
                    self.photos = $0.1
        }
    }
    
    func fetchImage(urlString: String, completion: ((UIImage) -> Void)? = nil) {
        cancellable =
            netService
                .loadImage(from: urlString)
                .catch { _ in Just(nil)}
                .sink { if let image = $0 { completion!(image)}}
    }
}

extension ViewModel {
    func filterPhotosByAlbum(for album: Album) -> [Photo]  {
        photos
            .lazy
            .filter { $0.albumId == album.id }
    }
}
