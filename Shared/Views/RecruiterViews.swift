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
  
  init(){
    recViewModel.fetchRecruiter()
    recViewModel.fetchRecruiterGroups()
    
    
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
                        /*
                        NavigationLink(destination: GroupDetail(group: group, groupRecruiter: groupViewModel.viewedGroupRecruiter)) {
                            GroupRow(group: group)
                            .onAppear(perform: { groupViewModel.getRecruiter(group: group) })
                        } */
                    } //.onDisappear(perform: { groupViewModel.clearStudents() })
                }.navigationBarTitle(recViewModel.user.First + "'s Groups")
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

