//
// QRCode.swift
// CampusConnect (iOS)
//
// Created by Andy Park on 11/2/21.
//
import SwiftUI
struct QRCode: View {
    @EnvironmentObject var stuViewModel : StudentsViewModel
    var body: some View {
        VStack{
            Text("QR Code for " + stuViewModel.user.First + " " + stuViewModel.user.Last)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(stuViewModel.user.Grad)
                .fontWeight(.bold)
            Text(stuViewModel.user.Major)
                .fontWeight(.bold)
            Image(uiImage: stuViewModel.createQRCode(from: stuViewModel.user.Email))
                
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .overlay(
                    Rectangle()
                        .stroke(Color.black, lineWidth: 4)
                        .shadow(radius: 5)
                )
        }
    }
}
