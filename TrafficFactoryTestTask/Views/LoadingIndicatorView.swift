//
//  LoadingIndicatorView.swift
//  TrafficFactoryTestTask
//
//  Created by Ivan Magda on 29.05.2024.
//

import SwiftUI

struct LoadingIndicatorView: View {
    
    private let textPadding: CGFloat = 8
    private let cornerRadius: CGFloat = 10
    let cancelAction: () -> Void
    
    var body: some View {
        HStack {
            ProgressView()
                .padding()

            Text("Please wait while data is loading")
                .multilineTextAlignment(.center)
                .font(.footnote)
                .foregroundStyle(Color.secondary)
                .padding(.vertical, textPadding)
            
            Button {
                cancelAction()
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(Color.secondary)
            }
            .padding()
        }
        .background(Material.regular)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .padding()
    }
}

#Preview {
    LoadingIndicatorView {}
}
