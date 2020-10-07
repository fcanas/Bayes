//
//  EventSpace.swift
//  Bayes
//
//  Created by Fabian Canas on 5/9/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

public struct EventSpace <C: Hashable, F: Hashable> {
    public typealias Category = C
    public typealias Feature = F
    
    public init() {}
    
    internal var categories :[Category] {
        get {
            return _categories.members
        }
    }
    
    fileprivate var _categories :Bag<C> = Bag<C>()
    fileprivate var _features :Bag<F> = Bag<F>()
    fileprivate var featureCategory :Bag<HashableTuple<C,F>> = Bag<HashableTuple<C,F>>()
    
    /// Add an observed event in a category with associated features to the 
    /// event space.
    ///
    /// - Parameters:
    ///   - category: The category of the event to add to the event space
    ///   - features: A sequence of features observed with the event
    public mutating func observe <S: Sequence> (_ category: Category, features: S) where S.Iterator.Element == Feature {
        _categories.append(category)
        _features.append(features)
        featureCategory.append(features.map {
            HashableTuple(category,$0)
        })
    }
    
    /// The probability of observing the feature and category together
    /// P( feature, category)
    ///
    /// - Parameters:
    ///   - feature: feature
    ///   - category: category
    /// - Returns: The joint probability of feature and category
    public func P(_ feature: Feature, andCategory category: Category) -> Double {
        return Double(featureCategory.count(HashableTuple(category, feature))) / Double(_categories.count)
    }
    
    /// The probability of observing a feature given a category.
    /// P( feature | category )
    ///
    /// - Parameters:
    ///   - feature: feature
    ///   - category: category
    /// - Returns: The conditional probability of the feature given the category
    public func P(_ feature: Feature, givenCategory category: Category) -> Double {
        return P(feature, andCategory: category)/P(category)
    }
    
    /// Probability of observing a category
    /// P( category )
    ///
    /// - Parameter category: category
    /// - Returns: The base rate of the category
    public func P(_ category: Category) -> Double {
        return _categories.P(category)
    }
}
