//
//  Extensions.swift
//  ScrollSuggestionBar
//
//  Created by Cédric Bahirwe on 27/02/2023.
//

import SwiftUI

extension List {
    func listSuggestions(_ container: SuggestionContainer, match: @escaping (AnyHashable?) -> Void) -> some View {
        ModifiedContent(content: self, modifier: ListViewModifier(container: container, match: match))
    }
}

extension ScrollView {
    func scrollSuggestions(_ container: SuggestionContainer, match: @escaping (AnyHashable?) -> Void) -> some View {
        ModifiedContent(content: self, modifier: ListViewModifier(container: container, match: match))
    }
}
