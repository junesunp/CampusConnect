//
//  ContentView.swift
//  Shared
//
//  Created by John Park on 10/28/21.
//


import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = StudentsViewModel()
    @ObservedObject var recViewModel = RecruitersViewModel()
  
    var body: some View {
      RecruiterViews()
      // StudentViews()
    }
  
  init(){
    viewModel.fetchStudents()
    viewModel.fetchStudent()
    recViewModel.fetchRecruiter()
  }
}
