//
//  InputViewModel.swift
//
//
//  Created by Leif on 3/15/23.
//

import SwiftUI
import ViewModel

class InputViewModel: ViewModel<Void, InputViewModel.Input, InputViewModel.Content> {
    struct Input {
        var text: String
        var number: Int
    }

    struct Content {
        var title: String
        var number: Int
    }

    override var content: Content {
        Content(
            title: input.text,
            number: input.number
        )
    }

    init() {
        super.init(capabilities: (), input: Input(text: "", number: 0))
    }
}

struct InputViewModel_ExampleView: View {
    @ObservedObject var viewModel: InputViewModel

    var body: some View {
        viewModel.view { content in
            VStack {
                Text(content.title)
                TextField("Text here: ", text: viewModel.binding(\.text))
                TextField("Numbers here: ", value: viewModel.binding(\.number), formatter: NumberFormatter())
            }
        }
        .padding()
    }
}

struct InputViewModel_ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        InputViewModel_ExampleView(
            viewModel: InputViewModel()
        )
    }
}
