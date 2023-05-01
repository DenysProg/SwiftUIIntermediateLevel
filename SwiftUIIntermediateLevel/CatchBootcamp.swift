//
//  CatchBootcamp.swift
//  SwiftUIIntermediateLevel
//
//  Created by Denys Nikolaichuk on 01.05.2023.
//

import SwiftUI

class CacheManager {
    static let instance = CacheManager()
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 10
        cache.totalCostLimit = 1024 * 1024  * 100 // 100mb
        return cache
    }()
    
    private init() {}
    
    func add(image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString)
        print("Added to cache!")
    }
    
    func remove(name: String) {
        imageCache.removeObject(forKey: name as NSString)
        print("Deleted to cache!")
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

class CacheViewModel: ObservableObject {
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    let imageName: String = "steve-jobs"
    let manager = CacheManager.instance
    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else { return }
        manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        manager.remove(name: imageName)
    }
    
    func getFromCache() {
        cachedImage = manager.get(name: imageName)
    }
}

struct CatchBootcamp: View {
    @StateObject var viewModel = CacheViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = viewModel.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                HStack {
                    Button {
                        viewModel.saveToCache()
                    } label: {
                        Text("Save to Catch")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                }
                
                Button {
                    viewModel.removeFromCache()
                } label: {
                    Text("Delete from Catch")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(.red)
                        .cornerRadius(10)
                }
                
                Button {
                    viewModel.getFromCache()
                } label: {
                    Text("Get from Catch")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(.yellow)
                        .cornerRadius(10)
                }
                
                if let image = viewModel.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .navigationTitle("Cache Bootcamp")
        }
    }
}

struct CatchBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CatchBootcamp()
    }
}
