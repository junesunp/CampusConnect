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
            Text(groupRecruiter.First + " " + groupRecruiter.Last)
                  .padding(.trailing)
        }.padding()
        HStack {
            Text("Company:")
              .fontWeight(.bold)
              .padding(.leading)
            Spacer()
            Text(groupRecruiter.Company)
                  .padding(.trailing)
        }.padding()
        HStack {
            Text("Position:")
              .fontWeight(.bold)
              .padding(.leading)
            Spacer()
            Text(groupRecruiter.Position)
                  .padding(.trailing)
        }.padding()
        HStack {
            Text("Email:")
              .fontWeight(.bold)
              .padding(.leading)
            Spacer()
            Text(groupRecruiter.Email)
              .padding(.trailing)
        }.padding()
        HStack {
            Text("Phone:")
              .fontWeight(.bold)
              .padding(.leading)
            Spacer()
            Text(groupRecruiter.Phone)
              .padding(.trailing)
        }.padding()
        Spacer()
        /*
            HStack {
                Text("Description:")
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
                Text(group.Description)
                    .padding(.trailing)
            } */
    }.navigationBarTitle(group.Name)
  }
}
