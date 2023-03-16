//
//  DidSetInputViewModel.swift
//
//
//  Created by Leif on 3/15/23.
//

import SwiftUI
import ViewModel

class DidSetInputViewModel: ViewModel<Void, DidSetInputViewModel.Input, DidSetInputViewModel.Content> {
    struct Input: Equatable {
        var text: String
    }

    struct Content {
        var title: String
        var count: Int
    }

    @Published private var number: Int = 0

    override var input: Input {
        didSet {
            guard input != oldValue else { return }

            assert(Thread.isMainThread)

            number += 1
        }
    }

    override var content: Content {
        Content(
            title: input.text,
            count: number
        )
    }

    func clear() {
        number = 0
    }
}

struct DidSetInputViewModel_ExampleView: View {
    @ObservedObject var viewModel: DidSetInputViewModel

    var body: some View {
        viewModel.view { content in
            VStack {
                Text(content.title)
                Text("\(content.count)")
                
                TextField("Enter text:", text: viewModel.binding(\.text))

                Button("Clear Count", action: viewModel.clear)
            }
            .padding()
        }
    }
}

struct DidSetInputViewModel_ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        DidSetInputViewModel_ExampleView(
            viewModel: DidSetInputViewModel(
                capabilities: (),
                input: .init(text: "")
            )
        )
    }
}
