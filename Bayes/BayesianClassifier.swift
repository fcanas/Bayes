//
//  BayesianClassifier.swift
//  Bayes
//
//  Created by Fabian Canas on 5/9/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

public struct BayesianClassifier<C :Hashable, F :Hashable> {
    typealias Feature = F
    typealias Category = C
    
    public var eventSpace :EventSpace<Category,Feature> = EventSpace<Category,Feature>()
    
    public func classify(features :[Feature]) -> Category? {
        return argmax(categoryProbabilities(features))
    }
    
    public func categoryProbabilities(features: [Feature]) -> [Category: Double] {
        return reduce(eventSpace.categories, [C:Double](), {(v: [C:Double], c: Category) in
            var mv = v
            mv[c] = self.eventSpace.P(c) * product(map(features, {self.eventSpace.P($0, givenCategory: c)}))
            return mv
        })
    }
}
