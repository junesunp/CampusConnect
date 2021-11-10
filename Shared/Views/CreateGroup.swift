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
    var body: some View {
        NavigationView {
                VStack {
                    TextField("Group Name", text: $name)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    TextField("Description", text: $description)
                        .padding()
                        .background(Color(.secondarySystemBackground))
//                    Button(action: {
//                        guard !email.isEmpty, !password.isEmpty else {
//                            return
//                        }
//                        sviewModel.signUp(email: email, password: password)
//                    }, label: {
//                        Text("Create Group")
//                            .foregroundColor(Color.white)
//                            .frame(width: 200, height: 50)
//                            .cornerRadius(8)
//                            .background(Color.blue)
//                    })
                }
                .padding()
                //Spacer()
            }
            .navigationTitle("Create Group")
    }
}

struct CreateGroup_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroup()
    }
}
