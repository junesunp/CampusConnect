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
  
    //@Published var currentGroup = Group(id:"", Created:Date.now, Updated:Date.now, Name:"", Description:"", Recruiter: , Students: [DocumentReference]())
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
        let docRefs = group.Actives
        if docRefs.count == 0 {
            self.students = [Student]()
            return
        }
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
    
    func addStudent(group: Group, studentId: String) {
        let studentDocRef = db.collection("Student").document(studentId)
        let groupDocRef = db.collection("Group").document(group.id!)
        groupDocRef.updateData([
            "Students": FieldValue.arrayUnion([studentDocRef])
        ])
        
        studentDocRef.updateData([
            "Groups": FieldValue.arrayUnion([groupDocRef])
        ])
        fetchStudents(group: group)
    }
    
    
    func deactivateGroup(group: Group){
        if let docID = group.id{
            do{
                try db.collection("Group").document(docID).updateData(["Active": false])
            }
            catch {
                print(error)
            }
        }
    }
    
    func activateGroup(group: Group){
        if let docID = group.id{
            do{
                try db.collection("Group").document(docID).updateData(["Active": true])
            }
            catch {
                print(error)
            }
        }
    }
    
    /*func deactivateStudent(student: Student, group: Group){
        db.collection("Group").document(group.id).updateData(["Actives": FieldValue.arrayRemove([group.id])
                           ])
    }
     */
    
    func clearStudents() {
        self.students = [Student]()
    }
}
