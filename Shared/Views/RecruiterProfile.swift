//
//  RecruiterProfile.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/2/21.
//

import SwiftUI

struct RecruiterProfile: View {
  
  @ObservedObject var viewModel = StudentsViewModel()
  @ObservedObject var recViewModel = RecruitersViewModel()
  
  init(){
    viewModel.fetchStudents()
    viewModel.fetchStudent()
    recViewModel.fetchRecruiter()
  }
  
    var body: some View {
      VStack{
        
        HStack {
          Text(recViewModel.user.First + " " + recViewModel.user.Last)
            .fontWeight(.bold)
        }.padding()
        
        HStack {
          Text("Organization:")
            .fontWeight(.bold)
            .padding(.leading)
          Spacer()
          Text(recViewModel.user.Company)
            .padding(.trailing)
        }.padding()
        
        HStack {
          Text("Position:")
            .fontWeight(.bold)
            .padding(.leading)
          Spacer()
          Text(recViewModel.user.Position)
            .padding(.trailing)
        }.padding()
        
        HStack {
          Text("Email:")
            .fontWeight(.bold)
            .padding(.leading)
          Spacer()
          Text(recViewModel.user.Email)
            .padding(.trailing)
        }.padding()
        
        HStack {
          Text("Cell:")
            .fontWeight(.bold)
            .padding(.leading)
          Spacer()
          Text(recViewModel.user.Phone)
            .padding(.trailing)
        }.padding()
        
      }
      
    }
}
