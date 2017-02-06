//
//  IncrementingBag.swift
//  Bayes
//
//  Created by Fabian Canas on 5/11/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

/// An implementation of a bag to which elements can be added but not removed
internal struct Bag <T :Hashable> {
    fileprivate var storage :[T: Int] = [T: Int]()
    
    /// An Array containing all the elements in the Bag.
    ///
    /// The order of the Array is not guaranteed, and may not contain
    /// duplicate entries for elements added to the Bag more than once.
    var members :[T] {
        get {
            return Array(storage.keys)
        }
    }
    
    /// The number of elements that have been added to the Bag
    var count :Int {
        get{
            return storage.reduce(0, { $0 + $1.1 })
        }
    }
    
    /// The number of occurrences of an element in the Bag
    ///
    /// - Parameter element: Element being queries
    /// - Returns: The number of times `element` has been added to the Bag
    func count(_ element: T) -> Int {
        return storage[element] ?? 0
    }
    
    /// Add an element to the Bag
    ///
    /// - Parameter element: Element to add to the Bag
    mutating func append(_ element: T) {
        storage[element] = count(element) + 1
    }
    
    /// Add multiple elements to the Bag.
    ///
    /// - Parameter elements: A Sequence of elements to add to the Bag
    mutating func append<E: Sequence>(_ elements: E) where E.Iterator.Element == T {
        for element in elements {
            append(element)
        }
    }
    
    /// The probability of selecting an element at random from the Bag
    ///
    /// - Parameter element: Element that may be selected at random
    /// - Returns: probability of selecting `element` at random
    func P(_ element: T) -> Double {
        return Double(count(element)) / Double(count)
    }
}
