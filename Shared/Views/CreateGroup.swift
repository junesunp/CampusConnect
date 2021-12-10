//
//  CreateGroup.swift
//  CampusConnect (iOS)
//
//  Created by Obi Nnaeto on 11/9/21.
//

import SwiftUI

struct CreateGroup: View {
    //var group: Group
    @State var name = ""
    @State var description = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var recViewModel : RecruitersViewModel
    
    var body: some View {
        VStack {
            Text("Create Group").font(.title)
            TextField("Group Name", text: $name)
                .padding()
                .background(Color(.secondarySystemBackground))
            TextField("Description", text: $description)
                .padding()
                .background(Color(.secondarySystemBackground))
            Spacer()

            Button (action: {
                recViewModel.recCreateGroup(name: name, des: description);
                dismiss()
            }, label: {
                Text("Create Group")
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50)
                    .cornerRadius(8)
                    .background(Color.blue)
            })
                .cornerRadius(8)
        }
        .padding()
        //Spacer()
    }
}

struct CreateGroup_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroup()
    }
}
