//
//  StudentViews.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/2/21.
//

import SwiftUI

struct StudentViews: View {
    
    @EnvironmentObject var stuViewModel: StudentsViewModel
    @EnvironmentObject var groupViewModel: GroupsViewModel
    @State var sort: Int = 2
    @State var searchText = ""
    
    var searchResults: [Group] {
        if searchText.isEmpty {
            return stuViewModel.myGroups
        }
        else {
            return stuViewModel.myGroups.filter { $0.Name.contains(searchText) }
        }
    }
    
    var body: some View {
        TabView{
            NavigationView{
                List{
                    ForEach(searchResults, id: \.self){ group in
                        NavigationLink(destination: GroupDetail(group: group, groupRecruiter: groupViewModel.viewedGroupRecruiter).onAppear(perform: { groupViewModel.getRecruiter(group: group) })) {
                            GroupRow(group: group)
                        }
                    }
                }.navigationBarTitle(stuViewModel.user.First + "'s Groups")
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
