//
//  CategoryVCOutletTestFile.swift
//  CaseStudy2Tests
//
//  Created by Capgemini-DA204 on 9/27/22.
//

import XCTest
@testable import CaseStudy2

class CategoryVCOutletTestFile: XCTestCase {

    var catTableVC: CategoryViewController!
    var catTableCell: CategoryTabelViewCell!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        catTableVC = storyboard.instantiateViewController(withIdentifier: "CategoryViewController") as? CategoryViewController
        catTableVC.loadView()
    }
    
    func testLabelOutlet() {
        catTableCell = catTableVC.categoryTableView.dequeueReusableCell(withIdentifier: "CategoryTabelViewCell") as? CategoryTabelViewCell
        XCTAssertNotNil(catTableVC.categoryTableView, "category Table view is not connected")
        XCTAssertNotNil(catTableCell.categoryLabel, "Category Label is not connected")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
