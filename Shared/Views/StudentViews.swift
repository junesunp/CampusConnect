//
//  StudentViews.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/2/21.
//

import SwiftUI

struct StudentViews: View {
    
    @ObservedObject var viewModel = StudentsViewModel()
    @ObservedObject var groupViewModel = GroupsViewModel()
    @State var sort: Int = 2
    
    init(){
        viewModel.fetchStudents()
        viewModel.fetchStudent()
        viewModel.getStudentGroups(number: sort)
    }
    
    var body: some View {
        TabView{
            NavigationView{
                List{
                    ForEach(viewModel.myGroups){ group in
                        NavigationLink(destination: GroupDetail(group: group, groupRecruiter: groupViewModel.viewedGroupRecruiter)) {
                            GroupRow(group: group)
                            .onAppear(perform: { groupViewModel.getRecruiter(group: group) })
                        }
                    }
                }.navigationBarTitle(viewModel.user.First + "'s Groups")
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
            QRCode()
                .tabItem {
                    Image(systemName: "qrcode.viewfinder")
                }
            Profile()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }
            
        }
    }
}
