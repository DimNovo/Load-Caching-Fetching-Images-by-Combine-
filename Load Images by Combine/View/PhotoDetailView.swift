//
//  PhotoDetailView.swift
//  Load Images by Combine
//
//  Created by Dmitry Novosyolov on 20/01/2020.
//  Copyright © 2020 Dmitry Novosyolov. All rights reserved.
//

import SwiftUI

struct PhotoDetailView: View {
    @ObservedObject var vm: ViewModel
    @State private var image: UIImage?
    var photo: Photo
    var body: some View {
        NavigationView {
            VStack {
                if image != nil {
                    Image(uiImage: image!)
                        .resizable()
                        .scaledToFit()
                } else {
                    Color
                        .gray
                        .edgesIgnoringSafeArea(.all)
                }
            }.onAppear {
                self.vm.fetchImage(urlString: self.photo.url) { self.image = $0 }
            }
            .blur(radius: image != nil ? 0 : 5)
            .navigationBarTitle("\(photo.title.capitalizingFirstLetter())", displayMode: .inline)
        }
        .animation(.default)
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailView(vm: ViewModel(), photo: Photo(id: 777,
                                                      albumId: 777,
                                                      title: "natus nisi omnis corporis facere molestiae rerum in",
                                                      url: "https://via.placeholder.com/600/f66b97",
                                                      thumbnailUrl: "https://via.placeholder.com/150/f66b97"))
    }
}
