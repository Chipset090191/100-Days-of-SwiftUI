//
//  DetailScreen.swift
//  ImagesFromaLibrary
//
//  Created by Михаил Тихомиров on 14.08.2023.
//

import SwiftUI

struct DetailScreen: View {
    
    @State private var localname:String
    
    @Environment (\.dismiss) var dismiss
    
    var image: Image
    var imagedata: Data
    var name: String
    var key: String
    

    var onSaveAndAppear:(Images, Unrapped_Info) -> Void
    
    
    var body: some View {
        NavigationView{
            VStack {
                    Section {
                        TextField("name of file", text: $localname)
                            .italic()
                    }
                
                
                ZStack {

                    image
                        .resizable()
                        .scaledToFill()
                    
                }
                
                
                
                
                
            }
            .padding([.horizontal, .vertical])
            .toolbar {
                Button(key == "c" ? "Save" : "Update"){
                    let new_elementOnSave = Images(id: UUID(), filename: localname, imagedata: imagedata)
                    let new_element_OnAppear = Unrapped_Info(id: UUID(), filename: localname, image: image, imagedata: imagedata)
                    onSaveAndAppear(new_elementOnSave, new_element_OnAppear)
                    
                    dismiss()
                }
                .disabled(localname == "" ? true : false)
            }
            .navigationTitle("Detail Info")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
    
    
    init(image: Image, imagedata: Data, name: String, key:String, onSaveAndAppear: @escaping (Images, Unrapped_Info) -> Void) {
        self.image = image
        self.imagedata = imagedata
        self.name = name
        self.key = key
        self.onSaveAndAppear = onSaveAndAppear
        
        _localname = State(initialValue: name)
    }
    

}



struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreen(image: Image("Test"),imagedata: Data(), name: "Test_name", key: "e") { _,_ in }
    }
}
