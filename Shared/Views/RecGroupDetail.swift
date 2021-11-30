//
// RecGroupDetail.swift
// CampusConnect (iOS)
//
// Created by Thomas Choi on 11/4/21.
//
import SwiftUI
import FirebaseFirestore
struct RecGroupDetail: View {
    @EnvironmentObject var groupViewModel : GroupsViewModel
    var group: Group
    let width = UIScreen.main.bounds.width * 0.75
    @State private var editGroupSheet = false
    var body: some View {
        VStack {
            if groupViewModel.students.count == 0 {
                Text("No students in group")
            }
            else {
                //Text("Group Information").font(.title3)
                Section(header: Text("Group Information")){
                    Spacer().frame(height: 10)
                    HStack{
                        Text("No. of Students:").fontWeight(.bold)
                            .padding(.leading)
                        Spacer()
                        Text("\(groupViewModel.students.count)")
                            .padding(.trailing)
                    }
                    Spacer().frame(height: 5)
                    HStack{
                        Text("Last Updated:").fontWeight(.bold)
                            .padding(.leading)
                        Spacer()
                        Text(group.Updated, format: .dateTime.month().day().year())
                            .padding(.trailing)
                    }
                }
                List{
                    ForEach(groupViewModel.students) { student in
                        NavigationLink(destination: RecStudentDetail(student: student, group: group)) {
                            RecStudentRow(student: student)
                        }
                    }
                }
            }
        }.navigationBarTitle(group.Name)
            .onAppear(perform: {groupViewModel.fetchStudents(group: group) } )
            .navigationBarItems(trailing:
                                    HStack{
                NavigationLink(destination: Scanner(group: group)) {
                    Image(systemName: "plus")
                };
                Button("Edit") {
                    editGroupSheet.toggle()
                }
                .sheet(isPresented: $editGroupSheet) {
                    RecEditGroup(group: group)
                }
            }
            )
        Spacer()
        if group.Active{
            Button(action: { groupViewModel.deactivateGroup(group: group) }){
                Text("Deactivate Group").foregroundColor(Color(.red))
                    .frame(width: 600, height: 100)
                    .background(Color(.clear))
            }
        }
        if !group.Active{
            Button(action: { groupViewModel.activateGroup(group: group) }){
                Text("Activate Group").foregroundColor(Color(.green))
                    .frame(width: 600, height: 100)
                    .background(Color(.clear))
            }
        }
    }
}
