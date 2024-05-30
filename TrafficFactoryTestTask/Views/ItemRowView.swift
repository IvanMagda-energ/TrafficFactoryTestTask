//
//  ItemRowView.swift
//  TrafficFactoryTestTask
//
//  Created by Ivan Magda on 29.05.2024.
//

import SwiftUI

struct ItemRowView: View {
    let item: Item
    @State private var imageLoader = ItemImageViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                Color
                    .gray
                    .opacity(0.5)
                
                if let image = imageLoader.image {
                    image
                        .resizable()
                        
                } else {
                    Image(systemName: "photo.artframe")
                        .resizable()
                        .aspectRatio(1.2, contentMode: .fit)
                        .frame(maxWidth: 120)
                    
                    VStack {
                        ProgressView()
                            .scaleEffect(2.0)
                            
                        Text("Loading...")
                            .font(.title3)
                            .padding()
                    }
                    .offset(y: 110)
                }
            }
            .frame(maxWidth: .infinity)
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
        .task {
            await imageLoader.loadAndCacheImage(from: item.imageURL)
            try? await Task.sleep(for: .seconds(2))
            imageLoader.getImage(for: item.imageURL)
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
