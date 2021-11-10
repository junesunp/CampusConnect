//
//  RecruiterViews.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/2/21.
//

import SwiftUI

struct RecruiterViews: View {
  
  @ObservedObject var viewModel = StudentsViewModel()
  @ObservedObject var recViewModel = RecruitersViewModel()
  
  init(){
    viewModel.fetchStudents()
    viewModel.fetchStudent()
    recViewModel.fetchRecruiter()
  }
  
    var body: some View {
      TabView{
          
          List {
              NavigationLink("Add Group", destination: CreateGroup())
              .tabItem {
                  Image(systemName: "list.bullet")
              }
              Text(viewModel.user.Email)
              Text(viewModel.user.First)
              Text(viewModel.user.Last)
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

