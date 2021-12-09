// StudentsViewModel.swift
// NetworkApp
// Created by John Park on 10/19/21
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
    @Published var user: Student = Student(id: "", Email:"", First:"", Last:"", Grad:"", Major:"", Phone:"", School:"", Password:"", Picture: "", Groups: [])
    var profilePicture = UIImage(named: "")
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
                            print(self.user)
                            self.getActiveGroups(number: 1)
                            self.getInactiveGroups(number: 1)
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
    
    
    func getActiveGroups(number: Int) {
        
        activeGroups.removeAll()
        
        db.collection("Group").whereField("Actives", arrayContains: db.collection("Student").document("\(self.user.id!)")).whereField("Active", isEqualTo: true).addSnapshotListener { (querySnapshot, error) in
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
    
    func updateGroups(number: Int) {
        activeGroups = [Group]()
        getActiveGroups(number: number)
        inactiveGroups = [Group]()
        getInactiveGroups(number: number)
    }
    
    func getInactiveGroups(number: Int) {
        inactiveGroups.removeAll()
        
        db.collection("Group").whereField("Actives", arrayContains: db.collection("Student").document("\(self.user.id!)")).whereField("Active", isEqualTo: false).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.inactiveGroups = documents.compactMap { queryDocumentSnapshot -> Group? in
                return try? queryDocumentSnapshot.data(as: Group.self)
            }
            print(documents)
            print(self.inactiveGroups)
        }
        
        
        /*
         db.collection("Group").whereField("Inactives", arrayContains: db.collection("Student").document("\(self.user.id!)")).whereField("Active", isEqualTo: true).addSnapshotListener { (querySnapshot, error) in
         guard let documents = querySnapshot?.documents else {
         print("No documents")
         return
         }
         self.inactiveGroups.append( contentsOf: documents.compactMap { queryDocumentSnapshot -> Group? in
         return try? queryDocumentSnapshot.data(as: Group.self)
         })
         print(documents)
         print(self.inactiveGroups)
         }
         */
        
    }
    
    
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
            "Picture": "",
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
    
    func setProfileImage(profpic: UIImage, id: String) {
        db.collection("Student").document(id).updateData([
            "Picture": profpic.jpegData(compressionQuality: 0.1)!.base64EncodedString()
        ])
    }
    /*
    func fetchProfileImage(id: String){
        //@Binding var result: UIImage
        //@State var temp: String
        let docRefs = db.collection("Student").whereField("id", isEqualTo: id)
        docRefs.getDocuments { (documents, error) in
            @State var result: UIImage
            @State var temp: String
            if let error = error as NSError? {
                self.errorMessage = "Error getting document"
            }
            else {
                for document in documents!.documents {
                    if document == document{
                        do {
                            let dataDescription = document.data()
                            temp = "\(dataDescription["Picture"]!)"
                            print(temp)
                            if temp == ""{
                                self.profilePicture = nil
                            }
                            else{
                                if let data = Data(base64Encoded: temp, options: .ignoreUnknownCharacters){
                                    self.profilePicture = (UIImage(data: data)!)
                                }
                            }
                     
                        }
                        catch {
                            print(error)
                        }
                    }
                }
            }
        }
    }
     */
    
    
    func createQRCode(from string: String) -> UIImage{
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 4, y: 4)
        if let outputImage = filter.outputImage?.transformed(by: transform) {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    func deleteGroup(group: Group) {
        
    }
    
    func editStudent(stu: Student, school: String = "", major: String = "", grad: String = "", email: String = "", phone: String = "") -> String {
        if school != "" && major != "" && grad != "" && email != "" && phone != ""{
            db.collection("Student").document("\(stu.id!)").updateData([
                "School": school,
                "Major": major,
                "Grad": grad,
                "Email": email,
                "Phone": phone
            ])
        }
        else if school != "" && major != "" && grad != "" && email != "" && phone == ""{
            db.collection("Student").document("\(stu.id!)").updateData([
                "School": school,
                "Major": major,
                "Grad": grad,
                "Email": email
            ])
        }
        else if school == "" && major != "" && grad != "" && email == "" && phone == ""{
            db.collection("Student").document("\(stu.id!)").updateData([
                "Major": major,
                "Grad": grad
            ])
        }
        else if school != "" && major != "" && grad != "" && email != "" && phone == ""{
            db.collection("Student").document("\(stu.id!)").updateData([
                "Email": email,
                "Phone": phone
            ])
        }
        else if school != "" && major == "" && grad == "" && email != "" && phone == ""{
            db.collection("Student").document("\(stu.id!)").updateData([
                "School": school,
                "Email": email
            ])
        }
        else if school != "" && major == "" && grad == "" && email == "" && phone == ""{
            db.collection("Student").document("\(stu.id!)").updateData([
                "School": school
            ])
        }
        if school == "" && major != "" && grad == "" && email == "" && phone == ""{
            db.collection("Student").document("\(stu.id!)").updateData([
                "Major": major
            ])
        }
        if school == "" && major == "" && grad != "" && email == "" && phone == ""{
            db.collection("Student").document("\(stu.id!)").updateData([
                "Grad": grad
            ])
        }
        if school == "" && major == "" && grad == "" && email != "" && phone == ""{
            db.collection("Student").document("\(stu.id!)").updateData([
                "Email": email
            ])
        }
        if school == "" && major == "" && grad == "" && email == "" && phone != ""{
            db.collection("Student").document("\(stu.id!)").updateData([
                "Phone": phone
            ])
        }
        if email != "" {
            return email;
        } else {
            return stu.Email;
        }
    }
}


