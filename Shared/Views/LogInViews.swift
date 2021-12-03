//
//  LogInViews.swift
//  CampusConnect (iOS)
//
//  Created by Obi Nnaeto on 11/18/21.
//
import SwiftUI
import FirebaseAuth


// different users in your app
enum UserType {
    case recruiter
    case student
}

protocol UserData {
    var userType: UserType { get }
}

struct RecruiterUserData: UserData {
    let userType: UserType = .recruiter
}

struct StudentUserData: UserData {
    let userType: UserType = .student
}


class AppViewModel: ObservableObject {
    let auth = Auth.auth()

    @Published var signedIn = false
    @Published var role = "Students"
    @Published var isStudent = true
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    var userID: String {
        return auth.currentUser!.uid
    }

    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
        guard authResult != nil, error == nil else { return }
          // ...
          DispatchQueue.main.async {
            self?.signedIn = true
          }

        }
    }

    func signUp(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
        guard authResult != nil, error == nil else { return }
        DispatchQueue.main.async {
          self?.signedIn = true
        }
        }
    }
    
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
    }

}

struct LogInViews: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var sviewModel: AppViewModel
    @EnvironmentObject var stuViewModel: StudentsViewModel
    @EnvironmentObject var recViewModel: RecruitersViewModel
    
    @State var asStudent = true
    @State var isSignedIn = true
    
    var body: some View {
            NavigationView {
                VStack {
                    VStack {
                        TextField("Email Address", text: $email)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                        
                        if isSignedIn == false{
                            Text("Incorrect credentials")
                                .padding()
                                .foregroundColor(.red)
                                .background(Color.black)
                                .font(Font.body.bold())
                                .cornerRadius(8)
                            
                        }
                        
                        Toggle("Sign in as..", isOn: $asStudent)
                        .onChange(of: asStudent) { value in
                                        // action...
                            if sviewModel.role == "Students"{
                                        //print(value)
                                sviewModel.role = "Recruiter"
                            }
                            else{
                                sviewModel.role = "Students"
                            }
                        }
                        if asStudent {
                            Text("Student")
                        }
                        else{
                            Text("Recruiter")
                        }
                        Button(action: {
                            guard !email.isEmpty, !password.isEmpty else {
                                return
                            }
                            print("\(email)")
                            
                            //stuViewModel.user = Auth.auth().currentUser
                            sviewModel.signIn(email: email, password: password)
                            if sviewModel.isSignedIn{
                                if sviewModel.role == "Students"{
                                    stuViewModel.fetchStudent(currID: email)
                                    stuViewModel.fetchStudents()
                                }
                                else{
                                    recViewModel.fetchRecruiter(email: email)
                                    stuViewModel.fetchStudents()
                                }
                            }
                            else{
                                self.isSignedIn = false
                            }
                        }, label: {
                            Text("Sign In")
                                .foregroundColor(Color.white)
                                .frame(width: 200, height: 50)
                                .cornerRadius(8)
                                .background(Color.blue)
                        })
                        NavigationLink("Create Account", destination: StartSignUpView())
                    }
                    .padding()
                    
                    Spacer()
                }
                .navigationTitle("Sign In")
            }
        }
}
struct StartSignUpView: View {
    @State var email = ""
    @State var password = ""
    @State var fname = ""
    @State var lname = ""
    var gradYear = ["2022", "2023", "2024", "2025"]
    @State private var selectedYearIndex = 0
    @State var schoolName = ""
    @State var major = ""
    
    
    @EnvironmentObject var sviewModel: AppViewModel
    @EnvironmentObject var stuViewModel: StudentsViewModel
    var body: some View {
        //NavigationView {
//            VStack {
                VStack {
                    TextField("First Name", text: $fname)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    TextField("Last Name", text: $lname)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    TextField("Email Address", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    NavigationLink(destination: SchoolSignUpView(email: $email, password:$password, fname:$fname, lname:$lname)) {
                        Text("I want to be recruited")
                            .padding(15)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(5)
                    }
                    .padding([.leading, .trailing], 30)
                    .padding([.top], 21)
                    .frame(height: 50)
                    .simultaneousGesture(TapGesture().onEnded{
                        sviewModel.role = "Students"
                                    })
                    .padding()
                    .padding()
                    
                    NavigationLink(destination: RecruiterSignUpView(email: $email, password:$password, fname:$fname, lname:$lname)) {
                        Text("I want to be a Recruiter")
                            .padding(15)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.white)
                            .foregroundColor(Color.blue)
                            .cornerRadius(5)
                            .border(Color.black)
                    }
                    .padding([.leading, .trailing], 30)
                    .padding([.top], 21)
                    .frame(height: 50)
                    .simultaneousGesture(TapGesture().onEnded{
                        sviewModel.role = "Recruiter"
                                    })
                    
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        VStack {
                            Text("Create Account").font(.largeTitle).bold()
                            //Text("Subtitle").font(.subheadline)
                        }
                    }}
                .padding()
                //Spacer()
            }
            
            //.navigationTitle("Create Account")
        //}
    }
