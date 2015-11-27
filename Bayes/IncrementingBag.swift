//
//  IncrementingBag.swift
//  Bayes
//
//  Created by Fabian Canas on 5/11/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

/// An implementation of a bag to which elements can be added but not removed
internal struct Bag <T :Hashable> {
    private var storage :[T: Int] = [T: Int]()
    
    var members :[T] {
        get {
            return Array(storage.keys)
        }
    }
    
    var count :Int {
        get{
            return storage.reduce(0, combine: { $0 + $1.1 })
        }
    }
    
    func count(element: T) -> Int {
        return storage[element] ?? 0
    }
    
    mutating func append(element: T) {
        storage[element] = count(element) + 1
    }
    
    mutating func append<E: SequenceType where E.Generator.Element == T>(elements: E) {
        for element in elements {
            append(element)
        }
    }
    
    func P(element: T) -> Double {
        return Double(count(element)) / Double(count)
    }
}
