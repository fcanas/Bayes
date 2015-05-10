//
//  Observations.swift
//  Bayes
//
//  Created by Fabian Canas on 5/9/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

import Foundation
import Set

extension Multiset {
    func P(element: Element) -> Double {
        return Double(count(element)) / Double(count)
    }
}
