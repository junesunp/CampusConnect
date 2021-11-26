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
  @ObservedObject var groupViewModel = GroupViewModel()
  @State var sort: Int = 2
  @State var createGroupSheet = false
  

    var body: some View {
        TabView{
            NavigationView{
                List{
                    ForEach(recViewModel.recruiterGroups){ group in
                        NavigationLink(destination: RecGroupDetail(group: group)) {
                            GroupRow(group: group)
                            .onAppear(perform: { groupViewModel.fetchStudents(group: group) })
                            }
                    }
                }.navigationBarTitle(recViewModel.user.First + "'s Groups")
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

