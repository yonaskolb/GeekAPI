//
//  BGGTests.swift
//  BGGTests
//
//  Created by Yonas Kolb on 15/1/19.
//

import XCTest
import GeekAPI

class GeekAPITests: XCTestCase {

    let api = GeekAPI()
    let gameID: ID = "169786"
    let gameName = "Scythe"

    func expectJSONResponse<T>(_ request: Request<T>, file: StaticString = #file, line: UInt = #line, validate: @escaping (T) -> Void) {
        let expectation = XCTestExpectation(description: "Make request: \(request.path)")
        api.makeRequest(request) { result in
            switch result {
            case .failure(let error):
                XCTFail("\(request.path) failed: \(error)", file: file, line: line)
            case .success(let value):
                validate(value)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 20.0)
    }

    func testGetCollections() {
        expectJSONResponse(.getCollections(id: gameID, onlyRatings: true, onlyComments: true, sort: .date, count: 10)) { collections in
            XCTAssertTrue(collections.count == 10)
        }
    }

    func testGetGame() {
        expectJSONResponse(.getGame(id: gameID)) { game in
            XCTAssertEqual(game.item.name, self.gameName)
        }
    }

    func testGetImages() {
        expectJSONResponse(.getImages(id: gameID, count: 10, tag: "BoxFront")) { images in
            XCTAssertEqual(images.images.count, 10)
        }
    }

    func testGetHotlist() {
        expectJSONResponse(.getHotlist) { items in
            XCTAssertTrue(items.count > 0)
        }
    }

    func testGetForums() {
        expectJSONResponse(.getForums(id: gameID)) { forums in
            XCTAssertTrue(forums.count > 0)
        }
    }

    func testGetVideos() {
        expectJSONResponse(.getVideos(id: gameID)) { videos in
            XCTAssertTrue(videos.count > 0)
        }
    }
}
