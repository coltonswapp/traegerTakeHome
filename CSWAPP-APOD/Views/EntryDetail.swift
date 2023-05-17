//
//  EntryDetail.swift
//  CSWAPP-APOD
//
//  Created by Colton Swapp on 5/17/23.
//

import SwiftUI

struct EntryDetail: View {
    @Environment(\.dismiss) var dismiss
    var entry: Entry
    
    var body: some View {
        ScrollView {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        .tint(.primary)
                }
            }.padding()
            
            VStack(alignment: .center, spacing: 24) {
                APODImageRetriever(url: entry.url)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width - 20)
                    .cornerRadius(8)
                
                VStack {
                    Text(entry.title)
                        .bold()
                        .font(.title3)
                    Text(entry.copyright ?? "")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Text(entry.explanation)
                Text(entry.date)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct EntryDetail_Previews: PreviewProvider {
    static var previews: some View {
        EntryDetail(entry: APODViewModel.mockEntry)
    }
}
