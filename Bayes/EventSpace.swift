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
    
    public mutating func observe <F: Sequence> (_ category: Category, features: F) where F.Iterator.Element == Feature {
        _categories.append(category)
        _features.append(features)
        featureCategory.append(features.map {
            HashableTuple(category,$0)
        })
    }
    
    public func P(_ feature: Feature, andCategory category: Category) -> Double {
        return Double(featureCategory.count(HashableTuple(category, feature))) / Double(_categories.count)
    }
    
    public func P(_ feature: Feature, givenCategory category: Category) -> Double {
        return P(feature, andCategory: category)/P(category)
    }
    
    public func P(_ category: Category) -> Double {
        return _categories.P(category)
    }
}
