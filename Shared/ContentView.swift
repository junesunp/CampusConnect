//
//  ContentView.swift
//  Shared
//
//  Created by John Park on 10/28/21.
//

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
            List {
                Text(viewModel.user.Email)
                Text(viewModel.user.First)
                Text(viewModel.user.Last)
            }
            .tabItem {
                Image(systemName: "list.bullet")
            }
            VStack{
                Text("QR Code")
                ForEach(viewModel.students) {
                  student in
                    Image(uiImage: viewModel.createQRCode(from: student.Email))
                }
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
    viewModel.fetchStudents()
    viewModel.fetchStudent()
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
