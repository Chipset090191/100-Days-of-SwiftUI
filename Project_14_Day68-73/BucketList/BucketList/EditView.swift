//
//  EditView.swift
//  BucketList
//
//  Created by Михаил Тихомиров on 30.07.2023.
//

import SwiftUI

struct EditView: View {
    
    enum LoadingState {   // that`s enum of states when we work with wikipidia
        case loading, loaded, failed
    }
    
    @Environment (\.dismiss) var dismiss
    var location:Location
    var onSave: (Location) -> Void
    
    @State private var name:String
    @State private var description: String
    
    @State private var loadingState = LoadingState.loading   // our default state
    @State private var pages = [Page]()
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
                
                
                Section("Nearby...") {
                    switch loadingState {
                    case .loading:
                        Text("loading...")
                    case .loaded:
                        ForEach(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)            
                                .italic()
                        }
                    case .failed:
                        Text ("Please try again later")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button ("Save") {
                    var newLocation = location
                    newLocation.id = UUID()                     // we update our id so as change our Annotation`s data
                    newLocation.name = name
                    newLocation.description = description
                    
                    onSave(newLocation)
                    
                    dismiss()
                }
            }
        }
        .task {
            await fetchNearbyPlaces()
        }
    }
    
    init(location:Location, onSave: @escaping (Location)-> Void) {
        self.location = location
        self.onSave = onSave
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
    
    func fetchNearbyPlaces() async{
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        guard let url = URL(string: urlString) else {
            print ("Bad URL: \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
//            pages = items.query.pages.values.sorted { $0.title < $1.title} // we assign all sorted values(our pages) to the Array with type "Page"
            pages = items.query.pages.values.sorted() // we add comparable to our struct Page and static func "less" so we do not need to use inline closure here
            loadingState = .loaded
        } catch {
            loadingState = .failed
        }
    }
    
    
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { _ in } // - we ignore the value here
    }
}
