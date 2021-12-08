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
    let db = Firestore.firestore()
    @Published var students = [Student]()
    @Published var activeGroups = [Group]()
    @Published var inactiveGroups = [Group]()
    @Published var user: Student = Student(id: "", Email:"", First:"", Last:"", Grad:"", Major:"", Phone:"", School:"", Password:"", Groups: [])
    var errorMessage = ""
    var correctUserType = false
    
    func verifyLoginEmail(email: String, role: String) {
        let temp = db.collection(role).whereField("Email", isEqualTo: email)
            temp.getDocuments { (documents, error) in
                if let error = error as NSError? {
                    self.errorMessage = "Error getting document"
                }
                else{
                    self.correctUserType = documents!.documents.count == 1
                }
        }
    }
    
    func fetchStudents() {
        self.students.removeAll()
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
        let docRefs = db.collection("Student").whereField("Email", isEqualTo: currID)
        docRefs.getDocuments { (documents, error) in
            if let error = error as NSError? {
                self.errorMessage = "Error getting document"
            }
            else {
                for document in documents!.documents {
                    if document == document{
                    do {
                        self.user = try document.data(as: Student.self)!
                        self.getActiveGroups(number: 1, student: self.user)
                        self.getInactiveGroups(number: 1, student: self.user)

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
    
    
    func fetchRecruiterGroups(number: Int) {
        db.collection("Group").whereField("Recruiter", isEqualTo: db.collection("Recruiter").document("\(user.id!)")).whereField("Active", isEqualTo: true).addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
        self.activeGroups = documents.compactMap { queryDocumentSnapshot -> Group? in
          return try? queryDocumentSnapshot.data(as: Group.self)
        }
      }
      if number == 1{
          activeGroups.sort(by: sorterForAlphabetical)
      }
      else{
          activeGroups.sort(by: sorterForTimeStamp)
      }
    }
    

    func getActiveGroups(number: Int, student: Student) {
        self.inactiveGroups.removeAll()
        
        db.collection("Group").whereField("Actives", arrayContains: db.collection("Student").document("\(student.id!)")).whereField("Active", isEqualTo: true).addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
        self.activeGroups = documents.compactMap { queryDocumentSnapshot -> Group? in
          return try? queryDocumentSnapshot.data(as: Group.self)
        }
      }
      if number == 1{
          activeGroups.sort(by: sorterForAlphabetical)
      }
      else{
          activeGroups.sort(by: sorterForTimeStamp)
      }
    }
    
    func getInactiveGroups(number: Int, student: Student) {
        self.inactiveGroups.removeAll()
        
        db.collection("Group").whereField("Inactives", arrayContains: db.collection("Student").document("\(student.id!)")).whereField("Active", isEqualTo: false).addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
        self.inactiveGroups = documents.compactMap { queryDocumentSnapshot -> Group? in
          return try? queryDocumentSnapshot.data(as: Group.self)
        }
      }
      if number == 1{
          activeGroups.sort(by: sorterForAlphabetical)
      }
      else{
          activeGroups.sort(by: sorterForTimeStamp)
      }
    }
        
    /*
        for group in self.user.Groups{
            let docRef = group
            print(docRef)
            docRef.getDocument { document, error in
                if let error = error as NSError? {
                    self.errorMessage = "Error getting document: \(error.localizedDescription)"
                }
                else {
                    if let document = document {
                        do{
                            let temp = try document.data(as: Group.self)
                            if ((temp!.Active) == true){
                                self.activeGroups.append(temp!)
                            }
                            if ((temp!.Active) == false){
                                self.inactiveGroups.append(temp!)
                            }
                        }
                        catch {
                            print(error)
                        }
                    }
                }
            }
        }
        if number == 1{
            activeGroups.sort(by: sorterForAlphabetical)
            inactiveGroups.sort(by: sorterForAlphabetical)

        }
        else{
            activeGroups.sort(by: sorterForTimeStamp)
            inactiveGroups.sort(by: sorterForTimeStamp)
        }
    }
    */
    
    func addStudent(student: Student){
        do {
            try db.collection("Student").addDocument(from: student)
        }
        catch {
            print(error)
        }
    }
    
    func createStudent(id: String, email: String, password: String, fname: String, lname: String, schoolName: String, major: String, gradYear: String){
        db.collection("Student").document(id).setData([
            "Email": email,
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


