//
//  GroupDetail.swift
//  CampusConnect (iOS)
//
//  Created by Thomas Choi on 11/3/21.
//

import SwiftUI

struct GroupDetail: View {

  var group: Group
  let width = UIScreen.main.bounds.width * 0.75
  let groupRecruiter: Recruiter

  var body: some View {
    VStack {
        HStack {
            Text("Recruiter:")
              .fontWeight(.bold)
              .padding(.leading)
            Spacer()
            Text(group.Description)
              .padding(.trailing)
          }
        HStack {
            Text("Contact Info:")
              .fontWeight(.bold)
              .padding(.leading)
            Spacer()
            VStack {
                Text("email")
                  .padding(.trailing)
                Text("phone number")
                  .padding(.trailing)
            }
          }

      HStack {
        Text("Description:")
          .fontWeight(.bold)
          .padding(.leading)
        Spacer()
        Text(group.Description)
          .padding(.trailing)
      }.padding()
    }.navigationBarTitle(group.Name)
  }
}
