//
//  DownloadingImagesRow.swift
//  SwiftUIIntermediateLevel
//
//  Created by Denys Nikolaichuk on 01.05.2023.
//

import SwiftUI

struct DownloadingImagesRow: View {
    let model: PhotoModel
    
    var body: some View {
        HStack {
            DawnloadingImageView(url: model.url, key: "\(model.id)")
                .frame(width: 75, height: 75)
            VStack(alignment: .leading) {
                Text(model.title)
                    .font(.headline)
                Text(model.url)
                    .foregroundColor(.gray)
                    .italic()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct DownloadingImagesRow_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesRow(model: PhotoModel(albumId: 1, id: 1, title: "https://via.placeholder.com/600/92c952", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/600/92c952"))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
