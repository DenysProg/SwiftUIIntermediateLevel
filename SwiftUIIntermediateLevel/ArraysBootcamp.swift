//
//  ArraysBootcamp.swift
//  SwiftUIIntermediateLevel
//
//  Created by Denys Nikolaichuk on 21.03.2023.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArraModificationViewModel: ObservableObject {
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUser()
        updateFilteredArray()
    }
    
    func updateFilteredArray() {
        // sort
        /*
        let sortendArray = dataArray.sorted { user1, user2 in
            return user1.points > user2.points
        }
        filteredArray = sortendArray
         filteredArray = dataArray.sorted { $0.points > $1.points }
        */
        // filter
        /*
        filteredArray = dataArray.filter({ user in
//            return user.points > 20
             return user.isVerified
        })
         filteredArray = dataArray.filter { $0.isVerified }
         */
        // map
        /*
        mappedArray = dataArray.map({ user in
            return user.name ?? "Error"
        })
        mappedArray = dataArray.map { $0.name ?? "Error"}
        
        mappedArray = dataArray.compactMap { $0.name }
        */
        
        mappedArray = dataArray.sorted { $0.points > $1.points }.filter { $0.isVerified }.compactMap { $0.name }
    }
    
    func getUser() {
        let user1 = UserModel(name: "Denys", points: 5, isVerified: true)
        let user2 = UserModel(name: "Nick", points: 0, isVerified: false)
        let user3 = UserModel(name: nil, points: 20, isVerified: true)
        let user4 = UserModel(name: "Joe", points: 15, isVerified: false)
        let user5 = UserModel(name: "Emily", points: 25, isVerified: true)
        let user6 = UserModel(name: "Samantha", points: 35, isVerified: true)
        let user7 = UserModel(name: "Jason", points: 8, isVerified: false)
        let user8 = UserModel(name: "Sarah", points: 0, isVerified: true)
        let user9 = UserModel(name: "Lisa", points: 1, isVerified: true)
        let user10 = UserModel(name: "Steve", points: 3, isVerified: false)
        self.dataArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10
        ])
    }
}

struct ArraysBootcamp: View {
    @StateObject var viewModel = ArraModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(viewModel.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
                
                
//                ForEach(viewModel.filteredArray) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name ?? "Error")
//                            .font(.headline)
//                        HStack {
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

struct ArraysBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ArraysBootcamp()
    }
}
