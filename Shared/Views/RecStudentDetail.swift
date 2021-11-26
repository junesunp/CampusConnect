//
//  RecStudentDetail.swift
//  CampusConnect (iOS)
//
//  Created by Thomas Choi on 11/5/21.
//


import SwiftUI

struct RecStudentDetail: View {
    @ObservedObject var groupViewModel = GroupsViewModel()
    var student: Student
    
    let width = UIScreen.main.bounds.width * 0.75
    //let groupRecruiter: Recruiter
      
    var body: some View {
        VStack {
            HStack {
                Text("School:")
                  .fontWeight(.bold)
                  .padding(.leading)
                Spacer()
                Text(student.School)
                      .padding(.trailing)
              }
            Spacer().frame(height: 5)
            HStack {
                Text("Class:")
                  .fontWeight(.bold)
                  .padding(.leading)
                Spacer()
                Text(student.Grad)
                      .padding(.trailing)
              }
            Spacer().frame(height: 5)
            HStack {
                Text("Major:")
                  .fontWeight(.bold)
                  .padding(.leading)
                Spacer()
                Text(student.Major)
                      .padding(.trailing)
              }
            Spacer().frame(height: 5)
            HStack {
                Text("Email:")
                  .fontWeight(.bold)
                  .padding(.leading)
                Spacer()
                Text(student.Email)
                  .padding(.trailing)
              }
            Spacer().frame(height: 5)
            HStack {
                Text("Phone:")
                  .fontWeight(.bold)
                  .padding(.leading)
                Spacer()
                Text(student.Phone)
                  .padding(.trailing)
              }
            Spacer().frame(height: 5)
            
        }.navigationBarTitle(student.First + " " + student.Last)
    }
}
