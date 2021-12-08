
// EditProfile.swift
// CampusConnect (iOS)
//
// Created by Thomas Choi on 12/2/21.
//
import SwiftUI
struct EditProfile: View {
    var stu: Student
    @State var school = ""
    @State var major = ""
    @State var grad = ""
    @State var email = ""
    @State var phone = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var stuViewModel : StudentsViewModel
    var body: some View {
        VStack {
            Spacer()
            Text("Edit Profile").font(.title)
            Text(stu.First + " " + stu.Last).font(.subheadline)
            TextField("School", text: $school)
                .padding()
                .background(Color(.secondarySystemBackground))
            TextField("Major", text: $major)
                .padding()
                .background(Color(.secondarySystemBackground))
            TextField("Graduation Year", text: $grad)
                .padding()
                .background(Color(.secondarySystemBackground))
            TextField("Email", text: $email)
                .padding()
                .background(Color(.secondarySystemBackground))
            TextField("Phone", text: $phone)
                .padding()
                .background(Color(.secondarySystemBackground))
            Spacer()
            Button (action: {
                stuViewModel.fetchStudent(currID: stuViewModel.editStudent(stu: stu, school: school, major: major, grad: grad, email: email, phone: phone));
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
