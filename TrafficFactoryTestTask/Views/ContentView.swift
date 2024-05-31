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
    @State private var columnVisibility = NavigationSplitViewVisibility.doubleColumn
    @State private var selectedItem: Item?
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(viewModel.items, selection: $selectedItem) { item in
                NavigationLink(value: item) {
                    ItemRowView(item: item)
                }
            }
            .navigationTitle("Items")
        } detail: {
            if let selectedItem = selectedItem, let image = Cache.shared.getObject(for: selectedItem.imageURL) {
                ItemDetailView(item: selectedItem, image: image)
                    .navigationTitle("Item detail")
            }
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
        .alert(isPresented: $viewModel.hasError, error: viewModel.error) { error in
            Button("Ok", role: .cancel) {
                viewModel.error = nil
                viewModel.hasError = false
            }
            
            Button("Try again") {
                Task {
                    await viewModel.getAllItems()
                }
            }
        } message: { error in
            if let failureReason = error.failureReason {
                Text(failureReason)
            } else {
                Text("Unknown error")
            }
        }
    }
}

#Preview {
    ContentView()
}
