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
        Text("Hello World")

      }
    }
  
    @ObservedObject var viewModel = StudentsViewModel()
    var body: some View {
      List {
        ForEach(viewModel.students) {
          student in
            studentRowView(student: student)
        }
      }
      Text("Hello World")
    }
  
  init(){
    viewModel.fetchData()
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
