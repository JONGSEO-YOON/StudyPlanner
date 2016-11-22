//
//  listItem.swift
//  gayoung
//
//  Created by 윤종서 on 2016. 8. 30..
//  Copyright © 2016년 윤종서. All rights reserved.
//

import UIKit
import CoreData
/*
var Listred = [NSManagedObject]()
var Listgreen = [NSManagedObject]()
var Listblue = [NSManagedObject]()
var ListItem = [NSManagedObject]()
 */
/*
var Listred = Array<Float>()
var Listgreen = Array<Float>()
var Listblue = Array<Float>()
var ListItem = Array<String?>()
var ListArray = Array<Int>()
 
 
 */
struct StudyList {
    var Listred = Float()
    var Listgreen =  Float()
    var Listblue = Float()
    var ListItem = String()
    var Listtimestamp = Int()
    var ListDay = Int()
    var ListWeek = Int()
    var ListMonth = Int()
    var ListTotal = Int()
}


class ListComp {
    var Listred: Float
    var Listgreen: Float
    var Listblue: Float
    var ListItem: String
    var Listtimestamp: Int
    var ListDay: Int
    var ListWeek: Int
    var ListMonth: Int
    var ListTotal: Int
    
    init(Listred: Float, Listgreen: Float, Listblue: Float, Listitem: String, Listtimestamp: Int, Listday: Int, Listweek: Int, Listmonth: Int, Listtotal: Int){
        self.Listred = Listred
        self.Listgreen = Listgreen
        self.Listblue = Listblue
        self.Listtimestamp = Listtimestamp
        self.ListItem = Listitem
        self.ListDay = Listday
        self.ListWeek = Listweek
        self.ListMonth = Listmonth
        self.ListTotal = Listtotal
    }
    
    
}

var ItemList = [ListComp]()
var ItemList1 = [ListComp]()
var ItemList2 = [ListComp]()
var ItemList3 = [ListComp]()
var ItemList4 = [ListComp]()
var StudyItem = StudyList()