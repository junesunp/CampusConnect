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
              Text(viewModel.user.Email)
              Text(viewModel.user.First)
              Text(viewModel.user.Last)
          }
          .tabItem {
              Image(systemName: "list.bullet")
          }
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

