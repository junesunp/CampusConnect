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
    
  init(){
    recViewModel.fetchRecruiter()
    recViewModel.fetchRecruiterGroups(number: sort)
    
    
  }
  
    var body: some View {
        TabView{
            NavigationView{
                List{
                    ForEach(recViewModel.recruiterGroups){ group in
                        NavigationLink(destination: RecGroupDetail(group: group, students: groupViewModel.students)) {
                            GroupRow(group: group)
                            .onAppear(perform: { groupViewModel.fetchStudents(group: group) })
                            }
                    }
                }.navigationBarTitle(recViewModel.user.First + "'s Groups")
                .onAppear(perform: { groupViewModel.clearStudents() })
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

