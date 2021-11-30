//
// StudentsViewModel.swift
// NetworkApp
//
// Created by John Park on 10/19/21.
//
import Foundation
import Firebase
import FirebaseFirestore
import CoreImage.CIFilterBuiltins
import SwiftUI
import CoreMedia
class StudentsViewModel: ObservableObject{
  let currentStudentID = "C8V5BI0KYdqWT5xnpUy9"
  let db = Firestore.firestore()
  @Published var students = [Student]()
  @Published var myGroups = [Group]()
  @Published var user: Student = Student(id: "", Email:"", First:"", Last:"", Grad:"", Major:"", Phone:"", School:"", Password:"", Groups: [])
  var errorMessage = ""
    
  func fetchStudents() {
    db.collection("Student").addSnapshotListener { (querySnapshot, error) in
      guard let documents = querySnapshot?.documents else {
        print("No documents")
        return
      }
      self.students = documents.compactMap { queryDocumentSnapshot -> Student? in
        return try? queryDocumentSnapshot.data(as: Student.self)
      }
    }
  }
  func fetchStudent() {
   let docRef = db.collection("Student").document(currentStudentID)
   docRef.getDocument { document, error in
    if let error = error as NSError? {
     self.errorMessage = "Error getting document"
    }
    else {
     if let document = document {
      do {
        self.user = try document.data(as: Student.self)!
        self.getStudentGroups(number: 1)
      }
      catch {
       // print(error)
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
      func getStudentGroups(number: Int) {
          for group in self.user.Groups{
            let docRef = group
            docRef.getDocument { document, error in
              if let error = error as NSError? {
                self.errorMessage = "Error getting document: \(error.localizedDescription)"
              }
              else {
               if let document = document {
                 do{
                   let temp = try document.data(as: Group.self)
                   self.myGroups.append(temp!)
                 }
                 catch {
                   // print(error)
                 }
               }
              }
            }
          }
          if number == 1{
              myGroups.sort()
            for item in myGroups {
              print(item.Name)
            }
          }
          else{
              myGroups.sort()
          }
    }

    
  func addStudent(student: Student){
    do {
      try db.collection("Student").addDocument(from: student)
    }
    catch {
      // print(error)
    }
  }

    
  func createQRCode(from string: String) -> UIImage{
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    let data = Data(string.utf8)
    filter.setValue(data, forKey: "inputMessage")
    let transform = CGAffineTransform(scaleX: 5, y: 5)
    if let outputImage = filter.outputImage?.transformed(by: transform) {
      if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
        return UIImage(cgImage: cgimg)
      }
    }
    return UIImage(systemName: "xmark.circle") ?? UIImage()
  }
    func deleteGroup(group: Group) {
        
    }
}


