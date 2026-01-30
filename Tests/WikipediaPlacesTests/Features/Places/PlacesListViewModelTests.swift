//
//  PlacesListViewModelTests.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 30/01/2026.
//

import XCTest
import Combine
@testable import Wikipedia_Places_App

@MainActor
final class PlacesListViewModelTests: XCTestCase {
    private var sut: PlacesListViewModel!
    private var usecase: StubPlacesListUsecase!
    private var mapsService: StubPlacesMapsKitService!
    private var configuration: PlacesListViewModel.Configuration!
    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        usecase = StubPlacesListUsecase()
        configuration = PlacesListViewModel.Configuration()
        mapsService = StubPlacesMapsKitService()
        mapsService.getPlacesResult = .success(.extepectedResponse)
        sut = PlacesListViewModel(usecase: usecase,
                                  mapsService: mapsService,
                                  configuration: configuration)
    }

    func testGetPlaces_failure() async throws {
        await sut.getPlacesList()
        XCTAssertEqual(sut.state, .error(error: WikipediaPlacesAppError.unknownError))
    }

    func testGetPlaces_success() async throws {
        usecase.getPlacesResult = .success(.extepectedResponse)
        await sut.getPlacesList()
        XCTAssertEqual(sut.state, .loaded)
        XCTAssertEqual(sut.searchResults.count, 4)
    }

    func testSearch_When_searchQuery_Then_shouldFilter() async throws {
        let expectation = expectation(description: "Wait for debounce")

        mapsService.getPlacesResult = .success(.extepectedResponse.filter { location in
            location.name.contains("Amsterdam")
        })
        sut.$state
            .sink { state in
            if case .loaded = state {
                expectation.fulfill()
            }
        }
        .store(in: &cancellables)

        sut.searchQuery = "ams"

        await fulfillment(of: [expectation], timeout: 1.0)
        XCTAssertEqual(sut.state, .loaded)
        XCTAssertEqual(sut.searchResults.count, 1)
    }

    func testOpenWikipediaApp_When_clickOnLocation_Then_shouldOpenOfficialWikipediaApp() {
        sut.didTapLocationItem(Array.extepectedResponse.first!)
        XCTAssertEqual(mapsService.timesOpenWikipedia, 1)
        XCTAssertEqual(
            try? mapsService.deeplinkUrl?.createURLRequest().url,
            try? PlacesListViewModel.WikipediaEndpoint
                    .openWikipediaAppPlaceDetailsDeeplink(
                        place: Array.extepectedResponse.first!
                    ).createURLRequest().url
        )
    }
}
