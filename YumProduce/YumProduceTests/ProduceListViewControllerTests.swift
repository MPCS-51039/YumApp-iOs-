//
//  ProduceListViewControllerTests.swift
//  YumProduceTests
//
//  Created by Mariel Wiechers on 4/24/22.
//

import XCTest
@testable import YumProduce

class ProduceListViewControllerTests: XCTestCase {
    var systemUnderTest: ProduceListViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main) //storyborad object - we know from storyboard our initial view controlle ris navigation controller - we casst as tnat
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        self.systemUnderTest = navigationController.topViewController as? ProduceListViewController //ProdListView is SUT
        //need to: havent launched app yet and caused view controller to aappear / trigger view to get setup
        
        //get the window that we want
        UIApplication.shared.windows
            .filter { $0.isKeyWindow}
            .first!
            .rootViewController = self.systemUnderTest
        
        XCTAssertNotNil(navigationController.view) //reference it and ensure it is there
        XCTAssertNotNil(self.systemUnderTest.view)
        
    }
    
    func testTableView_loadsProduces() {
//        Given
        let mockProduceService = MockProduceService()
        let mockProduces = [
            Produce(named: "Artichoke", description: "Makes water taste better", imageUrl: "produce.com/artichokefill", season: "Fall"),
            Produce(named: "Peas", description: "More than one", imageUrl: "produce.com/peasfill", season: "Never"),
            Produce(named: "Orange", description: "It is a fruit", imageUrl: "produce.com/orangefill", season: "winter" )
        ]
        mockProduceService.mockProduces = mockProduces
        
        self.systemUnderTest.viewDidLoad()
        self.systemUnderTest.produceService = mockProduceService
        
        XCTAssertEqual(0, self.systemUnderTest.tableView.numberOfRows(inSection: 0))
//        When
        self.systemUnderTest.viewWillAppear(false)
        
//        Then
        XCTAssertEqual(mockProduces.count, self.systemUnderTest.market.count)
        XCTAssertEqual(mockProduces.count, self.systemUnderTest.tableView.numberOfRows(inSection: 0))
    }
    
    class MockProduceService: ProduceService {
// override methods from BirdService here -not make http call just completion handler (what passed into my by caller)
        var mockProduces: [Produce]?
        var mockError: Error?
        
        override func getProduce(completion: @escaping ([Produce]?, Error?) -> ()) {
            completion(mockProduces, mockError)
        }
    }
}

