//
//  BayesianClassifier.swift
//  Bayes
//
//  Created by Fabian Canas on 5/9/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

import Darwin

let nonZeroLog = 0.00000001

public struct BayesianClassifier<C :Hashable, F :Hashable> {
    public typealias Feature = F
    public typealias Category = C
    
    public init(eventSpace: EventSpace<Category,Feature>){
        self.eventSpace = eventSpace
    }
    
    public var eventSpace :EventSpace<Category,Feature> = EventSpace<Category,Feature>()
    
    public func classify <S :SequenceType where S.Generator.Element == Feature> (features :S) -> Category? {
        return argmax(categoryProbabilities(features))
    }
    
    public func categoryProbabilities <S :SequenceType where S.Generator.Element == Feature> (features: S) -> [Category: Double] {
        return eventSpace.categories.reduce([C:Double](), combine: {(v: [C:Double], c: Category) in
            var mv = v
            mv[c] = log(self.eventSpace.P(c)) + sum(features.map { log(self.eventSpace.P($0, givenCategory: c) + nonZeroLog) } )
            return mv
        })
    }
}
