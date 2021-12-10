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
//            Text("QR Code" )
//                .font(.largeTitle)
//                .fontWeight(.bold)
						Text(stuViewModel.user.First + " " + stuViewModel.user.Last)
						.font(.largeTitle)
						.fontWeight(.bold)
//            Text(stuViewModel.user.Grad + " | " + stuViewModel.user.Major)
//                .fontWeight(.bold)
//								.frame(alignment: .center)
//            Text(stuViewModel.user.Major)
//                .fontWeight(.bold)
            Image(uiImage: stuViewModel.createQRCode(from: stuViewModel.user.Email))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .overlay(
                    Rectangle()
                        .stroke(Color.blue, lineWidth: 10)
//                        .shadow(radius: 5)
//                        .cornerRadius(24)
                )
								.padding()
//						Text("SCAN ME!")
//						.font(.largeTitle)
//						.fontWeight(.bold)
//						.foregroundColor(Color.blue)
							Text(stuViewModel.user.Grad + " | " + stuViewModel.user.Major)
							.fontWeight(.bold)
							.font(.headline)
							.frame(alignment: .center)
        }
    }
}
