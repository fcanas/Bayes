//
//  EventSpace.swift
//  Bayes
//
//  Created by Fabian Canas on 5/9/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

import Set

public struct EventSpace <C: Hashable, F: Hashable> {
    typealias Category = C
    typealias Feature = F
    
    internal var categories :[Category] {
        get {
            return members(_categories)
        }
    }
    
    internal var features :[Feature] {
        get {
            return members(_features)
        }
    }
    
    private var _categories :Multiset<C> = Multiset<C>()
    private var _features :Multiset<F> = Multiset<F>()
    private var featureCategory :Multiset<HashableTouple<C,F>> = Multiset<HashableTouple<C,F>>()
    
    public mutating func observe(category: Category, features: [Feature]) {
        _categories.append(category)
        _features = _features.union(Multiset(features))
        
        featureCategory = Multiset(map(features, {
            HashableTouple(category,$0)
        })).union(featureCategory)
    }
    
    public func P(feature: Feature, andCategory category: Category) -> Double {
        return featureCategory.P(HashableTouple(category, feature))
    }
    
    public func P(feature: Feature, givenCategory category: Category) -> Double {
        return P(feature, andCategory: category)/P(category)
    }
    
    public func P(category: Category) -> Double {
        return _categories.P(category)
    }

    public func P(feature: Feature) -> Double {
        return _features.P(feature)
    }
}

func members <T> (multiset: Multiset<T>) -> [T] {
    var m = [T]()
    for t in multiset {
        m.append(t)
    }
    return m
}