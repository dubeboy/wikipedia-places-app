//
//  PlacesClientTests.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 30/01/2026.
//

import XCTest
import Foundation
@testable import Wikipedia_Places_App

final class PlacesClientTests: XCTestCase {
    private var sut: PlacesClientProtocol!
    private var networkManager: StubRequestManager!

    override func setUp() {
        super.setUp()
        networkManager = StubRequestManager()
        sut = PlacesClient(manager: networkManager)
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
        networkManager.result = .extepectedResponse
        let results = try await sut.getPlaces()
        XCTAssertEqual(results.locations.count, 4)
        XCTAssertEqual(results.locations.first?.name, "Amsterdam")
        XCTAssertEqual(results.locations.first?.lat, 52.3547498)
        XCTAssertEqual(results.locations.first?.long, 4.8339215)
        XCTAssertEqual(results.locations.last?.name, nil)
    }
}
