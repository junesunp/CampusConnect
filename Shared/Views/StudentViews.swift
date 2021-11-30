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
    @State var sort: Int = 1
    @State var searchText = ""
    
    init(){
        viewModel.fetchStudents()
        viewModel.fetchStudent()
        viewModel.getStudentGroups(number: sort)
    }
  
  var searchResults: [Group] {
    if searchText.isEmpty {
      return viewModel.myGroups
    }
    else {
      return viewModel.myGroups.filter { $0.Name.contains(searchText) }
    }
  }
    
    var body: some View {
        TabView{
            NavigationView{
                List{
                  ForEach(searchResults, id: \.self){ group in
                        NavigationLink(destination: GroupDetail(group: group, groupRecruiter: groupViewModel.viewedGroupRecruiter)) {
                            GroupRow(group: group)
                            .onAppear(perform: { groupViewModel.getRecruiter(group: group) })
                        }
                    }
                }.navigationBarTitle(viewModel.user.First + "'s Groups")
                .searchable(text: $searchText)
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
