//
//  ContentView.swift
//  Aussies
//
//  Created by Hari Krishna on 21/02/25.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = AussieViewModel()
    @State private var isReversed = false
    @State private var expandedStates: Set<String> = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.groupedCities.keys.sorted(by: isReversed ? (>) : (<)), id: \.self) { state in
                    Section(header: HStack {
                        Text(state).bold()
                        Spacer()
                        Button(action: {
                            if expandedStates.contains(state) {
                                expandedStates.remove(state)
                            } else {
                                expandedStates.insert(state)
                            }
                        }) {
                            Image(systemName: expandedStates.contains(state) ? "chevron.down" : "chevron.right")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }) {
                        if expandedStates.contains(state) {
                            ForEach(viewModel.groupedCities[state] ?? [], id: \.city) { city in
                                Text(city.city)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Australian Cities")
            .toolbar {
                HStack {
                    Button(action: {
                        isReversed.toggle()
                    }) {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                    Button(action: {
                        viewModel.refreshCities()
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .onAppear {
                viewModel.loadCities()
            }
        }
    }
}

//#Preview {
//    ContentView()
//}

struct ContentView_Preview : PreviewProvider {
    
    static var preview: some View {
        ContentView()
    }
}
