//
//  Comment+CoreDataProperties.swift
//  zemoga_test
//
//  Created by Germano Rojas on 6/6/22.
//
//

import Foundation
import CoreData


extension Comment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var postId: Int16
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var body: String?
    @NSManaged public var post: Post?

}

extension Comment : Identifiable {

}
