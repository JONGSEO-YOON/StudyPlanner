//
//  ListEntity+CoreDataProperties.swift
//  Gayomi
//
//  Created by 윤종서 on 2016. 9. 25..
//  Copyright © 2016년 윤종서. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ListEntity {

    @NSManaged var blue: NSNumber?
    @NSManaged var day: NSNumber?
    @NSManaged var green: NSNumber?
    @NSManaged var item: String?
    @NSManaged var month: NSNumber?
    @NSManaged var red: NSNumber?
    @NSManaged var timestamp: NSNumber?
    @NSManaged var total: NSNumber?
    @NSManaged var week: NSNumber?

}
