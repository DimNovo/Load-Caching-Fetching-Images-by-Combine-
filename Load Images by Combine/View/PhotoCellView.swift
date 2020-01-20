//
//  PhotoCellView.swift
//  Load Images by Combine
//
//  Created by Dmitry Novosyolov on 20/01/2020.
//  Copyright © 2020 Dmitry Novosyolov. All rights reserved.
//

import SwiftUI

struct PhotoCellView: View {
    @ObservedObject var vm: ViewModel
    @State private var image: UIImage?
    @State private var isDetailPresented = false
    let DEVICE_SIZE = UIScreen.main.bounds
    var photo: Photo
    var body: some View {
        ZStack {
            if image != nil {
                Button(action: {
                    self.isDetailPresented.toggle()
                }) { Image(uiImage: image!)
                    .resizable()
                    .frame(width: DEVICE_SIZE.width / 2.25, height: DEVICE_SIZE.height / 4.5)
                    .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.secondary)
                    .frame(width: DEVICE_SIZE.width / 2.25, height: DEVICE_SIZE.height / 4.5)
            }
            Text("ID: \(photo.id)")
                .font(.title)
                .bold()
                .foregroundColor(image != nil ? .gray : .black)
                .shadow(color: .primary, radius: 1, x: 0, y: 1)
                .opacity(image != nil ? 0.75 : 1.0)
                .blur(radius: image != nil ? 0 : 5)
                .offset(y: image != nil ? -30 : 0)
        }
        .onAppear {
            self.vm.fetchImage(urlString: self.photo.thumbnailUrl) { self.image = $0 }
        }
        .sheet(isPresented: $isDetailPresented)
        { PhotoDetailView(vm: self.vm, photo: self.photo)}
    }
}

struct PhotoCellView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCellView(vm: ViewModel(),
                      photo: Photo(id: 777,
                                   albumId: 777,
                                   title: "natus nisi omnis corporis facere molestiae rerum in",
                                   url: "https://via.placeholder.com/600/f66b97",
                                   thumbnailUrl: "https://via.placeholder.com/150/f66b97"))
    }
}
