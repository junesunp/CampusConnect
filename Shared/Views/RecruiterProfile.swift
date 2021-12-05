//
// RecruiterProfile.swift
// CampusConnect (iOS)
//
// Created by Andy Park on 11/2/21.
//
import SwiftUI
struct RecruiterProfile: View {
    @EnvironmentObject var stuViewModel: StudentsViewModel
    @EnvironmentObject var recViewModel: RecruitersViewModel
    @EnvironmentObject var sviewModel: AppViewModel
    @State private var editRecProfileSheet = false
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button("Edit") {
                    editRecProfileSheet.toggle()
                }
                .sheet(isPresented: $editRecProfileSheet) {
                    RecEditProfile(rec: recViewModel.user)
                }.padding().padding()
            }
            HStack {
                Text(recViewModel.user.First + " " + recViewModel.user.Last).font(.title)
                    .fontWeight(.bold)
            }.padding()
            HStack {
                Text("Company:")
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
                Text(recViewModel.user.Company)
                    .padding(.trailing)
            }.padding()
            HStack {
                Text("Position:")
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
                Text(recViewModel.user.Position)
                    .padding(.trailing)
            }.padding()
            HStack {
                Text("Email:")
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
                Text(recViewModel.user.Email)
                    .padding(.trailing)
            }.padding()
            HStack {
                Text("Phone:")
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
                Text(recViewModel.user.Phone)
                    .padding(.trailing)
            }.padding()
            Spacer()
            Button(action: {
                sviewModel.role = "Student"
                stuViewModel.correctUserType = false
                sviewModel.signOut()
            }, label: {
                Text("Logout")
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50)
                    .cornerRadius(8)
                    .background(Color.blue)
            }).padding().padding()
        }
    }
}
