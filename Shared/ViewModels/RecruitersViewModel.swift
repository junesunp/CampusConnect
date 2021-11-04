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
            self.fetchRecruiterGroups()
          }
          catch {
            print(error)
          }
        }
      }
    }
  }
  func fetchRecruiterGroups() {
    db.collection("Group").whereField("Recruiter", isEqualTo: db.collection("Recruiter").document(currentRecID)).addSnapshotListener { (querySnapshot, error) in
      guard let documents = querySnapshot?.documents else {
        print("No documents")
        return
      }
      self.recruiterGroups = documents.compactMap { queryDocumentSnapshot -> Group? in
        return try? queryDocumentSnapshot.data(as: Group.self)
      }
      print("hELLOOO")
      print("")
      print(self.recruiterGroups)
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
