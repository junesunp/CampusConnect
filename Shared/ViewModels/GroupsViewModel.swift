//
//  GroupsViewModel.swift
//  CampusConnect (iOS)
//
//  Created by Thomas Choi on 11/3/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import CoreImage.CIFilterBuiltins
import SwiftUI
import CoreMedia
class GroupsViewModel: ObservableObject{
  let db = Firestore.firestore()
  @Published var students = [Student]()
  @Published var myGroups = [Group]()
  @Published var user: Student = Student(id: "", Email:"", First:"", Last:"", Grad:"", Major:"", Phone:"", School:"", Password:"", Groups: [])
  var errorMessage = ""
    
}
