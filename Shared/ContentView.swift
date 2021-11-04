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
      StudentViews()
      // Scanner()
    }
  
  init(){
    viewModel.fetchStudents()
    viewModel.fetchStudent()
    recViewModel.fetchRecruiter()
  }
}
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

/*
import SwiftUI
struct ContentView: View {
  private func studentRowView(student: Student) -> some View{
   VStack(alignment: .leading){
    Text(student.First)
    Text(student.Last)
    Text(student.School)
    Text(student.Major)
   }
  }
  @ObservedObject var viewModel = StudentsViewModel()
  var body: some View {
    TabView{
      VStack{
        List {
          Text(viewModel.user.First)
        }
        List{
          ForEach(viewModel.myGroups){
            group in
            Text(group.Name)
            Text(group.Description)
          }
        }
      }
      .tabItem {
        Image(systemName: "list.bullet")
      }
      VStack{
        Text("QR Code")
        Image(uiImage: viewModel.createQRCode(from: viewModel.user.Email))
      }
      .tabItem {
        Image(systemName: "qrcode.viewfinder")
      }
      VStack{
        Text(viewModel.user.First)
        Text(viewModel.user.Last)
        Text(viewModel.user.School)
      }
      .tabItem {
        Image(systemName: "person.crop.circle")
      }
    }
  }
 init(){
   viewModel.fetchStudent()
 }
}
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
*/
