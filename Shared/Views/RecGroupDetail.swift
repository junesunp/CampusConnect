//
//  RecGroupDetail.swift
//  CampusConnect (iOS)
//
//  Created by Thomas Choi on 11/4/21.
//

import SwiftUI

struct RecGroupDetail: View {
  @ObservedObject var groupViewModel = GroupsViewModel()
    var group: Group
  var students: [Student]
  let width = UIScreen.main.bounds.width * 0.75
  //let groupRecruiter: Recruiter
    
  var body: some View {
    NavigationView {
        List{
            ForEach(students) { student in
                NavigationLink(destination: RecStudentDetail(student: student)) {
                    RecStudentRow(student: student)
                }
            }
        }

    }.navigationBarTitle(group.Name)
//      .navigationBarItems(trailing:
//        NavigationLink(destination: Scanner(group: group)) {
//            Image(systemName: "plus")
//        }
//      )
  }
}
