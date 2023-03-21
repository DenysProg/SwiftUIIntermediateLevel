//
//  HashableBootcamp.swift
//  SwiftUIIntermediateLevel
//
//  Created by Denys Nikolaichuk on 20.03.2023.
//

import SwiftUI

struct MyCustomModel: Hashable {
//    let id = UUID().uuidString
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct HashableBootcamp: View {
    let data: [MyCustomModel] = [MyCustomModel(title: "One") ,
                                 MyCustomModel(title: "Two"),
                                 MyCustomModel(title: "Three"),
                                 MyCustomModel(title: "Foure"),
                                 MyCustomModel(title: "Five")]
    
    var body: some View {
        VStack {
            ForEach(data, id: \.self) { item in
                Text(item.title)
                    .font(.headline)
            }
//            ForEach(data) { item in
//                Text(item.title)
//                    .font(.headline)
//            }
        }
        
    }
}

struct HashableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HashableBootcamp()
    }
}
