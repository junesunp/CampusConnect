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
          }
        Spacer().frame(height: 5)
        HStack {
            Text("Company:")
              .fontWeight(.bold)
              .padding(.leading)
            Spacer()
            Text(groupRecruiter.Company)
                  .padding(.trailing)
          }
        Spacer().frame(height: 5)
        HStack {
            Text("Position:")
              .fontWeight(.bold)
              .padding(.leading)
            Spacer()
            Text(groupRecruiter.Position)
                  .padding(.trailing)
          }
        Spacer().frame(height: 5)
        HStack {
            Text("Email:")
              .fontWeight(.bold)
              .padding(.leading)
            Spacer()
            Text(groupRecruiter.Email)
              .padding(.trailing)
          }
        Spacer().frame(height: 5)
        HStack {
            Text("Phone:")
              .fontWeight(.bold)
              .padding(.leading)
            Spacer()
            Text(groupRecruiter.Phone)
              .padding(.trailing)
          }
        Spacer().frame(height: 5)
        
    }.navigationBarTitle(group.Name)
  }
}
