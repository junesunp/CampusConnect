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
	
  let db = Firestore.firestore()
  @Published var students = [Student]()
  @Published var myGroups = [Group]()
  @Published var user: Student = Student(Email:"", First:"", Last:"", Grad:"", Major:"", Phone:"", School:"", Password:"", Groups: [])
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
	func fetchStudent(currID: String) {
	 let docRef = db.collection("Student").whereField("email", isEqualTo: currID)
   docRef.getDocuments { (snapshot, error) in
	 if let error = error as NSError? {
     self.errorMessage = "Error getting document"
    }
    else {
			for document in snapshot!.documents {
				if document == document {
				do {
					let dataDescription = document.data()
					print("\(dataDescription["id"])")
					print("\(dataDescription["email"])")
					self.user.id = "\(dataDescription["id"])"
					self.user.Email = "\(dataDescription["email"])"
					self.user.First = "\(dataDescription["FName"])"
					self.user.Last = "\(dataDescription["LName"])"
					self.user.Grad = "\(dataDescription["Grad"])"
					self.user.Major = "\(dataDescription["Major"])"
					self.user.School = "\(dataDescription["School"])"
					let currGroups = dataDescription["Groups"] as! Array<DocumentReference>
					self.user.Groups = currGroups
					self.getStudentGroups(number: 1)
				}
				catch {
				 print(error)
				}
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
	
	func createStudent(id: String, email: String, password: String, username: String, fname: String, lname: String, schoolName: String, major: String, gradYear: String){
		db.collection("Student").addDocument(data: [
			"id": id,
			"email": email,
			"FName": fname,
			"LName": lname,
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

}


