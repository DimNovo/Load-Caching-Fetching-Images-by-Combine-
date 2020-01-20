//
//  ContentView.swift
//  Load Images by Combine
//
//  Created by Dmitry Novosyolov on 20/01/2020.
//  Copyright © 2020 Dmitry Novosyolov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = ViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.albums) { album in
                    HStack(alignment: .firstTextBaseline) {
                        NavigationLink(destination:
                        PhotosView(vm: self.vm, album: album)) {
                            HStack {
                                Image(systemName: "photo.fill.on.rectangle.fill")
                                    .font(.system(size: 30, weight: .light, design: .default))
                                Text(album.title.capitalizingFirstLetter())
                                    .bold()
                                    .font(.custom("Optima", size: 15))
                                    .foregroundColor(.primary)
                            }
                            
                            Spacer()
                            
                            Text("ID: \(album.id)")
                                .font(.custom("Charter Black", size: 14))
                                .italic()
                                .foregroundColor(.blue)
                        }
                    }.foregroundColor(.secondary)
                }
            }.navigationBarTitle("Albums")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
