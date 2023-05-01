//
//  SubscriberBootcamp.swift
//  SwiftUIIntermediateLevel
//
//  Created by Denys Nikolaichuk on 24.04.2023.
//

import SwiftUI
import Combine

class SubscriberBootcampViewModel: ObservableObject {
    @Published var count: Int = 0
    var timer: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    @Published var showButton: Bool = false
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addbuttonSubscriber()
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { text in
                if text.count > 3 {
                    return true
                }
                return false
            }
//            .assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] isValid in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func setUpTimer() {
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.count += 1
//
//                if self.count >= 10 {
//                    for item in self.cancellables {
//                        item.cancel()
//                    }
//                }
            }
            .store(in: &cancellables)
    }
    
    func addbuttonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] isValid, count in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
}

struct SubscriberBootcamp: View {
    @StateObject var viewModel = SubscriberBootcampViewModel()
    
    var body: some View {
        VStack {
            Text("\(viewModel.count)")
                .font(.largeTitle)
            
            Text(viewModel.textIsValid.description)
            
            TextField("Type something", text: $viewModel.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .overlay(alignment: .trailing) {
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(
                                viewModel.textFieldText.count < 1 ? 0.0 : viewModel.textIsValid ? 0.0 : 1.0)
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(viewModel.textIsValid ? 1.0 : 0.5)
                    }
                    .font(.headline)
                    .padding(.trailing)

                }
            
            Button {
                
            } label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
                    .opacity(viewModel.showButton ? 1.0 : 0.5)
            }
            .disabled(!viewModel.showButton)
        }
        .padding()
    }
}

struct SubscriberBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberBootcamp()
    }
}
