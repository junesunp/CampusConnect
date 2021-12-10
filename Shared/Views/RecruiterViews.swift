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
    @State var searchText = ""
    @State var createGroupSheet = false
    
    var sortResults: [Group] {
        if searchText.isEmpty {
            if sort == 1{
                return recViewModel.activeGroups.sorted()
            }
            else if sort == 2 {
                return recViewModel.activeGroups.sorted(by: { $0.Created < $1.Created } )
            }
            else if sort == 3 {
                return recViewModel.activeGroups.sorted(by: { $0.Updated < $1.Updated } )
            }
            else{
                return recViewModel.activeGroups.sorted() // default alphabetical
            }
        }
        else {
            return recViewModel.activeGroups.filter { $0.Name.contains(searchText) }
        }
    }
    
    var body: some View {
        
        TabView{
            NavigationView{
                ZStack{
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
                        .searchable(text: $searchText)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) { // <3>
                                                VStack {
                                                    Text("Campus Connect").font(.title)
                                                }
                                            }
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
                    //}
                  }
                }
            }
            .tabItem {
                Image(systemName: "list.bullet")
            }
            RecruiterProfile(image: Image(uiImage: UIImage(data: Data(base64Encoded: recViewModel.user.Picture, options: .ignoreUnknownCharacters)!) ?? UIImage()) )
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }

            
        }.onAppear(perform: {
            UITabBar.appearance().barTintColor = .blue
               })
    }
}

