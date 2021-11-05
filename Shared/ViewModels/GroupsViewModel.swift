//
// GroupsViewModel.swift
// CampusConnect (iOS)
//
// Created by Thomas Choi on 11/3/21.
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
 @Published var myGroups = [Recruiter]()
 @Published var viewedGroupRecruiter = Recruiter(id: "", Email:"", First:"", Last:"", Phone:"", Company:"", Position:"", Password:"")
  @Published var user: Student = Student(id: "", Email:"", First:"", Last:"", Grad:"", Major:"", Phone:"", School:"", Password:"", Groups: [])
 var errorMessage = ""
  
 func getRecruiter(group: Group) {
    let docRef = group.Recruiter
    docRef.getDocument { document, error in
      if let error = error as NSError? {
        self.errorMessage = "Error getting document"
      }
      else{
        if let document = document {
          do{
            let recruiter = try document.data(as: Recruiter.self)
            self.viewedGroupRecruiter = recruiter!
          }
          catch{
            print(error)
          }
        }
      }
    }
  }
    
    func fetchStudents(group: Group) {
        let docRefs = group.Students
        for student in docRefs {
            let docRef = student
            docRef.getDocument { document, error in
                if let error = error as NSError? {
                    self.errorMessage = "Error getting document: \(error.localizedDescription)"
                }
                else {
                    if let document = document {
                        do {
                            let temp = try document.data(as: Student.self)
                            self.students.append(temp!)
                        }
                        catch {
                            print(error)
                        }
                    }
                }
            }
        }
    }
    
    func clearStudents() {
        self.students = [Student]()
    }
}
