//
//  QRCode.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/2/21.
//

import SwiftUI

struct QRCode: View {
  
  @ObservedObject var viewModel = StudentsViewModel()
  
  init(){
    viewModel.fetchStudents()
    viewModel.fetchStudent()
  }
  
    var body: some View {
      VStack{
          Text("QR Code")
            .fontWeight(.bold)
        Image(uiImage: viewModel.createQRCode(from: viewModel.user.Email))
            .resizable()
            .aspectRatio(contentMode: .fit)
          }
    }
}
