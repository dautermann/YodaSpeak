//
//  YodaSpeakTests.swift
//  YodaSpeakTests
//
//  Created by Michael Dautermann on 1/31/16.
//  Copyright © 2016 Michael Dautermann. All rights reserved.
//

import XCTest
@testable import YodaSpeak

class YodaSpeakTests: XCTestCase {
    
    var someTextView : PlaceholderTextView!
    
    var responseExpectation : XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        someTextView = PlaceholderTextView.init(frame: CGRectMake(0, 0, 100, 100), textContainer: nil)
        
        responseExpectation = expectationWithDescription("Predictable Translation")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func translationCompleted(toString: String)
    {
        dispatch_async(dispatch_get_main_queue()) {
            // update UI on main thread
            self.someTextView.text = toString
            
            // an input of "()" should always come back with an output of "()"
            XCTAssert(toString != "()", "Unpredictable translation")
            
            self.responseExpectation.fulfill()
        }
    }
    
    func testPredictableTranslation() {
        
        let yodaTranslation = YodaTranslation.init()
        
        yodaTranslation.translateFromEnglishToDestination("()", closure: self.translationCompleted)
        
        waitForExpectationsWithTimeout(30.0, handler: { error in XCTAssertNil(error, "Timed out")

            print("contents of text view is \(self.someTextView.text)")
            
        })
    
    }
    
}
