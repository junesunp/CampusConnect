//
//  GroupRow.swift
//  CampusConnect (iOS)
//
//  Created by Andy Park on 11/2/21.
//

import SwiftUI

struct GroupRow: View {
    var group: Group
    
    var body: some View {
        HStack {
            Text(group.Name)
                .fontWeight(.bold)
                .padding(.leading)
                .padding(.trailing)
        }.padding()
    }
}
