//
// RecEditProfile.swift
// CampusConnect (iOS)
//
// Created by Thomas Choi on 12/2/21.
//
import SwiftUI
struct RecEditProfile: View {
    var rec: Recruiter
    @State var company = ""
    @State var position = ""
    @State var email = ""
    @State var phone = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var recViewModel : RecruitersViewModel
    var body: some View {
        VStack {
            Spacer()
            Text("Editing your Profile").font(.title)
            Text(rec.First + " " + rec.Last).font(.subheadline)
            TextField("Company", text: $company)
                .padding()
                .background(Color(.secondarySystemBackground))
            TextField("Position", text: $position)
                .padding()
                .background(Color(.secondarySystemBackground))
            TextField("Email", text: $email)
                .padding()
                .background(Color(.secondarySystemBackground))
            TextField("Phone", text: $phone)
                .padding()
                .background(Color(.secondarySystemBackground))
            Spacer()
            Spacer()
            Button (action: {
                recViewModel.fetchRecruiter(email: recViewModel.editRecruiter(rec: rec, company: company, pos: position, email: email, phone: phone));
                dismiss()
            }, label: {
                Text("Done Editing")
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50)
                    .cornerRadius(8)
                    .background(Color.blue)
            }).padding().padding()
        }
        .padding()
        //Spacer()
    }
}
