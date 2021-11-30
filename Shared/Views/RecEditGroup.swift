
// RecEditGroup.swift
// CampusConnect (iOS)
//
// Created by Thomas Choi on 11/26/21.
//
import SwiftUI
struct RecEditGroup: View {
    var group: Group
    @State var name = ""
    @State var description = ""
    @Environment(\.dismiss) var dismiss
    @ObservedObject var recViewModel = RecruitersViewModel()
    var body: some View {
        VStack {
            Text("Edit  " + group.Name).font(.title)
            TextField("Group Name", text: $name)
                .padding()
                .background(Color(.secondarySystemBackground))
            TextField("Description", text: $description)
                .padding()
                .background(Color(.secondarySystemBackground))
            Button (action: {
                recViewModel.recEditGroup(curGroup: group, name: name, des: description);
                dismiss()
            }, label: {
                Text("Done Editing")
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50)
                    .cornerRadius(8)
                    .background(Color.blue)
            })
        }
        .padding()
        //Spacer()
    }
}
