//
//  MainListView.swift
//  CSWAPP-APOD
//
//  Created by Colton Swapp on 5/17/23.
//

import SwiftUI

struct MainListView: View {
    @ObservedObject var viewModel: APODViewModel = APODViewModel()
    @State private var showingSheet = false
    @State private var selection: Entry?
    var body: some View {
        NavigationStack {
            List(viewModel.entries, id: \.self, selection: $selection) { entry in
                    HStack(spacing: 12) {
                        APODImageRetriever(url: entry.url)
                            .frame(width: 100, height: 100)
                            .cornerRadius(8)
                        
                        VStack(alignment: .leading) {
                            Text(entry.explanation)
                                .lineLimit(2)
                            Spacer()
                            Text(entry.date)
                                .foregroundColor(.secondary)
                                
                        }.padding(.vertical)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture {
                        selection = entry
                        showingSheet = true
                    }
                }.navigationTitle("Placeholder")
            }
        .sheet(isPresented: $showingSheet) {
            EntryDetail(entry: selection ?? APODViewModel.mockEntry)
        }
        
        .onAppear {
            viewModel.fetchEntries()
        }
        
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}
