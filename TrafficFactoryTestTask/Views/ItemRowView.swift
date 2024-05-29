//
//  ItemRowView.swift
//  TrafficFactoryTestTask
//
//  Created by Ivan Magda on 29.05.2024.
//

import SwiftUI

struct ItemRowView: View {
    let item: Item
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: item.imageURL)) { image in
                    image
                        .resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .background(Color.gray)
                .aspectRatio(1.0, contentMode: .fill)
                .clipShape(.rect(cornerRadius: 16))
            VStack {
                Text(item.title)
                    .font(.title)
                
                Text(item.description)
                    .font(.caption2)
            }
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 16))
        }
    }
}

#Preview {
    let item = Item(
        title: "Wow",
        description: "It's a perfect day",
        imageURL: "https://496.ams3.cdn.digitaloceanspaces.com/img/1.jpg"
    )
    return ItemRowView(item: item)
}
