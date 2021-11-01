//
//  Student.swift
//  NetworkApp
//
//  Created by John Park on 10/19/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

struct Student: Identifiable, Codable {
    
  @DocumentID var id: String? = UUID().uuidString
  var Email: String
  var First: String
  var Last: String
  var Grad: String
  var Major: String
  var Phone: String
  var School: String
  var Password: String
    
  enum CodingKeys: String, CodingKey {
    case id
    case Email
    case First = "FName"
    case Last = "LName"
    case Major
    case Phone
    case School
    case Grad
    case Password
  }
    
}
