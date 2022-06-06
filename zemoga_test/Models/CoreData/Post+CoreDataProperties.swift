//
//  Post+CoreDataProperties.swift
//  zemoga_test
//
//  Created by Germano Rojas on 5/6/22.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var body: String?
    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var user: User?

}

extension Post : Identifiable {

}
