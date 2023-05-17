//
//  ImageLoader.swift
//  CSWAPP-APOD
//
//  Created by Colton Swapp on 5/17/23.
//

import Combine
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?

    deinit {
        cancel()
    }
    
    func load(_ url: String) {
        if let image = NetworkManager.cache.object(forKey: NSString(string: url)) {
            self.image = image
            return
        } else {
            cancellable = NetworkManager.fetchImage(url: url)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    print(completion)
                } receiveValue: { image in
                    NetworkManager.cache.setObject(image, forKey: NSString(string: url))
                    self.image = image
                }
        }
    }

    func cancel() {
        cancellable?.cancel()
    }
}
