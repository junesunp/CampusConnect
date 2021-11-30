//
//  RecruiterViews.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/2/21.
//

import SwiftUI

struct RecruiterViews: View {
  
  @ObservedObject var recViewModel = RecruitersViewModel()
  @ObservedObject var groupViewModel = GroupsViewModel()
  @State var sort: Int = 1
  @State private var createGroupSheet = false
  // @Binding var activeGroups: [Group]
  
  init(){
    recViewModel.fetchRecruiter()
    recViewModel.fetchRecruiterGroups(number: sort)
    recViewModel.fetchInactiveGroups(number: sort)
  }
  
  var sortResults: [Group] {
    if sort == 1{
      return recViewModel.activeGroups.sorted()
    }
    else if sort == 2 {
      return recViewModel.activeGroups.sorted(by: { $0.Created < $1.Created } )
    }
    else if sort == 3 {
      return recViewModel.activeGroups.sorted(by: { $0.Updated < $1.Updated } )
    }
    return recViewModel.activeGroups.sorted() // default alphabetical
  }
  
    var body: some View {
        TabView{
                NavigationView{
                    VStack{
                        List{
                            Section(header: Text("My Active Groups")){
                              ForEach(sortResults, id: \.self){ group in
                                    NavigationLink(destination: RecGroupDetail(group: group)){
                                        GroupRow(group: group)
                                    }
                                }
                            }
                        }
                        .navigationBarItems(trailing:
                                                Button("Create Group") {
                                                    createGroupSheet.toggle()
                                                }
                                                .sheet(isPresented: $createGroupSheet) {
                                                            CreateGroup()
                                                    }
                        )
                        .onAppear(perform: { groupViewModel.clearStudents() })
                        .onAppear(perform: { recViewModel.updateGroups(number: sort) })
                        .toolbar {
                            ToolbarItem(placement: .primaryAction) {
                                Menu {
                                    Picker(selection: $sort, label: Text("Sorting options")) {
                                        Text("Alphabetical").tag(1)
                                        Text("Date Created").tag(2)
                                        Text("Date Updated").tag(3)
                                    }
                                }
                                label: {
                                    Label("Sort", systemImage: "arrow.up.arrow.down")
                                }
                            }
                        }
                        
                        List {
                            Section(header: Text("My Inactive Groups")){
                                ForEach(recViewModel.inactiveGroups){ group in
                                    NavigationLink(destination: RecGroupDetail(group: group)) {
                                        GroupRow(group: group)
                                        .onAppear(perform: { groupViewModel.fetchStudents(group: group) })
                                        }
                                }
                            }
                        }
                        .onAppear(perform: { groupViewModel.clearStudents() })
                        .onAppear(perform: { recViewModel.updateGroups(number: sort) })
                    }
            }
            .tabItem {
                Image(systemName: "list.bullet")
            }
            Profile()
            .tabItem {
                Image(systemName: "person.crop.circle")
            }
            
        }
    }
}

