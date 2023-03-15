//
//  CounterViewModel.swift
//
//
//  Created by Leif on 3/15/23.
//

import SwiftUI
import ViewModel

class CounterViewModel: ViewModel<Void, Void, Int> {
    @Published private var count: Int = 0

    override var content: Int { count }

    func decrement() {
        count -= 1
    }

    func increment() {
        count += 1
    }
}

struct CounterViewModel_ExampleView: View {
    @ObservedObject var viewModel: CounterViewModel

    var body: some View {
        viewModel.view { content in
            VStack {
                Text("\(content)")

                HStack {
                    Button("-", action: viewModel.decrement)
                    Button("+", action: viewModel.increment)
                }
            }
        }
    }
}

struct CounterViewModel_ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CounterViewModel_ExampleView(
            viewModel: CounterViewModel(capabilities: (), input: ())
        )
    }
}
