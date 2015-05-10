//
//  Math.swift
//  Bayes
//
//  Created by Fabian Canas on 5/11/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

public func product <S :SequenceType where S.Generator.Element == Double> (s: S) -> Double {
    return reduce(s, Double(1.0), *)
}

public func argmax <T, V: Comparable> (collection :[T:V]) -> T? {
    if collection.isEmpty {
        return nil
    }
    return reduce(collection, collection[collection.startIndex]) { $0.1 > $1.1 ? $0 : $1 }.0
}
