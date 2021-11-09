//
//  StudentViews.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/2/21.
//

import SwiftUI

struct StudentViews: View {
    
    @ObservedObject var viewModel = StudentsViewModel()
    @State var sort: Int = 1
    init(){
        viewModel.fetchStudents()
        viewModel.fetchStudent()
        viewModel.getStudentGroups(number: sort)
    }
    
    var body: some View {
        TabView{
            NavigationView{
                Text("Hello World!")
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
                    
                    ForEach(viewModel.myGroups){ group in
                        NavigationLink(destination: GroupDetail(group: group)) {
                            GroupRow(group: group)
                        }
                    }
                }.navigationBarTitle(viewModel.user.First + "'s Groups")
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
