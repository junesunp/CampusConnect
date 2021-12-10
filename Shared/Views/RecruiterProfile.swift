//
// RecruiterProfile.swift
// CampusConnect (iOS)
//
// Created by Andy Park on 11/2/21.
//
import SwiftUI
struct RecruiterProfile: View {
    @EnvironmentObject var stuViewModel: StudentsViewModel
    @EnvironmentObject var recViewModel: RecruitersViewModel
    @EnvironmentObject var sviewModel: AppViewModel
    
    @State var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var editRecProfileSheet = false
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
                }).padding()
                Spacer()
                Button("Edit") {
                    editRecProfileSheet.toggle()
                }
                .sheet(isPresented: $editRecProfileSheet) {
                    RecEditProfile(rec: recViewModel.user)
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
                Text(recViewModel.user.First + " " + recViewModel.user.Last).font(.title)
                    .fontWeight(.bold)
            }.padding()
            HStack {
                Text("Company:")
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
                Text(recViewModel.user.Company)
                    .padding(.trailing)
            }.padding()
            HStack {
                Text("Position:")
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
                Text(recViewModel.user.Position)
                    .padding(.trailing)
            }.padding()
            HStack {
                Text("Email:")
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
                Text(recViewModel.user.Email)
                    .padding(.trailing)
            }.padding()
            HStack {
                Text("Phone:")
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
                Text(recViewModel.user.Phone)
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
        recViewModel.setProfileImage(profpic: inputImage, id: recViewModel.user.id!)
    }
}