struct SchoolSignUpView: View {
    @Binding var email : String
    @Binding var password : String
    @Binding var fname : String
    @Binding var lname : String
    @State var major = ""
    var gradYear = ["2022", "2023", "2024", "2025"]
    @State private var selectedYearIndex = 0
    @State var schoolName = ""
    let auth = Auth.auth()
    //@ObservedObject var sviewModel =  AppViewModel()
    @EnvironmentObject var stuViewModel: StudentsViewModel
    @EnvironmentObject var sviewModel: AppViewModel
    var body: some View {
//        NavigationView {
            //VStack {
                VStack {
                    TextField("School", text: $schoolName)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    Picker(selection: $selectedYearIndex, label: Text("")) {
                        ForEach(0 ..< gradYear.count) {
                           Text(self.gradYear[$0])
                        }
                     }
                     Text("Your Graduation Year: \(gradYear[selectedYearIndex])")
                    TextField("major", text: $major)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    Button(action: {
                        stuViewModel.createStudent(id: auth.currentUser!.uid, email: email, password: password, fname: fname, lname: lname, schoolName: schoolName, major: major, gradYear: gradYear[selectedYearIndex])
                        sviewModel.signUp(email: email, password: password)
                        stuViewModel.fetchStudents()
                        stuViewModel.fetchStudent(currID: email)
                    }, label: {
                        Text("Create Account")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    })
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            VStack {
                                Text("Create Account").font(.largeTitle).bold()
                                //Text("Subtitle").font(.subheadline)
                            }
                        }}
                //}
                .padding()
                //Spacer()
            }
    }
}

struct RecruiterSignUpView: View {
    @Binding var email : String
    @Binding var password : String
    @Binding var fname : String
    @Binding var lname : String
    @State var company = ""
    @State var position = ""
    var gradYear = ["2022", "2023", "2024", "2025"]
    @State private var selectedYearIndex = 0
    @State var schoolName = ""
    let auth = Auth.auth()
    //@ObservedObject var sviewModel =  AppViewModel()
    @EnvironmentObject var sviewModel: AppViewModel
    @EnvironmentObject var stuViewModel: StudentsViewModel
    @EnvironmentObject var recViewModel: RecruitersViewModel
    var body: some View {
//        NavigationView {
            //VStack {
                VStack {
                    TextField("Company", text: $company)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    TextField("Position/Role", text: $position)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    Button(action: {
                        recViewModel.createRecruiter(id: auth.currentUser!.uid, email: email, password: password, fname: fname, lname: lname, company: company, role: position)
                        recViewModel.fetchRecruiter(email: email)
                        sviewModel.signUp(email: email, password: password)
                        
                    }, label: {
                        Text("Create Account")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    })
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            VStack {
                                Text("Create Account").font(.largeTitle).bold()
                                //Text("Subtitle").font(.subheadline)
                            }
                        }}
                //}
                .padding()
                //Spacer()
            }
    }
}



struct LogInViews_Previews: PreviewProvider {
    static var previews: some View {
        LogInViews()
            .environmentObject(AppViewModel())
            .environmentObject(StudentsViewModel())
            .environmentObject(RecruitersViewModel())
            .environmentObject(GroupsViewModel())
    }
}
