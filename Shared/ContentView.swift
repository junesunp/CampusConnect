//
//  ContentView.swift
//  Shared
//
//  Created by John Park on 10/28/21.
//


import SwiftUI
import FirebaseAuth


struct ContentView: View {
    let auth = Auth.auth()
    @EnvironmentObject var sviewModel: AppViewModel
    @EnvironmentObject var stuViewModel: StudentsViewModel
    @EnvironmentObject var recViewModel: RecruitersViewModel
    @EnvironmentObject var groupViewModel: GroupsViewModel
    var userCode: String {
        if sviewModel.signedIn{
            stuViewModel.fetchStudent(currID: sviewModel.userID)
            
        }
        return ""
    }
    
  
    var body: some View {
        // TODO: Add way to check user role 
        if sviewModel.signedIn{
            if sviewModel.role == "Students"{
                StudentViews()
            }
            else{
                RecruiterViews()
            }
        }
        else{
            LogInViews()
        }
      }

}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(AppViewModel())
      .environmentObject(StudentsViewModel())
      .environmentObject(RecruitersViewModel())
      .environmentObject(GroupsViewModel())
  }
}

