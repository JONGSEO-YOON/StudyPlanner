//
//  DayEntity+CoreDataProperties.swift
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

extension DayEntity {

    @NSManaged var day: String?
    @NSManaged var month: String?
    @NSManaged var timestamp: NSNumber?
    @NSManaged var week: String?

}
