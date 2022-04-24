//
//  ProduceTest.swift
//  YumProduceTests
//
//  Created by Mariel Wiechers on 4/24/22.
//

import XCTest
//import our app tareget to access classes sin our app from our test
@testable import YumProduce

class ProduceTest: XCTestCase {

    func testProduceDebugDescription() throws {
        
        let subjectUnderTest = Produce(
            named:"Pumpkin",
            description: "Store outside",
            imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1FFO2MrZfZR9JvFeX4v8OkKF4bNEE9mXPCg&usqp=CAU",
            season: "Fall"
        )

        let actualValue = subjectUnderTest.debugDescription
        
        let expectedValue = "Produce(name: Pumpkin, description: Store outside)"
        XCTAssertEqual(actualValue, expectedValue)
    }


}
