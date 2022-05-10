//
//  DateFormatTests.swift
//  SmartBuildingTests
//
//  Created by Ammar Khalil on 29/03/2022.
//

import XCTest
@testable import SmartBuilding
class DateFormatTests: XCTestCase {
    
    var helpers = Utils()

    func testDateNotNil(){
        
        let formattedDateEx1  = helpers.getFormatedDate(date_string: "2022-04-05T15:00:00Z", dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ", desiredFormat: "dd-MM-yyyy")
        let formattedDateEx2  = helpers.getFormatedDate(date_string: "2022-03-29", dateFormat: "yyyy-MM-dd", desiredFormat: "MMM d, yyyy")
        
        XCTAssertNotNil(formattedDateEx1)
        XCTAssertNotNil(formattedDateEx2)
    }
    
    func testDateIsNotCorrect(){
        
        let formattedDateNotCorrect = helpers.getFormatedDate(date_string: "01-01-2023", dateFormat: "yyyy-MM-dd", desiredFormat: "MMM d, yyyy")
        let formattedDateCorrect = helpers.getFormatedDate(date_string: "2023-01-01", dateFormat: "yyyy-MM-dd", desiredFormat: "MMM d, yyyy")
        
        XCTAssertNotEqual(formattedDateCorrect, formattedDateNotCorrect, "Incorerect Date")
    }
    
    func testDateFormatEqualDesiredFormat(){
        
        let formattedDateEx1 = helpers.getFormatedDate(date_string: "2022-04-05T15:00:00Z", dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ", desiredFormat: "MM/dd/yyyy")
        let correctDateFormatEx1 = "04/05/2022"
        
        let formattedDateEx2 = helpers.getFormatedDate(date_string: "2022-04-05T15:00:00Z", dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ", desiredFormat: "dd.MM.yy")
        let correctDateFormatEx2 = "05.04.22"
        
        XCTAssertEqual(formattedDateEx1, correctDateFormatEx1, "Correct date format")
        XCTAssertEqual(formattedDateEx2, correctDateFormatEx2, "Correct date format")
        
    }

}
