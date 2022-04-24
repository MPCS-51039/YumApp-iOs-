//
//  ProduceServiceTests.swift
//  YumProduceTests
//
//  Created by Mariel Wiechers on 4/24/22.
//

import XCTest
@testable import YumProduce

class ProduceServiceTests: XCTestCase {
    var systemUnderTest: ProduceService!

    override func setUpWithError() throws {
        self.systemUnderTest = ProduceService()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        self.systemUnderTest = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPI_returnsSuccessfullResult() throws {
//        Given
        var produces: [Produce]!
        var error: Error?
        
        let promise = expectation(description: "Completion handler is invoked")
                
//        When
        self.systemUnderTest.getProduce(completion: {data, shouldntHappen in
            produces = data
            error = shouldntHappen
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
//        Then: expectations
        
    XCTAssertNotNil(produces)
    XCTAssertNil(error)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

}
