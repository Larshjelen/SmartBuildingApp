//
//  ConvertUrlToImageTests.swift
//  SmartBuildingTests
//
//  Created by Ammar Khalil on 29/03/2022.
//

import XCTest
@testable import SmartBuilding

class ConvertUrlToImageTests: XCTestCase {

    var helpers = Helpers()
    
    let imageUrlValid = "https://cdn.sanity.io/images/fbztprtz/production/86a1eff7bf32d075a7ac46ae6b3d17261a18c815-800x533.jpg"
    let imageUrlNotValid = "https://image.jpg"
    
    func testUrlIsNotValid(){
        
        let convertedImage = helpers.urlToImage(StringImage: imageUrlNotValid)
        
        XCTAssertNil(convertedImage)
    }
 
    
    func testUrlIsValid(){
        
        let convertedImage = helpers.urlToImage(StringImage: imageUrlValid)
        
        XCTAssertNotNil(convertedImage)
    }
    
    func testReturnedValueIsAnUiImage(){
        
        let convertedImage = helpers.urlToImage(StringImage: "https://cwrealkapital.no/wp-content/uploads/sites/2/2019/05/Rebel_2-3200x1200.jpg")
        
        XCTAssertTrue(convertedImage?.isEqual(UIImage.self) != nil)
    }
 
}
