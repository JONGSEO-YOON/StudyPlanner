//
//  TotalCounterView.swift
//  StudyPlanner
//
//  Created by 윤종서 on 2016. 9. 14..
//  Copyright © 2016년 윤종서. All rights reserved.
//
import UIKit
import CoreData

@IBDesignable class WeekCounterView: UIView {
    
    @IBInspectable var EndAngle: CGFloat = 2*π
    @IBInspectable var outlineColor: UIColor = UIColor.blue
    @IBInspectable var counterColor: UIColor = UIColor.rgb(255, green: 218, blue: 230)
    @IBInspectable var Index: Int = 0
    
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        var arcWidth: CGFloat = 12
        var startAngle: CGFloat = -π/2
        var endAngle: CGFloat = 2*π - π/2
        
        
        let Totaltime = StudyItem.ListTotal
        
        
        let TotalTotal = totalTotalTime()
        
        var listred = Float()
        var listgreen = Float()
        var listblue = Float()
        var listTotal = Int()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "ListEntity")
        let timestampSort = NSSortDescriptor(key: "week", ascending: true)
        fetchRequest.sortDescriptors = [timestampSort]
        
        var i = 0
        
        do {
            
            let results = try managedContext.fetch(fetchRequest)
            let count = results.count
            var i = 0
            
            if(count != 0){
                var match = results[0] as! NSManagedObject
                
                for(i=0 ; i<count ;i += 1) {
                    
                    match = results[i] as! NSManagedObject
                    
                    listred = match.value(forKey: "red") as! Float
                    listgreen = match.value(forKey: "green") as! Float
                    listblue = match.value(forKey: "blue") as! Float
                    listTotal = match.value(forKey: "week") as! Int
                    
                    if(i == Index){
                        arcWidth = 24
                    }
                    else{
                        arcWidth = 20
                    }
                    
                    endAngle = startAngle + CGFloat(Float(listTotal)/Float(TotalTotal)) * 2 * π
                    
                    let path = UIBezierPath(arcCenter: center,
                                            radius: radius/2 - arcWidth/2,
                                            startAngle: startAngle,
                                            endAngle: endAngle,
                                            clockwise: true)
                    
                    
                    counterColor = UIColor.rgb(CGFloat(listred)*255, green: CGFloat(listgreen)*255, blue: CGFloat(listblue)*255)
                    
                    path.lineWidth = arcWidth
                    counterColor.setStroke()
                    path.stroke()
                    
                    
                    startAngle = endAngle
                    
                }
                
            }
            
            
        }catch {
            print("error")
        }
        
    }
    
    func totalDayTime() -> Int {
        var StopTimeStamp:Int = Int(Date().timeIntervalSince1970)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "ListEntity")
        let timestampSort = NSSortDescriptor(key: "timestamp", ascending: true)
        fetchRequest.sortDescriptors = [timestampSort]
        var Total = 0
        
        do {
            
            let results = try managedContext.fetch(fetchRequest)
            let count = results.count
            var i = 0
            
            
            if(count != 0){
                var match = results[0] as! NSManagedObject
                var DayTime = match.value(forKey: "day") as! Int
                
                while(i < count) {
                    
                    match = results[i] as! NSManagedObject
                    DayTime = match.value(forKey: "day") as! Int
                    
                    Total = Total + DayTime
                    
                    i = i + 1
                }
            }
            
            
            try managedContext.save()
            
        }catch {
            print("error")
        }
        
        
        return Total
    }
    
    func totalWeekTime() -> Int {
        var StopTimeStamp:Int = Int(Date().timeIntervalSince1970)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "ListEntity")
        let timestampSort = NSSortDescriptor(key: "timestamp", ascending: true)
        fetchRequest.sortDescriptors = [timestampSort]
        var Total = 0
        
        do {
            
            let results = try managedContext.fetch(fetchRequest)
            let count = results.count
            var i = 0
            
            
            if(count != 0){
                var match = results[0] as! NSManagedObject
                var WeekTime = match.value(forKey: "week") as! Int
                
                while(i < count) {
                    
                    match = results[i] as! NSManagedObject
                    WeekTime = match.value(forKey: "week") as! Int
                    
                    Total = Total + WeekTime
                    
                    
                    i = i + 1
                }
            }
            
            
            try managedContext.save()
            
        }catch {
            print("error")
        }
        
        
        return Total
    }
    
    func totalMonthTime() -> Int {
        var StopTimeStamp:Int = Int(Date().timeIntervalSince1970)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "ListEntity")
        let timestampSort = NSSortDescriptor(key: "timestamp", ascending: true)
        fetchRequest.sortDescriptors = [timestampSort]
        var Total = 0
        
        do {
            
            let results = try managedContext.fetch(fetchRequest)
            let count = results.count
            var i = 0
            
            
            if(count != 0){
                var match = results[0] as! NSManagedObject
                var MonthTime = match.value(forKey: "month") as! Int
                
                while(i < count) {
                    
                    match = results[i] as! NSManagedObject
                    MonthTime = match.value(forKey: "month") as! Int
                    
                    Total = Total + MonthTime
                    
                    
                    i = i + 1
                }
            }
            
            
            try managedContext.save()
            
        }catch {
            print("error")
        }
        
        
        return Total
    }
    
    func totalTotalTime() -> Int {
        var StopTimeStamp:Int = Int(Date().timeIntervalSince1970)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "ListEntity")
        let timestampSort = NSSortDescriptor(key: "timestamp", ascending: true)
        fetchRequest.sortDescriptors = [timestampSort]
        var Total = 0
        
        do {
            
            let results = try managedContext.fetch(fetchRequest)
            let count = results.count
            var i = 0
            
            
            if(count != 0){
                var match = results[0] as! NSManagedObject
                var TotalTime = match.value(forKey: "week") as! Int
                
                while(i < count) {
                    
                    match = results[i] as! NSManagedObject
                    TotalTime = match.value(forKey: "week") as! Int
                    
                    Total = Total + TotalTime
                    
                    
                    i = i + 1
                }
            }
            
            
            try managedContext.save()
            
        }catch {
            print("error")
        }
        
        
        return Total
    }
}
