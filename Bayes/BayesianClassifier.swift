//
//  BayesianClassifier.swift
//  Bayes
//
//  Created by Fabian Canas on 5/9/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

import Foundation

let nonZeroLog = 0.00000001

public struct BayesianClassifier<C :Hashable, F :Hashable> {
    typealias Feature = F
    typealias Category = C
    
    public init() {}
    public init(eventSpace: EventSpace<Category,Feature>){
        self.eventSpace = eventSpace
    }
    
    public var eventSpace :EventSpace<Category,Feature> = EventSpace<Category,Feature>()
    
    public func classify(features :[Feature]) -> Category? {
        return argmax(categoryProbabilities(features))
    }
    
    public func categoryProbabilities(features: [Feature]) -> [Category: Double] {
        return reduce(eventSpace.categories, [C:Double](), {(v: [C:Double], c: Category) in
            var mv = v
            mv[c] = log(self.eventSpace.P(c)) + sum(map(features, { log(self.eventSpace.P($0, givenCategory: c) + nonZeroLog) }))
            return mv
        })
    }
}
