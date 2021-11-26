//
//  StudentViews.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/2/21.
//

import SwiftUI

struct StudentViews: View {
    
<<<<<<< HEAD
    //@ObservedObject var viewModel = StudentsViewModel()
    //@ObservedObject var groupViewModel = GroupsViewModel()
    @EnvironmentObject var stuViewModel: StudentsViewModel
    @EnvironmentObject var groupViewModel: GroupsViewModel
    
    @State var sort: Int = 1
//    init(){
//        stuViewModel.fetchStudents()
//        //stuViewModel.fetchStudent(email: stuViewModel.user.Email)
//        stuViewModel.getStudentGroups(number: sort)
//    }
=======
    @ObservedObject var viewModel = StudentsViewModel()
    @ObservedObject var groupViewModel = GroupsViewModel()
    @State var sort: Int = 2
    
    init(){
        viewModel.fetchStudents()
        viewModel.fetchStudent()
        viewModel.getStudentGroups(number: sort)
    }
>>>>>>> stage
    
    var body: some View {
        TabView{
            NavigationView{
                List{
<<<<<<< HEAD
                    
                    ForEach(stuViewModel.myGroups){ group in
=======
                    ForEach(viewModel.myGroups){ group in
>>>>>>> stage
                        NavigationLink(destination: GroupDetail(group: group, groupRecruiter: groupViewModel.viewedGroupRecruiter)) {
                            GroupRow(group: group)
                            .onAppear(perform: { groupViewModel.getRecruiter(group: group) })
                        }
                    }
<<<<<<< HEAD
                }.navigationBarTitle(stuViewModel.user.First + "'s Groups")
=======
                }.navigationBarTitle(viewModel.user.First + "'s Groups")
>>>>>>> stage
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Menu {
                            Picker(selection: $sort, label: Text("Sorting options")) {
                                Text("Date").tag(1)
                                Text("Alphabetical").tag(2)
                            }
<<<<<<< HEAD
                            .onAppear(perform : {stuViewModel.getStudentGroups(number: sort)})
=======
>>>>>>> stage
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
