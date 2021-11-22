//
//  RecGroupDetail.swift
//  CampusConnect (iOS)
//
//  Created by Thomas Choi on 11/4/21.
//

import SwiftUI
import FirebaseFirestore

struct RecGroupDetail: View {
  @ObservedObject var groupViewModel = GroupsViewModel()
  var group: Group
  let width = UIScreen.main.bounds.width * 0.75
    

  var body: some View {
      Section(header: Text(group.Name).font(.headline)){
          if groupViewModel.students.count == 0 {
              Text("No students in group")
          }
          
          else {
              VStack{
                  List{
                      ForEach(groupViewModel.students) { student in
                          NavigationLink(destination: RecStudentDetail(student: student, group: group)) {
                              RecStudentRow(student: student)
                          }
                          
                      }
                      
                  }
              }
              
          }
      }.onAppear(perform: {groupViewModel.fetchStudents(group: group) } )
       .navigationBarItems(trailing:
        NavigationLink(destination: Scanner(group: group)) {
          Image(systemName: "plus")
        }
       )
      Spacer()
      if group.Active{
          Button(action: { groupViewModel.deactivateGroup(group: group) }){
              Text("Deactivate Group").foregroundColor(Color(.red))
                  .frame(width: 600, height: 100)
                  .background(Color(.clear))
          }
      }
      if !group.Active{
          Button(action: { groupViewModel.activateGroup(group: group) }){
              Text("Activate Group").foregroundColor(Color(.green))
                  .frame(width: 600, height: 100)
                  .background(Color(.clear))
          }
      }
  }
}
