//
//  PhotosView.swift
//  Load Images by Combine
//
//  Created by Dmitry Novosyolov on 20/01/2020.
//  Copyright © 2020 Dmitry Novosyolov. All rights reserved.
//

import SwiftUI

struct PhotosView: View {
    @ObservedObject var vm: ViewModel
    var album: Album
    var body: some View {
        let separatedPhotos = vm.filterPhotosByAlbum(for: album).chunked(into: 2)
        return
            ScrollView(showsIndicators: false) {
                ForEach(0..<separatedPhotos.count) { index in
                    HStack {
                        ForEach(separatedPhotos[index]) { photo in
                            PhotoCellView(vm: self.vm, photo: photo)
                        }
                    }
                }
        }
    }
}

struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosView(vm: ViewModel(), album: Album(id: 777, title: "wow"))
    }
}
