//
//  ProductVCOutletTestFile.swift
//  CaseStudy2Tests
//
//  Created by Capgemini-DA204 on 9/27/22.
//

import XCTest
@testable import CaseStudy2

class ProductVCOutletTestFile: XCTestCase {
    
    var proTableVC: CategoryCellSelectViewController!
    var proTableCell: ProductTableViewCell!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        proTableVC = storyboard.instantiateViewController(withIdentifier: "CategoryCellSelectViewController") as? CategoryCellSelectViewController
        proTableVC.loadView()
        proTableCell = proTableVC.productTableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as? ProductTableViewCell
    }

    func testProductOutlet() throws {
        XCTAssertNotNil(proTableVC.productTableView, "Table view is not connected")
        XCTAssertNotNil(proTableCell.productNameLabel, "Name label is not connected")
        XCTAssertNotNil(proTableCell.productPriceLabel, "Price label is not connected")
        XCTAssertNotNil(proTableCell.productDescription, "Description label is not connected")
        XCTAssertNotNil(proTableCell.productImageView, "Product Image view is not connected")
       
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
