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
<<<<<<< HEAD
	func fetchRecruiter(email: String) {
    let docRef = db.collection("Recruiter").whereField("email", isEqualTo: email)
		//let docRef = db.collection("Recruiter").document(currentRecID)
    //docRef.getDocument { document, error in
		docRef.getDocuments { snapshot, error in
=======

  func fetchRecruiter() {
    let docRef = db.collection("Recruiter").document(currentRecID)
    docRef.getDocument { document, error in
>>>>>>> stage
      if let error = error as NSError? {
        self.errorMessage = "Error getting document: \(error.localizedDescription)"
      }
      else {
				let document = snapshot!.documents.first
        if let document = document {
          do{
            //let dataDescription = document.data()
            self.user = try document.data(as: Recruiter.self)!
<<<<<<< HEAD
						self.fetchRecruiterGroups(currRec: document)
=======
            self.fetchRecruiterGroups(number: 1)
>>>>>>> stage
          }
          catch {
            print(error)
          }
        }
      }
    }
  }
<<<<<<< HEAD
	func fetchRecruiterGroups(currRec: QueryDocumentSnapshot) {
		db.collection("Group").whereField("Recruiter", isEqualTo: db.collection("Recruiter").document(currRec.documentID)).addSnapshotListener { (querySnapshot, error) in
=======
    
    func sorterForAlphabetical(this:Group, that:Group) -> Bool {
        return this.Name < that.Name
    }
    func sorterForTimeStamp(this:Group, that:Group) -> Bool {
      return this.Created < that.Created
    }
    
    
  func fetchRecruiterGroups(number: Int) {
    db.collection("Group").whereField("Recruiter", isEqualTo: db.collection("Recruiter").document(currentRecID)).addSnapshotListener { (querySnapshot, error) in
>>>>>>> stage
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
<<<<<<< HEAD
func createRecruiter(email: String, password: String, username: String, fname: String, lname: String, company: String, role: String){
    db.collection("Recruiter").addDocument(data: [
        "Email": email,
        "Fname": fname,
        "Lname": lname,
        "Postion": role,
        "Company": company,
        "Password": password,
        "Phone": "123-456-1890",
    ])
    { err in
            if let err = err {
                    print("Error writing document: \(err)")
                  
            } else {
                    print("Document successfully written!")
                  //self.user = Student(id: id, Email:email, First:fname, Last:lname, Grad:gradYear, Major:major, Phone:"", School:schoolName, Password:password, Groups: [])
                  print (" HELLLO HELLLO HELOOOOOOOO HHERE I  AMAMAMMAMAMAMA     ")
                  //print("\(self.user.id)")
                  //self.currentStudentID = "\(self.user.id)"
                  //self.fetchStudent(student: self.user)
    }
    }
}
=======
    
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
  
    
>>>>>>> stage
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
