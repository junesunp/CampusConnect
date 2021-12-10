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
	@State var image: Image?
    
  var body: some View {
    VStack {
				image?
				.resizable()
				.scaledToFit()
				.clipShape(Circle())
				.overlay(
						Circle()
								.stroke(Color.white, lineWidth: 4)
								.shadow(radius: 10)
				)
				.padding()
        HStack {
            Text("Recruiter:")
              .fontWeight(.bold)
							.foregroundColor(Color.blue)
              .padding(.leading)
            Spacer()
            Text(groupRecruiter.First + " " + groupRecruiter.Last)
                  .padding(.trailing)
        }.padding()
        HStack {
            Text("Company:")
              .fontWeight(.bold)
							.foregroundColor(Color.blue)
              .padding(.leading)
            Spacer()
            Text(groupRecruiter.Company)
                  .padding(.trailing)
        }.padding()
        HStack {
            Text("Position:")
              .fontWeight(.bold)
							.foregroundColor(Color.blue)
              .padding(.leading)
            Spacer()
            Text(groupRecruiter.Position)
                  .padding(.trailing)
        }.padding()
        HStack {
            Text("Email:")
              .fontWeight(.bold)
							.foregroundColor(Color.blue)
              .padding(.leading)
            Spacer()
            Text(groupRecruiter.Email)
              .padding(.trailing)
        }.padding()
        HStack {
            Text("Phone:")
              .fontWeight(.bold)
							.foregroundColor(Color.blue)
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
