//
//  User.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//
struct UserResponse: Codable{
    let user: User
    let message: String
}

public struct User: Codable {
    let username: String?
    let password: String
    let email: String
    let avatar: String?
}

struct UserWrapper: Codable {
    let ownerData: User
}

