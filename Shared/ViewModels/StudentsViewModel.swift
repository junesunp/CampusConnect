//
//  StudentsViewModel.swift
//  NetworkApp
//
//  Created by John Park on 10/19/21.
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
    @Published var user: Student = Student(id: "asbd", Email:"asdf", First:"asdf", Last:"asdf", Grad:"asdf", Major:"asdf", Phone:"asdf", School:"asdf", Password:"asdf")
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
            print(self.students)
        }
    }

        
    func fetchStudent() {
      let docRef = db.collection("Student").document(currentStudentID)
      docRef.getDocument { document, error in
        if let error = error as NSError? {
        self.errorMessage = "Error getting document: \(error.localizedDescription)"
        }
        else {
          if let document = document {
            let id = document.documentID
            let data = document.data()
            let Email = data?["Email"] as? String ?? ""
            let First = data?["FName"] as? String ?? ""
            let Last = data?["LName"] as? String ?? ""
            let Grad = data?["Grad"] as? String ?? ""
            let Major = data?["Major"] as? String ?? ""
            let Phone = data?["Phone"] as? String ?? ""
            let School = data?["School"] as? String ?? ""
            let Password = data?["Password"] as? String ?? ""
         
            self.user = Student(id:id, Email:Email, First:First, Last:Last, Grad:Grad, Major:Major, Phone:Phone, School:School, Password:Password)
          }
        }
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
