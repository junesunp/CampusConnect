//
//  StudentsViewModel.swift
//  NetworkApp
//
//  Created by John Park on 10/19/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import CoreImage.CIFilterBuiltins
import SwiftUI

class StudentsViewModel: ObservableObject{
    
  let db = Firestore.firestore()
  @Published var students = [Student]()
    
  func fetchData() {
    db.collection("Student").addSnapshotListener { (querySnapshot, error) in
      guard let documents = querySnapshot?.documents else {
        print("No documents")
        return
      }
      self.students = documents.compactMap { queryDocumentSnapshot -> Student? in
          print(queryDocumentSnapshot.data().values)
          return try? queryDocumentSnapshot.data(as: Student.self)
        }
        print(self.students.count)
    }
  }

  
  func createQRCode(from string: String) -> UIImage{
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    let data = Data(string.utf8)
    filter.setValue(data, forKey: "inputMessage")
    
    if let outputImage = filter.outputImage {
      if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
        return UIImage(cgImage: cgimg)
      }
    }
    return UIImage(systemName: "xmark.circle") ?? UIImage()
  }
  
}
