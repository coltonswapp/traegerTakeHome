//
//  APODImage.swift
//  CSWAPP-APOD
//
//  Created by Colton Swapp on 5/17/23.
//

import SwiftUI

struct APODImage: View {
    var image: Image?
    var body: some View {
        image?.resizable() ?? Image(systemName: "wand.and.stars").resizable()
    }
}

struct APODImageRetriever: View {
    @StateObject var imageLoader: ImageLoader = ImageLoader()
    var url: String
    var body: some View {
        APODImage(image: Image(uiImage: imageLoader.image ?? UIImage(systemName: "wand.and.stars")!))
            .onAppear {
                self.imageLoader.load(url)
            }
    }
}
