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
    @Published var shouldShowAlertError: Bool = false
    @Published var searchQuery: String = ""

    private var places: [LocationModel] = [] {
        didSet {
            searchResults = places
        }
    }
    private let usecase: PlacesListUsecaseProtocol
    private var cancellables = Set<AnyCancellable>()
    private var searchTask: Task<Void, Never>?

    let config: Configuration

    init(
        usecase: PlacesListUsecaseProtocol = PlacesListUsecase(),
        configuration: Configuration = Configuration()
    ) {
        self.config = configuration
        self.usecase = usecase

        observeSearchQuery()
    }

    @MainActor
    func getPlacesList() async {
        state = .loading
        do {
            places = try await usecase.getPlaces()
            state = .loaded
        } catch {
            state = .error(error: WikipediaPlacesAppError.unknownError)
            shouldShowAlertError = true
        }
    }

    @MainActor
    private func observeSearchQuery() {
        $searchQuery
            .debounce(
                for: .milliseconds(config.constants.debounceMs),
                scheduler: DispatchQueue.main
            )
            .sink { [weak self] query in
                guard let self else { return }
                self.searchTask?.cancel()
                searchTask = Task { @MainActor in
                    guard !query.isEmpty else {
                        self.searchResults = self.places
                        self.state = .loaded
                        return
                    }
                    self.state = .searching
                    self.searchResults = await self.fetchUserCustomLocations(query: query)
                    self.state = .loaded
                }
            }
            .store(in: &cancellables)
    }

    @MainActor
    func didTapLocationItem(_ place: LocationModel) {
        let deeplinkEndpoint = WikipediaEndpoint.openWikipediaAppPlaceDetailsDeeplink(place: place)
        guard let deeplink = try? deeplinkEndpoint.createURLRequest().url else {
            return
        }

        UIApplication.shared.open(deeplink, options: [:], completionHandler: nil)
    }


    @MainActor
    private func fetchUserCustomLocations(query: String) async -> [LocationModel] {
        let request = MKLocalSearch.Request(naturalLanguageQuery: query)
        let search = MKLocalSearch(request: request)
        guard let response = try? await search.start() else {
            return []
        }
        return response.mapItems.map(LocationModel.init(from:))
    }
}
