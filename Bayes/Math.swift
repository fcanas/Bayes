//
//  Math.swift
//  Bayes
//
//  Created by Fabian Canas on 5/11/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

public func product <S :Sequence> (_ s: S) -> Double where S.Iterator.Element == Double {
    return s.reduce(Double(1.0), *)
}

public func sum <S :Sequence> (_ s: S) -> Double where S.Iterator.Element == Double {
    return s.reduce(Double(0.0), +)
}

public func argmax <T, V: Comparable> (_ collection :[T:V]) -> T? {
    return vararg({ $0 > $1 })(collection)
}

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
