//
//  DawnloadingImageView.swift
//  SwiftUIIntermediateLevel
//
//  Created by Denys Nikolaichuk on 01.05.2023.
//

import SwiftUI

struct DawnloadingImageView: View {
    @StateObject var loader: ImageLoadingViewModel
    
    init(url: String, key: String) {
        _loader = StateObject(wrappedValue: ImageLoadingViewModel(url: url, key: key))
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }
        }
    }
}

struct DawnloadingImageView_Previews: PreviewProvider {
    static var previews: some View {
        DawnloadingImageView(url: "https://via.placeholder.com/600/92c952", key: "1")
            .frame(width: 75, height: 75)
            .previewLayout(.sizeThatFits)
    }
}
