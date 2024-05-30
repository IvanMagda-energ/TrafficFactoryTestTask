//
//  ContentView.swift
//  TrafficFactoryTestTask
//
//  Created by Ivan Magda on 29.05.2024.
//

import SwiftUI
import os

struct ContentView: View {
    @State private var viewModel = ContentViewModel()
    
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(viewModel.items) { item in
                    ItemRowView(item: item)
                }
            }
        } detail: {
            Color.red
        }
        .overlay(alignment: .bottom) {
            if viewModel.isLoading {
                LoadingIndicatorView {
                    
                }
                .transition(.scale)
            }
        }
        .task {
            await viewModel.getAllItems()
        }
        .refreshable {
            Task {
                await viewModel.getAllItems()
            }
        }
    }
}

#Preview {
    ContentView()
}
