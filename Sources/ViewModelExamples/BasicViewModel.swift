//
//  BasicViewModel.swift
//  
//
//  Created by Leif on 3/15/23.
//

import SwiftUI
import ViewModel

class BasicViewModel: ViewModel<Void, Void, BasicViewModel.Content> {
    struct Content {
        var title: String
        var roundedNumber: Double
    }

    @Published private var title: String = "Hello, World!"
    @Published private var number: Double = .pi

    override var content: Content {
        Content(
            title: title,
            roundedNumber: number.rounded()
        )
    }

    func increment() {
        number += .pi
    }
}

struct BasicViewModel_ExampleView: View {
    @ObservedObject var viewModel: BasicViewModel

    var body: some View {
        viewModel.view { content in
            if content.roundedNumber > 100 {
                Text("Woah!")
            } else {
                VStack {
                    Text(content.title)
                    Text("\(content.roundedNumber)")
                    Button("+", action: viewModel.increment)
                }
            }
        }
    }
}

struct BasicViewModel_ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        BasicViewModel_ExampleView(
            viewModel: BasicViewModel(capabilities: (), input: ())
        )
    }
}
