//
//  ItemRowView.swift
//  TrafficFactoryTestTask
//
//  Created by Ivan Magda on 29.05.2024.
//

import SwiftUI

struct ItemRowView: View {
    let item: Item
    @State private var viewModel = ItemImageViewModel()
    
    private let cornerRadius: CGFloat = 10
    private let opacity: Double = 0.5
    private let placeHolderAspectRatio: Double = 1.2
    private let placeHolderMaxWidth: CGFloat = 120
    private let progressViewScale: Double = 2.0
    private let progressStatusOffset: CGFloat = 110
    private let imageAspectRatio: Double = 1.0
    
    var body: some View {
        VStack {
            ZStack {
                Color
                    .gray
                    .opacity(opacity)
                
                if let image = viewModel.image {
                    image
                        .resizable()
                        
                } else {
                    Image(systemName: "photo.artframe")
                        .resizable()
                        .aspectRatio(placeHolderAspectRatio, contentMode: .fit)
                        .frame(maxWidth: placeHolderMaxWidth)
                    
                    VStack {
                        ProgressView()
                            .scaleEffect(progressViewScale)
                            
                        Text("Loading...")
                            .font(.title3)
                            .padding()
                    }
                    .offset(y: progressStatusOffset)
                }
            }
            .frame(maxWidth: .infinity)
            .aspectRatio(imageAspectRatio, contentMode: .fill)
            .clipShape(.rect(cornerRadius: cornerRadius))
            
            
            VStack {
                Text(item.title)
                    .font(.title)
                    .bold()
                
                Text(item.description)
                    .font(.headline)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: cornerRadius))
        }
        .task {
            viewModel.loadImage(from: item.imageURL)
            await viewModel.fetchImageAndCaches(from: item.imageURL)
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
