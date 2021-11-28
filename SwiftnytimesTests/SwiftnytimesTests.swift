//
//  SwiftnytimesTests.swift
//  SwiftnytimesTests
//
//  Created by prabu.karuppaiah on 26/11/21.
//

import XCTest
@testable import Swiftnytimes

class SwiftnytimesTests: XCTestCase {

    func testAllWordsLoaded() {
        let view = ViewController()
        view.getNYTimesdata()
        XCTAssertNotNil(view.newsDataArray, "NewsData is Nil")
        XCTAssertEqual(view.newsDataArray.count, 0, "NewsData no zero count")

    }

}
