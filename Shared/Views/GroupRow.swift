//
//  GroupRow.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/2/21.
//

import SwiftUI

struct GroupRow: View {
    
    var body: some View {
      VStack {
        HStack {
          Text("Name:")
            .fontWeight(.bold)
            .padding(.leading)
          Spacer()
          Text("Facebook") //group.name
            .padding(.trailing)
        }.padding()
      }
    }
}
