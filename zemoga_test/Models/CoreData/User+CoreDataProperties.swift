//
//  User+CoreDataProperties.swift
//  zemoga_test
//
//  Created by Germano Rojas on 5/6/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: Int16

}

extension User : Identifiable {

}
