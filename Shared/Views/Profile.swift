//
//  Profile.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/2/21.
//
import SwiftUI

struct Profile: View {
    
    @EnvironmentObject var stuViewModel: StudentsViewModel
    @EnvironmentObject var sviewModel: AppViewModel
    
    var body: some View {
        VStack{
            
            HStack {
                Text(stuViewModel.user.First + " " + stuViewModel.user.Last)
                    .fontWeight(.bold)
            }.padding()
            
            HStack {
                Text("School:")
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
                Text(stuViewModel.user.School)
                    .padding(.trailing)
            }.padding()
            
            HStack {
                Text("Class:")
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
                Text(stuViewModel.user.Grad)
                    .padding(.trailing)
            }.padding()
            
            HStack {
                Text("Major:")
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
                Text(stuViewModel.user.Major)
                    .padding(.trailing)
            }.padding()
            
            HStack {
                Text("Email:")
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
                Text(stuViewModel.user.Email)
                    .padding(.trailing)
            }.padding()
            
            HStack {
                Text("Phone:")
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
                Text(stuViewModel.user.Phone)
                    .padding(.trailing)
            }.padding()
            Button(action: {
                sviewModel.signOut()
            }, label: {
                Text("Logout")
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50)
                    .cornerRadius(8)
                    .background(Color.blue)
            })
            
        }
    }
}
