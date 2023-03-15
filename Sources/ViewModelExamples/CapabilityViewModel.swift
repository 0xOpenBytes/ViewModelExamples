//
//  CapabilityViewModel.swift
//
//
//  Created by Leif on 3/15/23.
//

import SwiftUI
import ViewModel

protocol Greetable {
    func greet() -> String
}

struct Greeter: Greetable {
    func greet() -> String {
        "Hello, World!"
    }
}

class CapabilityViewModel: ViewModel<Greetable, Void, CapabilityViewModel.Content> {
    struct Content {
        var title: String
    }

    @Published private var title: String = ""

    override var content: Content {
        Content(
            title: title
        )
    }

    func onAppear() {
        title = capabilities.greet()
    }
}

struct CapabilityViewModel_ExampleView: View {
    @ObservedObject var viewModel: CapabilityViewModel

    var body: some View {
        viewModel.view { content in
            Text(content.title)
        }
        .onAppear(perform: viewModel.onAppear)
    }
}

struct CapabilityViewModel_ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CapabilityViewModel_ExampleView(
            viewModel: CapabilityViewModel(
                capabilities: Greeter(),
                input: ()
            )
        )
    }
}
