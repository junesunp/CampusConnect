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
    VStack {
        List {
            ForEach(students) { student in
                Text(student.First + " " + student.Last)
            }
        }

    }.navigationBarTitle(group.Name)
  }
}
