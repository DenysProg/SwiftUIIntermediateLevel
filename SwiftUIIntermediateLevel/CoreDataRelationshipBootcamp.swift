//
//  CoreDataRelationshipBootcamp.swift
//  SwiftUIIntermediateLevel
//
//  Created by Denys Nikolaichuk on 22.03.2023.
//

import SwiftUI
import CoreData



class CoreDataRelationshipViewModel: ObservableObject {
    var container: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { descr, error in
            if let error = error {
                print("Error loading core data. \(error)")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching. \(error)")
        }
    }
    
    func addFruits(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func deleteFruit(index: IndexSet) {
        guard let index = index.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func updateFruit(entity: FruitEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch {
            print("Error saving. \(error)")
        }
    }
}

struct CoreDataRelationshipBootcamp: View {
    @StateObject var viewModel = CoreDataRelationshipViewModel()
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Add fruit here...", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color(.gray.withAlphaComponent(0.4)))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    guard !textFieldText.isEmpty else { return }
                    viewModel.addFruits(text: textFieldText)
                    textFieldText = ""
                } label: {
                    Text("Button")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.pink)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                List {
                    ForEach(viewModel.savedEntities) { entity in
                        Text(entity.name ?? "No Name")
                            .onTapGesture {
                                viewModel.updateFruit(entity: entity)
                            }
                    }
                    .onDelete(perform: viewModel.deleteFruit)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Fruits")
        }
    }
}

struct CoreDataRelationshipBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipBootcamp()
    }
}
