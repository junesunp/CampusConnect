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
import FirebaseAuth
class StudentsViewModel: ObservableObject{
	var currentStudentID: String = "Test"
  let db = Firestore.firestore()
	//let currUser = Auth.auth().currentUser
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
//	 let curSID = student.id
//	 let currID = "\(curSID)"
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
                 print(error)
               }
             }
            }
          }
        }
        if number == 1{
            myGroups.sort(by: sorterForAlphabetical)
        }
        else{
            myGroups.sort(by: sorterForTimeStamp)
        }
  }
  

  func addStudent(student: Student){
    do {
      try db.collection("Student").addDocument(from: student)
    }
    catch {
      print(error)
    }
  }
	
	func createStudent(email: String, password: String, username: String, fname: String, lname: String, schoolName: String, major: String, gradYear: String){
		db.collection("Student").document(username).setData([
			"email": email,
			"first": fname,
			"last": lname,
			"Grad": gradYear,
			"Major": major,
			"School": schoolName,
			"Password": password,
			"Phone": "123-456-1890",
			"Groups": [Group]()
		])
		{ err in
				if let err = err {
						print("Error writing document: \(err)")
					  
				} else {
						print("Document successfully written!")
					  self.user = Student(id: email, Email:email, First:fname, Last:lname, Grad:gradYear, Major:major, Phone:"", School:schoolName, Password:password, Groups: [])
					  self.currentStudentID = "\(self.user.id)"
					  //self.fetchStudent(student: self.user)
		}
		}
	}
    
  

    
  func createQRCode(from string: String) -> UIImage{
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    let data = Data(string.utf8)
    filter.setValue(data, forKey: "inputMessage")
    if let outputImage = filter.outputImage {
      if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
        return UIImage(cgImage: cgimg)
      }
    }
    return UIImage(systemName: "xmark.circle") ?? UIImage()
  }
	
	
//	func getCurrUserID(student: Student){
//		currentStudentID = student.id
//
//	}
}
