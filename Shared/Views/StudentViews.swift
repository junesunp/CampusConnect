//
//  StudentViews.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/2/21.
//

import SwiftUI

struct StudentViews: View {
    
    @ObservedObject var viewModel = StudentsViewModel()
    
    init(){
        viewModel.fetchStudents()
        viewModel.fetchStudent()
    }
    
    var body: some View {
        TabView{
            NavigationView{
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
