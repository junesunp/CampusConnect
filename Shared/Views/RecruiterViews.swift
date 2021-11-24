//
//  RecruiterViews.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/2/21.
//

import SwiftUI

struct RecruiterViews: View {
  
//  @ObservedObject var stuViewModel = StudentsViewModel()
//  @ObservedObject var recViewModel = RecruitersViewModel()
  @EnvironmentObject var stuViewModel: StudentsViewModel
  @EnvironmentObject var recViewModel: RecruitersViewModel
  
//  init(){
//    stuViewModel.fetchStudents()
//    //stuViewModel.fetchStudent(email:stuViewModel.user.Email)
//    //recViewModel.fetchRecruiter()
//  }
  
    var body: some View {
      TabView{
          
          List {
              NavigationLink("Add Group", destination: CreateGroup())
              .tabItem {
                  Image(systemName: "list.bullet")
              }
              Text(stuViewModel.user.Email)
              Text(stuViewModel.user.First)
              Text(stuViewModel.user.Last)
          }
          .navigationBarItems(trailing: Button(action: {
          })
          {
              Image(systemName: "plus")
                  .resizable()
                  .padding(6)
                  .frame(width: 24, height: 24)
                  .background(Color.blue)
                  .clipShape(Circle())
                  .foregroundColor(.white)
          })
          
          QRCode()
          .tabItem {
              Image(systemName: "qrcode.viewfinder")
          }
          RecruiterProfile()
          .tabItem {
              Image(systemName: "person.crop.circle")
          }
          
      }
    }
}

