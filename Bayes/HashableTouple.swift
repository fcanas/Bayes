//
//  HashableTuple.swift
//  Bayes
//
//  Created by Fabian Canas on 5/9/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

/** A (Hashable, Hashable) isn't Hashable. But it sure makes it easier to
represent conditional probilities in a Set or Dictionary if they are
*/
internal struct HashableTuple<A : Hashable, B : Hashable> : Hashable {
    let a :A
    let b :B
    
    init(_ a: A, _ b: B) {
        self.a = a
        self.b = b
    }
    
    var hashValue :Int {
        get {
            return a.hashValue ^ b.hashValue
        }
    }
}

internal func == <A, B> (lhs: HashableTuple<A,B>, rhs: HashableTuple<A,B>) -> Bool {
    return lhs.a == rhs.a && lhs.b == rhs.b
}
