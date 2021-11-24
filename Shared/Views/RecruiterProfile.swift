//
//  RecruiterProfile.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/2/21.
//

import SwiftUI

struct RecruiterProfile: View {
  
//  @ObservedObject var stuViewModel = StudentsViewModel()
//  @ObservedObject var recViewModel = RecruitersViewModel()
  @EnvironmentObject var stuViewModel: StudentsViewModel
  @EnvironmentObject var recViewModel: RecruitersViewModel
  
//  init(){
//    stuViewModel.fetchStudents()
//    //stuViewModel.fetchStudent(email: stuViewModel.user.Email)
//    recViewModel.fetchRecruiter()
//  }
  
    var body: some View {
      VStack{
        
        HStack {
          Text(recViewModel.user.Email)
            .fontWeight(.bold)
        }.padding()
        
      }
      
    }
}
