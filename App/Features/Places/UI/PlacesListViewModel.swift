//
//  PlacesListViewModel.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 29/01/2026.
//

import MapKit
import Combine
import Foundation

final class PlacesListViewModel: ObservableObject {

    @Published private(set) var searchResults: [LocationModel] = []
    @Published private(set) var state: ViewState = .loading
    @Published private(set) var searchQuery: String = ""

    private var places: [LocationModel] = []
    private let usecase: PlacesListUsecaseProtocol
    private var cancellables = Set<AnyCancellable>()

    let config: Configuration

    init(
        usecase: PlacesListUsecaseProtocol = PlacesListUsecase(),
        configuration: Configuration = Configuration()
    ) {
        self.config = configuration
        self.usecase = usecase
    }

    @MainActor
    private func observeSearchQuery() {
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink { [weak self] query in
                guard let self else { return }
                state = .searching
                if query.isEmpty {
                    self.searchResults = self.places
                    state = .loaded
                    return
                }
                Task {
                    let mapsSearchResults = await self.fetchUserCustomLocations(query: query)
                    self.searchResults = mapsSearchResults
                    self.state = .loaded
                }
            }
            .store(in: &cancellables)
    }

    @MainActor
    private func fetchUserCustomLocations(query: String) async -> [LocationModel] {
        let request = MKLocalSearch.Request(naturalLanguageQuery: query)
        let search = MKLocalSearch(request: request)
        guard let response = try? await search.start() else {
            return []
        }
        return response.mapItems.map {
            PlacesListModel(name: $0.name ?? Constants.noName, lat: $0.placemark.coordinate.latitude, long: $0.placemark.coordinate.longitude)
        }
    }
}
