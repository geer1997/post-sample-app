//
//  Post+CoreDataProperties.swift
//  zemoga_test
//
//  Created by Germano Rojas on 6/6/22.
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
    @NSManaged public var userId: Int16
    @NSManaged public var user: User?
    @NSManaged public var comments: NSOrderedSet?

}

// MARK: Generated accessors for comments
extension Post {

    @objc(insertObject:inCommentsAtIndex:)
    @NSManaged public func insertIntoComments(_ value: Comment, at idx: Int)

    @objc(removeObjectFromCommentsAtIndex:)
    @NSManaged public func removeFromComments(at idx: Int)

    @objc(insertComments:atIndexes:)
    @NSManaged public func insertIntoComments(_ values: [Comment], at indexes: NSIndexSet)

    @objc(removeCommentsAtIndexes:)
    @NSManaged public func removeFromComments(at indexes: NSIndexSet)

    @objc(replaceObjectInCommentsAtIndex:withObject:)
    @NSManaged public func replaceComments(at idx: Int, with value: Comment)

    @objc(replaceCommentsAtIndexes:withComments:)
    @NSManaged public func replaceComments(at indexes: NSIndexSet, with values: [Comment])

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: Comment)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: Comment)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: NSOrderedSet)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: NSOrderedSet)

}

extension Post : Identifiable {

}
