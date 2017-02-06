//
//  Math.swift
//  Bayes
//
//  Created by Fabian Canas on 5/11/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

/// The product of the element in a Sequence
///
/// - Parameter s: Sequence of doubles
/// - Returns: The product of the Sequence, or 1 for an empty Sequence
public func product <S :Sequence> (_ s: S) -> Double where S.Iterator.Element == Double {
    return s.reduce(Double(1.0), *)
}

/// The sum of the element in a Sequence
///
/// - Parameter s: Sequence of doubles
/// - Returns: The sum of the Sequence, or zero for an empty Sequence
public func sum <S :Sequence> (_ s: S) -> Double where S.Iterator.Element == Double {
    return s.reduce(Double(0.0), +)
}

/// For a dictionary from `T` to `V`, returns the value `T` that maximizes `V`
///
/// - Parameter collection: A dicionary mapping from `T` to `V`
/// - Returns: The value `T` that maximizes `V` in the collection
public func argmax <T, V: Comparable> (_ collection :[T:V]) -> T? {
    return vararg({ $0 > $1 })(collection)
}

/// For a dictionary from `T` to `V`, returns the value `T` that minimizes `V`
///
/// - Parameter collection: A dicionary mapping from `T` to `V`
/// - Returns: The value `T` that minimizes `V` in the collection
public func argmin <T, V: Comparable> (_ collection :[T:V]) -> T? {
    return vararg({ $0 < $1 })(collection)
}

private func vararg <T, V: Comparable> (_ f: @escaping (V, V) -> Bool) -> (_ collection :[T:V]) -> T? {
    return { collection in
        if collection.isEmpty {
            return nil
        }
        return collection.reduce(collection[collection.startIndex]) { f($0.1 , $1.1) ? $0 : $1 }.0
    }
}
