//
//  Profile.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/2/21.
//

import SwiftUI

struct Profile: View {
  
  @ObservedObject var viewModel = StudentsViewModel()
  
  init(){
    viewModel.fetchStudents()
    viewModel.fetchStudent()
  }
  
    var body: some View {
      VStack{
        
        HStack {
          Text(viewModel.user.First + " " + viewModel.user.Last)
            .fontWeight(.bold)
        }.padding()
        
        HStack {
          Text("School:")
            .fontWeight(.bold)
            .padding(.leading)
          Spacer()
          Text(viewModel.user.School)
            .padding(.trailing)
        }.padding()
        
        HStack {
          Text("Class:")
            .fontWeight(.bold)
            .padding(.leading)
          Spacer()
          Text(viewModel.user.Grad)
            .padding(.trailing)
        }.padding()
        
        HStack {
          Text("Major:")
            .fontWeight(.bold)
            .padding(.leading)
          Spacer()
          Text(viewModel.user.Major)
            .padding(.trailing)
        }.padding()
      
        HStack {
          Text("Email:")
            .fontWeight(.bold)
            .padding(.leading)
          Spacer()
          Text(viewModel.user.Email)
            .padding(.trailing)
        }.padding()
        
        HStack {
          Text("Phone:")
            .fontWeight(.bold)
            .padding(.leading)
          Spacer()
          Text(viewModel.user.Phone)
            .padding(.trailing)
        }.padding()
        
        
      }
    }
}
