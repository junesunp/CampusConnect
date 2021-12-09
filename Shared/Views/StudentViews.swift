//
//  StudentViews.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/2/21.
//

import SwiftUI
import simd

struct StudentViews: View {
    
    @EnvironmentObject var stuViewModel: StudentsViewModel
    @EnvironmentObject var groupViewModel: GroupsViewModel
    @State var sort: Int = 2
    @State var searchText = ""
    
    var searchResults: [Group] {
        if searchText.isEmpty {
            return stuViewModel.activeGroups
        }
        else {
            return stuViewModel.activeGroups.filter { $0.Name.contains(searchText) }
        }
    }
    
    var body: some View {
        TabView{
            NavigationView{
                VStack{
                    List{
                        Section(header: Text("My Active Groups")){
                            ForEach(searchResults, id: \.self){ group in
                                NavigationLink(destination: GroupDetail(group: group, groupRecruiter: groupViewModel.viewedGroupRecruiter).onAppear(perform: { groupViewModel.getRecruiter(group: group) })) {
                                    GroupRow(group: group)
                                }
                            }
                        }
                    }
                    //                    .onAppear(perform: { stuViewModel.getActiveGroups(number: 1) })

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
                    List{
                        Section(header: Text("My Inactive Groups")){
                            ForEach(stuViewModel.inactiveGroups){ group in
                                NavigationLink(destination: GroupDetail(group: group, groupRecruiter: groupViewModel.viewedGroupRecruiter).onAppear(perform: { groupViewModel.getRecruiter(group: group) })) {
                                    GroupRow(group: group)
                                }
                            }
                        }
                    }
                   // .onAppear(perform: { stuViewModel.getInactiveGroups(number: 1) })

                }
            }
            .tabItem {
                Image(systemName: "list.bullet")
            }
            QRCode()
                .tabItem {
                    Image(systemName: "qrcode.viewfinder")
                }
            Profile(image: Image(uiImage: UIImage(data: Data(base64Encoded: stuViewModel.user.Picture, options: .ignoreUnknownCharacters)!) ?? UIImage()) )
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }
            
        }
    }
}
