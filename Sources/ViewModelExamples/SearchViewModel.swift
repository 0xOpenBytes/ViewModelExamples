//
//  SearchViewModel.swift
//
//
//  Created by Leif on 3/15/23.
//

import SwiftUI
import ViewModel

protocol Searchable {
    func search(word: String) async throws -> [String]
}

@available(iOS 16.0, *)
struct SearchService: Searchable {
    let validWords: [String] = [
        "Hello",
        "World",
        "View",
        "ViewModel",
        "Model",
        "Example"
    ]

    func search(word: String) async throws -> [String] {
        try await Task.sleep(for: .seconds(3))

        return validWords.filter { $0.lowercased().contains(word.lowercased()) }
    }
}

@available(iOS 16.0, *)
class SearchViewModel: ViewModel<Searchable, SearchViewModel.Input, SearchViewModel.Content> {
    struct Input: Equatable {
        var searchText: String
    }

    struct Content {
        var searchResults: [String]
        var isLoading: Bool
    }

    @Published private var searchResults: [String] = []
    @Published private var isLoading: Bool = false

    override var content: Content {
        Content(
            searchResults: searchResults,
            isLoading: isLoading
        )
    }

    func search() {
        guard isLoading == false else { return }

        isLoading = true

        Task {
            let results = try! await capabilities.search(word: input.searchText)

            await MainActor.run {
                isLoading = false
                searchResults = results
            }
        }
    }
}

@available(iOS 16.0, *)
struct SearchViewModel_ExampleView: View {
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        viewModel.view { content in
            VStack {
                TextField("Search", text: viewModel.binding(\.searchText))
                    .padding(.horizontal)

                if content.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    Button("Search", action: viewModel.search)

                    List(content.searchResults, id: \.self) { result in
                        Text(result)
                    }
                }
            }
        }
    }
}

@available(iOS 16.0, *)
struct SearchViewModel_ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewModel_ExampleView(
            viewModel: SearchViewModel(
                capabilities: SearchService(),
                input: .init(searchText: "")
            )
        )
    }
}
