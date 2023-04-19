//
//  DownloadWithCombine.swift
//  SwiftUIIntermediateLevel
//
//  Created by Denys Nikolaichuk on 13.04.2023.
//

import SwiftUI
import Combine

class DownloadWithCombineViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // 1. sign up for monthly subscription for package to be delivered
        // 2. the company would make the packge behind the scene
        // 3. recieve the packege at your front door
        // 4. make sure the box isn't damaged
        // 5. open and make sure the item is correct
        // 6. use the item!!!
        // 7. cancellable at any time!!
        
        // 1. create the publicher
        // 2. subscribe publisher on background thread
        // 3. receive on main thread
        // 4. tryMap (check that the data is good)
        // 5. decode (decode data info PostModels)
        // 6. sink (put the item into our app)
        // 7. store (cancel subscription if needed)
        
        URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .background)) // already in background
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
//            .replaceError(with: [PostModel])
//            .sink(receiveValue: { <#[PostModel]#> in
//                <#code#>
//            })
        
        
            .sink { complition in
                switch complition {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Error", error.localizedDescription)
                }
            } receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            }
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        
        return output.data
    }
}

struct DownloadWithCombine: View {
    @StateObject var viewModel = DownloadWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct DownloadWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombine()
    }
}
