//
//  ListViewModifier.swift
//  ScrollSuggestionBar
//
//  Created by Cédric Bahirwe on 27/02/2023.
//

import SwiftUI

struct ListViewModifier: ViewModifier {
    private let alphabets =  ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

    @State var container: SuggestionContainer

    var match: (AnyHashable?) -> Void

    @State private var response: String?

    @State private var lastLocation: CGPoint = .zero

    private let defaultTrailingPadding: CGFloat = 0

    func body(content: Content) -> some View {
        ScrollViewReader { proxy in
            content
                .scrollIndicators(.hidden)
                .onChange(of: container.observedValue) { newValue in
                    handleValueChange(newValue, proxy: proxy)
                }
        }
        .overlay(alignment: .trailing) {
            matchOverlay
        }
        .overlay(alignment: .trailing) {
            GeometryReader { geo in
                VStack(spacing: 0) {
                    ForEach(alphabets, id: \.self) { item in
                        Text(item)
                            .textCase(.uppercase)
                            .font(.caption.weight(.medium))
                            .minimumScaleFactor(0.5)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(response==item ? .red : .blue)
                            .scaleEffect(response==item ? 1.7 : 1)
                    }
                }
                .overlay(content: {
                    VStack {
                        Text(geo.size.height.description)
                        Text(geo.size.width.description)
                    }
                    .font(.largeTitle)
                })
                .frame(width: 200, height: getGeoHeight(geo))
                .background(Color(uiColor: .secondarySystemGroupedBackground))
                .contentShape(Rectangle())
                .gesture(
                    drageGesture(geo)
                )

//                .gesture(
//                    DragGesture()
//                        .onChanged { gesture in
//                            handleGestureChange(gesture, in: geo)
//                        }
//                        .onEnded({ _ in
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                self.container.matchValue(nil)
//                                withAnimation {
//                                    self.response = nil
//                                }
//                            }
//                        })
//                )
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
            }
            .padding(.trailing, defaultTrailingPadding)
        }
    }

    var drageGesture: (GeometryProxy) -> _EndedGesture<_ChangedGesture<DragGesture>> {
        { geo in
            return DragGesture()
                .onChanged { gesture in
                    handleGestureChange(gesture, in: geo)
                }
                .onEnded({ _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        container.matchValue(nil)
                        withAnimation {
                            response = nil
                        }
                    }
                })
        }
    }

}

// MARK: - Private Methods
private extension ListViewModifier {
    func getGeoHeight(_ geo: GeometryProxy) -> CGFloat {
        geo.size.height*0.5
    }

    func handleValueChange<V: Equatable>(_ newValue: V, proxy: ScrollViewProxy) {
        guard let value = newValue as? String else { return }
        guard let keys = container.keys as? Set<String> else { return }
        guard let firstMatch = keys.first(where: {
            return $0.lowercased().hasPrefix(value.lowercased())
        }) else { return }
        withAnimation {
            proxy.scrollTo(firstMatch, anchor: .top)
        }
    }

    func handleGestureChange(_ gesture: DragGesture.Value, in geo: GeometryProxy) {
        let newPosition = gesture.location

        let rect = CGRect(origin: .zero, size: geo.size)

        if rect.contains(newPosition) {
            let containerHeight = getGeoHeight(geo)

            let itemHeight = containerHeight / CGFloat(alphabets.count)

            let resultIndex = Int(newPosition.y / itemHeight)

            if alphabets.indices.contains(resultIndex) {
                DispatchQueue.main.async {
                    let result = alphabets[resultIndex]
                    self.container.matchValue(result)
                    withAnimation {
                        self.lastLocation = newPosition
                        self.response = result
                        self.match(result)
                    }
                }
            }

        } else {
            DispatchQueue.main.async {
                match(nil)
                self.response = nil
            }
        }
    }
}

private extension ListViewModifier {
    var matchOverlay: some View {
        GeometryReader { geo in
            if let response {
                Text(response)
                    .textCase(.uppercase)
                    .font(.title.bold())
                    .foregroundColor(.accentColor)
                    .frame(width: 35, height: 35)
                    .background(.regularMaterial)
                    .cornerRadius(5)
                    .position(x: 0, y: lastLocation.y)
                    .offset(x: 25)
                    .frame(width: 50, height: getGeoHeight(geo))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                    .padding(.trailing, 25 + defaultTrailingPadding)
            }
        }
    }
}
