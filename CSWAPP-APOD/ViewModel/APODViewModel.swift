//
//  APODViewModel.swift
//  CSWAPP-APOD
//
//  Created by Colton Swapp on 5/17/23.
//

import SwiftUI
import Combine

class APODViewModel: ObservableObject {
    
    @Published var entries: [Entry] = []
    var cancellables: Set<AnyCancellable> = []
    
    func fetchEntries() {
        NetworkManager.fetch()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { entries in
                self.entries = entries
                print(entries)
            }
            .store(in: &cancellables)

    }
    
    // Used for Previews
    static var mockEntry: Entry = Entry(title: "Into Darkness",
                                        date: "March 10, 2023",
                                        explanation: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Scelerisque varius morbi enim nunc faucibus a. Sit amet purus gravida quis. Commodo sed egestas egestas fringilla phasellus faucibus scelerisque eleifend. Ut placerat orci nulla pellentesque dignissim enim sit amet. Laoreet sit amet cursus sit amet dictum sit amet justo.",
                                        url: "")
}
