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
    
    func updateGroups(number: Int) {
      recruiterGroups = [Group]()
        fetchRecruiterGroups(number: number)
    }
    
    
    func recCreateGroup(name: String, des: String?){
        var recRef: DocumentReference? = nil
        let docRef = db.collection("Recruiter").document(currentRecID)
        recRef = db.document("Recruiter/" + docRef.documentID)
        
        var ref: DocumentReference? = nil
        ref = db.collection("Group").addDocument(data: [
            "Active": true,
            "DateCreated": Date.now,
            "DateUpdated": Date.now,
            "Name": name,
            "Description": des ?? "",
            "Recruiter": recRef,
            "Students": [DocumentReference]()
        ])
    }
    
    func recEditGroup(curGroup: Group, name: String = "", des: String = "") {
        let docRef = db.collection("Group").document(curGroup.id!)
        let strDocRef = "\(docRef)"
        if name != "" && des != "" {
            db.collection("Group").document(strDocRef).updateData([
                        "DateUpdated": Date.now,
                        "Name": name,
                        "Description": des
                    ])
        }
        else if name == "" && des != "" {
            db.collection("Group").document(strDocRef).updateData([
                        "DateUpdated": Date.now,
                        "Description": des
                    ])
        }
        else if name != "" && des == "" {
            db.collection("Group").document(strDocRef).updateData([
                        "DateUpdated": Date.now,
                        "Name": name
                    ])
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
