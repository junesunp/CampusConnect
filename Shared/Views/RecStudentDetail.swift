//
//  RecStudentDetail.swift
//  CampusConnect (iOS)
//
//  Created by Thomas Choi on 11/5/21.
//


import SwiftUI

struct RecStudentDetail: View {
    
    @EnvironmentObject var groupViewModel : GroupsViewModel
    @State var studentDescription = "Enter Notes on Applicant"

    var student: Student
    var group: Group
        
    let width = UIScreen.main.bounds.width * 0.75
      
    private func hideKeyboardAndSave() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        //x save()
    }
    
    //private func save() {
        
     //   groupViewModel.db.collection("Group").document(group.id!).updateData(["Notes" : FieldValue.arrayUnion([student.id! : studentDescription])])
    //}
    
    var body: some View {
        VStack {
            Spacer().frame(height: 6)
            HStack {
                Text("School:")
                  .fontWeight(.bold)
                  .padding(.leading)
                Spacer()
                Text(student.School)
                      .padding(.trailing)
              }
            HStack {
                Text("Class:")
                  .fontWeight(.bold)
                  .padding(.leading)
                Spacer()
                Text(student.Grad)
                      .padding(.trailing)
              }
            HStack {
                Text("Major:")
                  .fontWeight(.bold)
                  .padding(.leading)
                Spacer()
                Text(student.Major)
                      .padding(.trailing)
              }
            HStack {
                Text("Email:")
                  .fontWeight(.bold)
                  .padding(.leading)
                Spacer()
                Text(student.Email)
                  .padding(.trailing)
              }
            HStack {
                Text("Phone:")
                  .fontWeight(.bold)
                  .padding(.leading)
                Spacer()
                Text(student.Phone)
                  .padding(.trailing)
              }
            TextEditor(text: $studentDescription)
                .foregroundColor(.secondary)
                .padding(.horizontal)
                .navigationTitle("Notes")
                .onTapGesture {}

        }.navigationBarTitle(student.First + " " + student.Last)
         .onTapGesture { hideKeyboardAndSave() }



        

        NavigationLink(destination: RecGroupDetail(group: group)){
            Text("Remove Student from Group").foregroundColor(Color(.red))
            
        }.simultaneousGesture(TapGesture().onEnded{ groupViewModel.deactivateStudent(student: student, group: group) } )
        /*
        Button(action: { groupViewModel.deactivateStudent(student: student, group: group) } ){
            Text("Remove Student from Group").foregroundColor(Color(.green))
                .frame(width: 600, height: 100)
                .background(Color(.clear))
        }
         */
        Spacer()
    }
    
}
