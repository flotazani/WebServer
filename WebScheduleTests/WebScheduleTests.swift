//
//  WebScheduleTests.swift
//  WebScheduleTests
//
//  Created by Andrei Konovalov on 05.01.2021.
//

import XCTest

@testable import WebSchedule

class WebScheduleTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

//    func testURLEncoding() {
//        guard let url = URL(string: "https:www.google.com/") else {
//            XCTAssertTrue(false, "Could not instantiate url")
//            return
//        }
//        var urlRequest = URLRequest(url: url)
//        let parameters: Parameters = [
//            "UserID": 1,
//            "Name": "Malcolm",
//            "Email": "malcolm@network.com",
//            "IsCool": true
//        ]
//
//        do {
//            let encoder = URLParameterEncoder()
//            try encoder.encode(urlRequest: &urlRequest, with: parameters)
//            guard let fullURL = urlRequest.url else {
//                XCTAssertTrue(false, "urlRequest url is nil.")
//                return
//            }
//
//            let expectedURL = "https:www.google.com/?Name=Malcolm&Email=malcolm%2540network.com&UserID=1&IsCool=true"
//            XCTAssertEqual(fullURL.absoluteString.sorted(), expectedURL.sorted())
//        }catch {
//
//        }
//
//
//    }
}
