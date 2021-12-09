
//
// RecStudentRow.swift
// CampusConnect (iOS)
//
// Created by Thomas Choi on 11/5/21.
//
import SwiftUI
struct RecStudentRow: View {
    
    var student: Student
    @State var image: Image?

    var body: some View {
        HStack {
            image?
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.black, lineWidth: 4)
                        .shadow(radius: 2)
                )
            Text(student.First + " " + student.Last)
                .fontWeight(.bold)
                .padding(.leading)
        }.padding()
    }
}
