//
//  BayesianClassifier.swift
//  Bayes
//
//  Created by Fabian Canas on 5/9/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

import Darwin

private let nonZeroLog = 0.00000001

public struct BayesianClassifier<C :Hashable, F :Hashable> {
    public typealias Feature = F
    public typealias Category = C

    /// Initializes a new BayesianClassifier with an empty EventSpace
    public init(){ }

    /// Initializes a new BayesianClassifier with an existing EventSpace
    ///
    /// - Parameter eventSpace: an EventSpace of Features and Categories
    public init(eventSpace: EventSpace<Category,Feature>){
        self.eventSpace = eventSpace
    }

    public var eventSpace :EventSpace<Category,Feature> = EventSpace<Category,Feature>()

    /// The most likely category given a sequence of Features
    ///
    /// - Parameter features: A Sequence of observed Features
    /// - Returns: the Category with the highest propbability given the features
    public func classify <S :Sequence> (_ features :S) -> Category? where S.Iterator.Element == Feature {
        return argmax(categoryProbabilities(features))
    }

    /// The probability of each known Category given a sequence of Features
    ///
    /// - Parameter features: A sequence of features
    /// - Returns: A dictionary mapping each known Category to a probability of
    ///            that Category given the features.
    public func categoryProbabilities <S :Sequence> (_ features: S) -> [Category: Double] where S.Iterator.Element == Feature {
        return eventSpace.categories.reduce([C:Double](), {(v: [C:Double], c: Category) in
            var mv = v
            mv[c] = log(self.eventSpace.P(c)) + sum(features.map { log(self.eventSpace.P($0, givenCategory: c) + nonZeroLog) } )
            return mv
        })
    }
}
