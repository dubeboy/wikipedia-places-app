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
    private let mapsUsecase: PlacesMapKitUsecaseProtocol
    private var cancellables = Set<AnyCancellable>()
    private var searchTask: Task<Void, Never>?

    let config: Configuration

    init(
        usecase: PlacesListUsecaseProtocol = PlacesListUsecase(),
        mapsUsecase: PlacesMapKitUsecaseProtocol = PlacesMapKitUsecase(),
        configuration: Configuration = Configuration()
    ) {
        self.config = configuration
        self.usecase = usecase
        self.mapsUsecase = mapsUsecase

        observeSearchQuery()
    }

    @MainActor
    func getPlacesList() async {
        state = .loading
        do {
            places = try await usecase.getPlaces()
            state = .loaded
        } catch let error as WikipediaPlacesAppError {
            state = .error(error: error)
            shouldShowAlertError = true
        } catch {
            state = .error(error: .unknownError)
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
        mapsUsecase.openWikipediaApp(deeplinkUrl: deeplinkEndpoint)
    }


    @MainActor
    private func fetchUserCustomLocations(query: String) async -> [LocationModel] {
        do {
            return try await mapsUsecase.fetchUserCustomLocations(query: query)
        } catch {
            return places
        }
    }
}
