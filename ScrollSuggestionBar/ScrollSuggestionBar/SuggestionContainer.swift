//
//  SuggestionContainer.swift
//  ScrollSuggestionBar
//
//  Created by Cédric Bahirwe on 27/02/2023.
//

import Foundation

class SuggestionContainer: ObservableObject {
    @Published private(set) var observedValue: AnyHashable? = nil

    private(set) var keys: Set<AnyHashable>

    init(keys: Set<AnyHashable> = Set<AnyHashable>()) {
        self.keys = keys
    }

    func observe(_ value: AnyHashable) {
        _  = keys.insert(value)
    }

    func matchValue(_ value: AnyHashable?) {
        observedValue = value
    }
}
