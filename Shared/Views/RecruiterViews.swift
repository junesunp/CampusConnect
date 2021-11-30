//
//  RecruiterViews.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/2/21.
//

import SwiftUI

struct RecruiterViews: View {
  
    @EnvironmentObject var stuViewModel: StudentsViewModel
    @EnvironmentObject var recViewModel: RecruitersViewModel
    @EnvironmentObject var groupViewModel : GroupsViewModel
    @State var sort: Int = 2
    @State var createGroupSheet = false
  
    var body: some View {
        TabView{
                NavigationView{
                    VStack{
                        List{
                            Section(header: Text("My Active Groups")){
                                ForEach(recViewModel.activeGroups){ group in
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
                                        Text("Date").tag(1)
                                        Text("Alphabetical").tag(2)
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
            RecruiterProfile()
            .tabItem {
                Image(systemName: "person.crop.circle")
            }
            
        }
    }
}

