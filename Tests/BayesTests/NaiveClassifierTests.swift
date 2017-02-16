//
//  NaiveClassifierTests.swift
//  Bayes
//
//  Created by Fabian Canas on 5/11/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

import Cocoa
import XCTest
import Bayes

class NaiveClassifierTests: XCTestCase {

    func testBasicClassification() {
        var eventSpace = EventSpace<String, String>()
        
        eventSpace.observe("Cat", features: ["paw", "tail", "claw"])
        eventSpace.observe("Cat", features: ["stripe", "tail", "whisker", "ear"])
        eventSpace.observe("Cat", features: ["meow", "vertical pupil"])
        
        eventSpace.observe("Dog", features: ["paw", "tail", "bark"])
        eventSpace.observe("Dog", features: ["wag", "fetch", "tail", "paw"])
        
        let classifier = BayesianClassifier(eventSpace: eventSpace)
        
        XCTAssertEqual(classifier.classify(["claw", "tail"])!, "Cat", "Should categorize as Cat, due to claw")
        XCTAssertEqual(classifier.classify(["bark", "tail"])!, "Dog", "Should categorize as Dog, due to bark")
        XCTAssertEqual(classifier.classify(["tail"])!, "Cat", "Should categorize as Cat, due to base rate")
        XCTAssertEqual(classifier.classify(["paw", "tail"])!, "Dog", "Should categorize as Dog, due to prevalence of paw")
        XCTAssertEqual(classifier.classify(["paw", "tail", "meow"])!, "Cat", "Should categorize as Cat, due to meow")
        XCTAssertEqual(classifier.classify(["paw"])!, "Dog", "Should categorize as Dog, due to prevalence of paw")
    }
    
    func testLogSpaceClassification() {
        var eventSpace = EventSpace<String, String>()
        
        eventSpace.observe("Cat", features: ["paw", "tail", "claw"])
        eventSpace.observe("Cat", features: ["stripe", "tail", "whisker", "ear"])
        eventSpace.observe("Cat", features: ["meow", "vertical pupil"])
        
        eventSpace.observe("Dog", features: ["paw", "tail", "bark"])
        eventSpace.observe("Dog", features: ["wag", "fetch", "tail", "paw"])
        
        let classifier = BayesianClassifier(eventSpace: eventSpace)
        
        XCTAssertEqual(classifier.classify(["claw", "tail", "collar"])!, "Cat", "Should categorize as Cat due to claw and ignore collar")
        
        print(classifier.categoryProbabilities(["bark", "tail", "collar"]))
        XCTAssertEqual(classifier.classify(["bark", "tail", "collar"])!, "Dog", "Should categorize as Dog due to bark and ignore collar")
        
    }

}
