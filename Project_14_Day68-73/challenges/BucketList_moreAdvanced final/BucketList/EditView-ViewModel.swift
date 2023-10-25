//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Михаил Тихомиров on 08.08.2023.
//

import Foundation
import MapKit


extension EditView {
    
    @MainActor class EditViewModel:ObservableObject {
        
        enum LoadingState {   // that`s enum of states when we work with wikipidia
            case loading, loaded, failed
        }
        
        @Published var loadingState = LoadingState.loading   // our default state
        
    }
    
    
}
