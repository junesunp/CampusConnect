//
//  RecStudentRow.swift
//  CampusConnect (iOS)
//
//  Created by Thomas Choi on 11/5/21.
//

import SwiftUI

struct RecStudentRow: View {

    var student: Student
    
    var body: some View {
        VStack {
          Text(student.First + " " + student.Last)
            .fontWeight(.bold)
            .padding(.leading)
        }.padding()
    }
}
