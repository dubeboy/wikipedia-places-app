//
//  PlacesListUsecaseTests.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 30/01/2026.
//

import XCTest
import Foundation
@testable import Wikipedia_Places_App

final class PlacesListUsecaseTests: XCTestCase {
    private var sut: PlacesListUsecase!
    private var client: StubPlacesClient!

    override func setUp() {
        super.setUp()
        client = StubPlacesClient()
        sut = PlacesListUsecase(client: client)
    }

    func testGetPlaces_failure() async throws {
        do {
            _ = try await sut.getPlaces()
            XCTFail("Should not execute this, as it should throw")
        } catch {
            XCTAssertEqual(error as? WikipediaPlacesAppError, WikipediaPlacesAppError.unknownError)
        }
    }

    func testGetPlaces_success() async throws {
        client.getPlacesServerResult = .success(.extepectedResponse)
        let results = try await sut.getPlaces()
        XCTAssertEqual(results.count, 4)
        XCTAssertEqual(results.first?.name, "Amsterdam")
        XCTAssertEqual(results.first?.lat, 52.3547498)
        XCTAssertEqual(results.first?.long, 4.8339215)
        XCTAssertEqual(results.last?.name, "")
    }
}
