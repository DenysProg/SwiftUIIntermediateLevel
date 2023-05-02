//
//  DownloadingImagesViewModel.swift
//  SwiftUIIntermediateLevel
//
//  Created by Denys Nikolaichuk on 01.05.2023.
//

import Foundation
import Combine

class DownloadingImagesViewModel: ObservableObject {
    @Published var dataArray: [PhotoModel] = []
    private let dataService = PhotoModelDataService.instatne
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$photoModels
            .sink { [weak self] (returnedPhotoModels) in
                self?.dataArray = returnedPhotoModels
            }
            .store(in: &cancellables)
    }
}
