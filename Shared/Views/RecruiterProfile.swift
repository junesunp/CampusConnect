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
          Text(recViewModel.user.Email)
            .fontWeight(.bold)
        }.padding()
        
      }
      
    }
}
