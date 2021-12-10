//
// Profile.swift
// CampusConnect (iOS)
//
// Created by Andy Park on 11/2/21.
//
import SwiftUI
struct Profile: View {
    @EnvironmentObject var stuViewModel: StudentsViewModel
    @EnvironmentObject var sviewModel: AppViewModel
    @State var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var editProfileSheet = false


    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    sviewModel.role = "Student"
                    stuViewModel.correctUserType = false
                    sviewModel.signOut()
                }, label: {
                    Text("Logout")
                        .foregroundColor(Color.red)
                })

                    .padding()
                Spacer()
                Button("Edit") {
                    editProfileSheet.toggle()
                }
                .sheet(isPresented: $editProfileSheet) {
                    EditProfile(stu: stuViewModel.user)
                }.padding().padding()
            }
            ZStack {
                if image != nil {
                    image?
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 4)
                                .shadow(radius: 10)
                        )
                    
                } else {
                    Circle()
                        .fill(Color.secondary)
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
            }
            .padding()
            .onTapGesture {
                self.showingImagePicker = true
            }
            HStack {
                Text(stuViewModel.user.First + " " + stuViewModel.user.Last)
                    .fontWeight(.bold)
            }.padding()
            HStack {
                Text("School:")
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
                Text(stuViewModel.user.School)
                    .padding(.trailing)
            }.padding()
            HStack {
                Text("Class:")
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
                Text(stuViewModel.user.Grad)
                    .padding(.trailing)
            }.padding()
            HStack {
                Text("Major:")
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
                Text(stuViewModel.user.Major)
                    .padding(.trailing)
            }.padding()
            HStack {
                Text("Email:")
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
                Text(stuViewModel.user.Email)
                    .padding(.trailing)
            }.padding()
            HStack {
                Text("Phone:")
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
                Text(stuViewModel.user.Phone)
                    .padding(.trailing)
            }.padding()
            Spacer()
            Spacer()
        }
        
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
            ImagePicker(image: self.$inputImage)
        }
    }
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        stuViewModel.setProfileImage(profpic: inputImage, id: stuViewModel.user.id!)
    }
}
