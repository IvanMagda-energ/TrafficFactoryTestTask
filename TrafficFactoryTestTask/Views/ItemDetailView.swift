//
//  ItemDetailView.swift
//  TrafficFactoryTestTask
//
//  Created by Ivan Magda on 30.05.2024.
//

import SwiftUI

struct ItemDetailView: View {
    let item: Item
    let image: Image
    var body: some View {
        VStack {
            image
                .resizable()
                .clipShape(.rect(cornerRadius: 10))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack {
                Text(item.title)
                    .font(.title)
                    .bold()
                
                Text(item.description)
                    .font(.title3)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 10))

        }
        .padding()
    }
}

#Preview {
    let item = Item(
        title: "Preview title",
        description: "Preview description",
        imageURL: ""
    )
    let image = Image("Example")
    return ItemDetailView(item: item, image: image)
}
