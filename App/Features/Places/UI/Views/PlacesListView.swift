//
//  PlacesListView.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 29/01/2026.
//

import SwiftUI

struct PlacesListView: View {
    @StateObject var viewModel: PlacesListViewModel = .init()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.searchResults) { place in
                    PlacesItemView(location: place) {
                        viewModel.didTapLocationItem(place)
                    }
                }
            }
            .navigationTitle(viewModel.config.strings.title)
            .searchable(text: $viewModel.searchQuery,
                placement: .automatic,
                prompt: viewModel.config.strings.searchBarPrompt
            )
            .textInputAutocapitalization(.never)
            .overlay {
                if case .loading = viewModel.state {
                    ProgressView()
                }
            }
            .alert(viewModel.config.strings.alertTitle, isPresented: $viewModel.shouldShowAlertError) {
                Button(viewModel.config.strings.alertButtonTitle, role: .cancel) {

                }
            } message: {
                if case .error(let error) = viewModel.state {
                    Text(error.localizedDescription)
                }
            }

        }
        .task {
            await viewModel.getPlacesList()
        }
        .animation(.default, value: viewModel.state)
    }
}
