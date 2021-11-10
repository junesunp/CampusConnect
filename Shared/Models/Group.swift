//
// Group.swift
// CampusConnect
//
// Created by Thomas Choi on 11/2/21.
//
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

struct Group: Identifiable, Codable {
 @DocumentID var id: String? = UUID().uuidString
 var Created: Date
 var Updated: Date
 var Name: String
 var Description: String
 var Recruiter: DocumentReference
 var Students: [DocumentReference]
 enum CodingKeys: String, CodingKey {
  case id
  case Created = "DateCreated"
  case Updated = "DateUpdated"
  case Name
  case Description
  case Recruiter
  case Students
 }
}
