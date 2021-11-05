//
// RecruitersViewModel.swift
// CampusConnect
//
// Created by Thomas Choi on 11/2/21.
//
import Foundation
import Firebase
import FirebaseFirestore
import CoreImage.CIFilterBuiltins
import SwiftUI
import CoreMedia
class RecruitersViewModel: ObservableObject {
  let currentRecID = "dU7IlGMa71WUHBmDFMhS"
  let db = Firestore.firestore()
  @Published var recruiterGroups = [Group]()
  @Published var user: Recruiter = Recruiter(id: "", Email:"", First:"", Last:"", Phone:"", Company:"", Position:"", Password:"")
  //@Published var currentGroup = Group(id:"" , Created:Date.now, Updated:Date.now, Name:"", Description:"", Recruiter: recruiterDocRef, Students:[Student]())
  var errorMessage = ""

  func fetchRecruiter() {
    let docRef = db.collection("Recruiter").document(currentRecID)
    docRef.getDocument { document, error in
      if let error = error as NSError? {
        self.errorMessage = "Error getting document: \(error.localizedDescription)"
      }
      else {
        if let document = document {
          do{
            self.user = try document.data(as: Recruiter.self)!
            self.fetchRecruiterGroups(number: 1)
          }
          catch {
            print(error)
          }
        }
      }
    }
  }
    
    func sorterForAlphabetical(this:Group, that:Group) -> Bool {
        return this.Name < that.Name
    }
    func sorterForTimeStamp(this:Group, that:Group) -> Bool {
      return this.Created < that.Created
    }
    
    
  func fetchRecruiterGroups(number: Int) {
    db.collection("Group").whereField("Recruiter", isEqualTo: db.collection("Recruiter").document(currentRecID)).addSnapshotListener { (querySnapshot, error) in
      guard let documents = querySnapshot?.documents else {
        print("No documents")
        return
      }
      self.recruiterGroups = documents.compactMap { queryDocumentSnapshot -> Group? in
        return try? queryDocumentSnapshot.data(as: Group.self)
      }
    }
    if number == 1{
        recruiterGroups.sort(by: sorterForAlphabetical)
    }
    else{
        recruiterGroups.sort(by: sorterForTimeStamp)
    }
  }
  /*
  func fetchGroup() {
    let docRef = db.collection("Group").document(currentRecID)
    docRef.getDocument { document, error in
      if let error = error as NSError? {
        self.errorMessage = "Error getting document: \(error.localizedDescription)"
      }
      else {
        if let document = document {
          self.
        }
      }
    }
  }
  */
}
