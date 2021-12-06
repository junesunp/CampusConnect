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
  let db = Firestore.firestore()
  @Published var activeGroups = [Group]()
  @Published var inactiveGroups = [Group]()
  @Published var user: Recruiter = Recruiter(id: "", Email:"", First:"", Last:"", Phone:"", Company:"", Position:"", Password:"")
  var errorMessage = ""

    func fetchRecruiter(email: String) {
        let docRef = db.collection("Recruiter").whereField("Email", isEqualTo: email)
        docRef.getDocuments { (documents, error) in
            if let error = error as NSError? {
                self.errorMessage = "Error getting document: \(error.localizedDescription)"
            }
            else {
                for document in documents!.documents {
                if document == document {
                    do{
                        self.user = try document.data(as: Recruiter.self)!
                        self.fetchRecruiterGroups(number: 1)
                        self.fetchInactiveGroups(number: 1)
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
    
    func fetchInactiveGroups(number: Int) {
        db.collection("Group").whereField("Recruiter", isEqualTo: db.collection("Recruiter").document("\(user.id!)")).whereField("Active", isEqualTo: false).addSnapshotListener { (querySnapshot, error) in
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
    
 
    
    func updateGroups(number: Int) {
      activeGroups = [Group]()
        fetchRecruiterGroups(number: number)
      inactiveGroups = [Group]()
        fetchInactiveGroups(number: number)
    }
    
    
    func recCreateGroup(name: String, des: String?){
        var recRef: DocumentReference? = nil
        let docRef = db.collection("Recruiter").document("\(user.id!)")
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
        if name != "" && des != "" {
          db.collection("Group").document("\(curGroup.id!)").updateData([
                "DateUpdated": Date.now,
                "Name": name,
                "Description": des
              ])
        }
        else if name == "" && des != "" {
          db.collection("Group").document("\(curGroup.id!)").updateData([
                "DateUpdated": Date.now,
                "Description": des
              ])
        }
        else if name != "" && des == "" {
          db.collection("Group").document("\(curGroup.id!)").updateData([
                "DateUpdated": Date.now,
                "Name": name
              ])
          print("IN HERE **************")
        }
      }

    func editRecruiter(rec: Recruiter, company: String = "", pos: String = "", email: String = "", phone: String = "") -> String {
        if company != "" && pos != "" && email != "" && phone != ""{
          db.collection("Recruiter").document("\(rec.id!)").updateData([
                "Company": company,
                "Position": pos,
                "Email": email,
                "Phone": phone
              ])
        }
        else if company != "" && pos != "" && email != "" && phone == ""{
          db.collection("Recruiter").document("\(rec.id!)").updateData([
                "Company": company,
                "Position": pos,
                "Email": email
              ])
        }
        else if company == "" && pos != "" && email != "" && phone == ""{
          db.collection("Recruiter").document("\(rec.id!)").updateData([
                "Position": pos,
                "Email": email
              ])
        }
        else if company != "" && pos == "" && email == "" && phone == ""{
          db.collection("Recruiter").document("\(rec.id!)").updateData([
                "Company": company,
              ])
        }
        else if company == "" && pos != "" && email == "" && phone == ""{
          db.collection("Recruiter").document("\(rec.id!)").updateData([
                "Position": pos,
              ])
        }
        else if company == "" && pos == "" && email != "" && phone == ""{
          db.collection("Recruiter").document("\(rec.id!)").updateData([
                "Email": email,
              ])
        }
        else if company == "" && pos == "" && email == "" && phone != ""{
          db.collection("Recruiter").document("\(rec.id!)").updateData([
                "Phone": phone
              ])
        }
        if email != "" {
          return email;
        } else {
          return rec.Email;
        }
      }



    
    func createRecruiter(id: String, email: String, password: String, fname: String, lname: String, company: String, role: String){
        db.collection("Recruiter").document(id).setData([
            "Email": email,
            "FName": fname,
            "LName": lname,
            "Position": role,
            "Company": company,
            "Password": password,
            "Phone": "123-456-1890",
        ])
        { err in
                if let err = err {
                        print("Error writing document: \(err)")
                      
                } else {
                        print("Document successfully written!")
        }
        }
    }
  
    
}
