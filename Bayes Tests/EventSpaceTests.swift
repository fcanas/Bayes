//
//  EventSpaceTests.swift
//  Bayes
//
//  Created by Fabian Canas on 5/11/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

import Cocoa
import XCTest
import Bayes

class EventSpaceTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSingleCategoryProbability() {
        var eventSpace = EventSpace<String,String>()
        eventSpace.observe("Cat", features: ["paw", "ear", "whisker"])
        eventSpace.observe("Cat", features: ["teeth", "tail", "stripe"])
        XCTAssertEqual(eventSpace.P("Cat"), 1.0, "Probability of single category is 1")
        XCTAssertEqual(eventSpace.P("Dog"), 0.0, "Probability of unobserved category is 0")
    }

    func testCategoryProbability() {
        var eventSpace = EventSpace<String,String>()
        eventSpace.observe("Cat", features: ["paw", "ear", "whisker"])
        eventSpace.observe("Car", features: ["wheel", "door", "window"])
        XCTAssertEqual(eventSpace.P("Cat"), 0.5, "Probability of 1 of 2 categories is 0.5")
        XCTAssertEqual(eventSpace.P("Car"), 0.5, "Probability of 1 of 2 categories is 0.5")
        XCTAssertEqual(eventSpace.P("Dog"), 0.0, "Probability of unobserved category is 0")
        
        eventSpace.observe("Cat", features: ["paw", "ear", "whisker"])
        eventSpace.observe("Cat", features: ["tree", "yarn", "meow"])
        XCTAssertEqual(eventSpace.P("Cat"), 0.75, "Probability of 3 to 1 categories is 0.75")
        XCTAssertEqual(eventSpace.P("Car"), 0.25, "Probability of 1 to 3 categories is 0.25")
        
        eventSpace.observe("Dog", features: ["bark", "pant", "fetch"])
        XCTAssertEqual(eventSpace.P("Cat"), 0.6, "Probability of 3 in 5 categories is 0.6")
        XCTAssertEqual(eventSpace.P("Car"), 0.2, "Probability of 1 in 5 categories is 0.2")
        XCTAssertEqual(eventSpace.P("Dog"), 0.2, "Probability of 1 to 5 categories is 0.2")
    }

    func testFeaturesConditionedOnCategory() {
        var eventSpace = EventSpace<String,String>()
        eventSpace.observe("Cat", features: ["paw", "ear", "whisker"])
        XCTAssertEqual(eventSpace.P("paw", givenCategory: "Cat"), 1.0, "Perfect coincidence -> 1.0")
        
        eventSpace.observe("Cat", features: ["paw", "tail", "claw"])
        XCTAssertEqual(eventSpace.P("paw", givenCategory: "Cat"), 1.0, "Perfect coincidence with multiple observation -> 1.0")
        
        XCTAssertEqual(eventSpace.P("ear", givenCategory: "Cat"), 0.5, "Half of observations -> .5")
        XCTAssertEqual(eventSpace.P("whisker", givenCategory: "Cat"), 0.5, "Half of observations -> .5")
        XCTAssertEqual(eventSpace.P("tail", givenCategory: "Cat"), 0.5, "Half of observations -> .5")
        XCTAssertEqual(eventSpace.P("claw", givenCategory: "Cat"), 0.5, "Half of observations -> .5")
        
        eventSpace.observe("Dog", features: ["paw", "ear", "tail"])
        
        XCTAssertEqual(eventSpace.P("paw", givenCategory: "Cat"), 1.0, "P(feature|category) should be resiliant against spurious categories")
        XCTAssertEqual(eventSpace.P("ear", givenCategory: "Cat"), 0.5, "P(feature|category) should be resiliant against spurious categories")
        XCTAssertEqual(eventSpace.P("whisker", givenCategory: "Cat"), 0.5, "P(feature|category) should be resiliant against spurious categories")
        XCTAssertEqual(eventSpace.P("tail", givenCategory: "Cat"), 0.5, "P(feature|category) should be resiliant against spurious categories")
        
        XCTAssertEqual(eventSpace.P("tail", givenCategory: "Dog"), 1.0, "Perfect coincidence -> 1.0")
    }
    
    func testFeatureCategoryIntersect() {
        var eventSpace = EventSpace<String,String>()
        eventSpace.observe("Cat", features: ["paw", "ear", "whisker"])
        XCTAssertEqual(eventSpace.P("paw", andCategory: "Cat"), 1.0, "Perfect coincidence -> 1.0")
        
        eventSpace.observe("Cat", features: ["paw", "tail", "claw"])
        XCTAssertEqual(eventSpace.P("paw", andCategory: "Cat"), 1.0, "Perfect coincidence with multiple observation -> 1.0")
        
        XCTAssertEqual(eventSpace.P("ear", andCategory: "Cat"), 0.5, "Half of observations -> .5")
        XCTAssertEqual(eventSpace.P("whisker", andCategory: "Cat"), 0.5, "Half of observations -> .5")
        XCTAssertEqual(eventSpace.P("tail", andCategory: "Cat"), 0.5, "Half of observations -> .5")
        XCTAssertEqual(eventSpace.P("claw", andCategory: "Cat"), 0.5, "Half of observations -> .5")
        
        eventSpace.observe("Dog", features: ["paw", "ear", "tail"])
        eventSpace.observe("Fox", features: ["paw", "ear", "tail"])
        
        XCTAssertEqual(eventSpace.P("paw", andCategory: "Cat"), 0.5, "P(feature ∩ category) should be sensitive to number of observations")
        XCTAssertEqual(eventSpace.P("ear", andCategory: "Cat"), 0.25, "P(feature ∩ category) should be sensitive to number of observations")
        XCTAssertEqual(eventSpace.P("paw", andCategory: "Dog"), 0.25, "P(feature ∩ category) should be sensitive to number of observations")
        XCTAssertEqual(eventSpace.P("tail", andCategory: "Fox"), 0.25, "P(feature ∩ category) should be sensitive to number of observations")
    }
    
}
