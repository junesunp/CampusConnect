//
//  RecruitersViewModel.swift
//  CampusConnect
//
//  Created by Thomas Choi on 11/2/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import CoreImage.CIFilterBuiltins
import SwiftUI
import CoreMedia

class RecruitersViewModel: ObservableObject{
    let currentRecID = "dU7IlGMa71WUHBmDFMhS"
    let db = Firestore.firestore()
    @Published var groups = [Group]()
//    @Published var group: Group = Group(id:"asbd" , Created:Date.now, Updated:Date.now, Name:"asbd", Description:"asbd", Recruiter:"asbd", Students:[Student]())
    @Published var user: Recruiter = Recruiter(id: "asbd", Email:"asdf", First:"asdf", Last:"asdf", Phone:"asdf", Company:"asdf", Position:"asdf", Password:"asdf")
    var errorMessage = ""
    
    
    func fetchRecruiter() {
      let docRef = db.collection("Recruiter").document(currentRecID)
      docRef.getDocument { document, error in
        if let error = error as NSError? {
        self.errorMessage = "Error getting document: \(error.localizedDescription)"
        }
        else {
          if let document = document {
            let id = document.documentID
            let data = document.data()
            let Email = data?["Email"] as? String ?? ""
            let First = data?["First"] as? String ?? ""
            let Last = data?["Last"] as? String ?? ""
            let Phone = data?["Phone"] as? String ?? ""
            let Company = data?["Company"] as? String ?? ""
            let Position = data?["Position"] as? String ?? ""
            let Password = data?["Password"] as? String ?? ""
            
            
            
              self.user = Recruiter(id:id, Email:Email, First:First, Last:Last, Phone:Phone, Company:Company, Position:Position, Password:Password)
          }
        }
      }
    }
    
    func fetchGroups() {
        db.collection("Group").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.groups = documents.compactMap { queryDocumentSnapshot -> Group? in
                return try? queryDocumentSnapshot.data(as: Group.self)
            }
            print(self.groups)
        }
    }
    
//    func fetchGroup() {
//      let docRef = db.collection("Group").document(currentRecID)
//      docRef.getDocument { document, error in
//        if let error = error as NSError? {
//        self.errorMessage = "Error getting document: \(error.localizedDescription)"
//        }
//        else {
//          if let document = document {
//            let id = document.documentID
//            let data = document.data()
//            let Created = data?["Created"] as? Date ?? Date.now
//            let Updated = data?["Updated"] as? Date ?? Date.now
//            let Name = data?["Name"] as? String ?? ""
//            let Description = data?["Description"] as? String ?? ""
//            let Recruiter = data?["Recruiter"] as? String ?? ""
//            let Students = data?["Students"] as? [Student] ?? [Student]()
//
//
//
//            self.group = Group(id:id , Created:Created, Updated:Updated, Name:Name, Description:Description, Recruiter:Recruiter, Students:Students)
//          }
//        }
//      }
//    }
    
}
