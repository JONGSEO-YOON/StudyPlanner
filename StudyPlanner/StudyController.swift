//
//  StudyController.swift
//  StudyPlanner
//
//  Created by 윤종서 on 2016. 9. 7..
//  Copyright © 2016년 윤종서. All rights reserved.
//

import UIKit
import CoreData
import CoreMotion

class StudyController: UIViewController {
    
    
    var currentMaxAccelZ: Double = 0.0
    
    var motionManager = CMMotionManager()
    
    //Outlets
    
    var accZ: UILabel!
    var maxAccZ: UILabel!
    
    
    func resetMaxValues() {
        currentMaxAccelZ = 0
        
    }
    
    var StratTimeStamp = 0
    
    var Flag = 0
    var Flag2 = 0
    
    let NameLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "123"
        label.textColor = UIColor.black
        
        return label
    }()
    
    let DayLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "123"
        label.textColor = UIColor.black
        
        return label
    }()
    
    let WeekLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "123"
        label.textColor = UIColor.black
        
        return label
    }()
    
    let MonthLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "123"
        label.textColor = UIColor.black
        
        return label
    }()
    
     let TotalLabel: UILabel = {
     let label = UILabel()
     
     label.translatesAutoresizingMaskIntoConstraints = false
     label.text = "123"
     label.textColor = UIColor.black
     
     return label
     }()
 
    let DayViewBackground: CounterView = {
        let view = CounterView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let WeekViewBackground: CounterView = {
        let view = CounterView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let MonthViewBackground: CounterView = {
        let view = CounterView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let TotalViewBackground: CounterView = {
        let view = CounterView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let DayPercentLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0%%"
        label.textColor = UIColor.black
        
        return label
    }()
    
    let WeekPercentLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0%%"
        label.textColor = UIColor.black
        
        return label
    }()
    
    let MonthPercentLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0%%"
        label.textColor = UIColor.black
        
        return label
    }()
    
    let TotalPercentLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.font = UIFont(name: "IowanOldStyle-Bold", size: 15)
        label.text = "0%%"
        label.textColor = UIColor.black
        
        return label
    }()
    /*
    let DayView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.rgb(CGFloat(StudyItem.Listred*255), green: CGFloat(StudyItem.Listgreen*255), blue:CGFloat(StudyItem.Listblue*255))
        
        return view
    }()
    
    let WeekView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.rgb(CGFloat(StudyItem.Listred*255), green: CGFloat(StudyItem.Listgreen*255), blue:CGFloat(StudyItem.Listblue*255))
        
        return view
    }()
    
    let MonthView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.rgb(CGFloat(StudyItem.Listred*255), green: CGFloat(StudyItem.Listgreen*255), blue:CGFloat(StudyItem.Listblue*255))
        
        return view
    }()
     let TotalView: UIView = {
     let view = UIView()
     
     view.translatesAutoresizingMaskIntoConstraints = false
     view.backgroundColor = UIColor.rgb(255, green: 218, blue: 230)
     
     return view
     }()
 */
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-2"), style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        
        setupContraint()
        
        ////////
        self.resetMaxValues()
        
        motionManager.accelerometerUpdateInterval = 0.2
        
        //Start Recording Data
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
            
            self.outputAccData(accelerometerData!.acceleration)
            if(NSError != nil) {
                print("\(NSError)")
            }
        }
        
        ////////
        
    }
    
    func outputAccData(_ acceleration: CMAcceleration){
       
        if(acceleration.z > 0.8 && Flag == 0){
            Flag = 1
            
            start()
            
        }
        if(acceleration.z < -0.8 && Flag == 1){
            
            stop()
        }
        
        print(acceleration.z)
        
        
        
    }
   
    
    func handleCancel() {
        let mainViewController = MainViewController()
        let navController = UINavigationController(rootViewController: mainViewController)
        
        
        motionManager.stopAccelerometerUpdates()
        motionManager.stopDeviceMotionUpdates()
        
        //print(ItemList[0].ListItem)
        
        present(navController, animated: true, completion: nil)
    }
    
    func setupContraint() {
        
        view.addSubview(NameLabel)
        view.addSubview(DayLabel)
        view.addSubview(WeekLabel)
        view.addSubview(MonthLabel)
        view.addSubview(TotalLabel)
        
        view.addSubview(DayViewBackground)
        view.addSubview(WeekViewBackground)
        view.addSubview(MonthViewBackground)
        view.addSubview(TotalViewBackground)
        
        view.addSubview(DayPercentLabel)
        view.addSubview(WeekPercentLabel)
        view.addSubview(MonthPercentLabel)
        view.addSubview(TotalPercentLabel)
        
        /*
        view.addSubview(DayView)
        view.addSubview(WeekView)
        view.addSubview(MonthView)
        view.addSubview(TotalView)
        
        
        DayView.backgroundColor = UIColor.rgb(CGFloat(StudyItem.Listred*255), green: CGFloat(StudyItem.Listgreen*255), blue:CGFloat(StudyItem.Listblue*255))
        WeekView.backgroundColor = UIColor.rgb(CGFloat(StudyItem.Listred*255), green: CGFloat(StudyItem.Listgreen*255), blue:CGFloat(StudyItem.Listblue*255))
        MonthView.backgroundColor = UIColor.rgb(CGFloat(StudyItem.Listred*255), green: CGFloat(StudyItem.Listgreen*255), blue:CGFloat(StudyItem.Listblue*255))
        TotalView.backgroundColor = UIColor.rgb(CGFloat(StudyItem.Listred*255), green: CGFloat(StudyItem.Listgreen*255), blue:CGFloat(StudyItem.Listblue*255))
        */
        NameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        NameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        NameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        NameLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        DayLabel.topAnchor.constraint(equalTo: NameLabel.bottomAnchor, constant: 12).isActive = true
        DayLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        DayLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        DayLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        DayViewBackground.topAnchor.constraint(equalTo: DayLabel.bottomAnchor, constant: 6).isActive = true
        DayViewBackground.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 36).isActive = true
        DayViewBackground.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        DayViewBackground.heightAnchor.constraint(equalTo: DayViewBackground.widthAnchor).isActive = true
        
        WeekLabel.topAnchor.constraint(equalTo: NameLabel.bottomAnchor, constant: 12).isActive = true
        WeekLabel.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 12).isActive = true
        WeekLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        WeekLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        WeekViewBackground.topAnchor.constraint(equalTo: WeekLabel.bottomAnchor, constant: 6).isActive = true
        WeekViewBackground.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 36).isActive = true
        WeekViewBackground.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        WeekViewBackground.heightAnchor.constraint(equalTo: WeekViewBackground.widthAnchor).isActive = true
        
        MonthLabel.topAnchor.constraint(equalTo: WeekViewBackground.bottomAnchor, constant: 12).isActive = true
        MonthLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        MonthLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        MonthLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        MonthViewBackground.topAnchor.constraint(equalTo: MonthLabel.bottomAnchor, constant: 6).isActive = true
        MonthViewBackground.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 36).isActive = true
        MonthViewBackground.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        MonthViewBackground.heightAnchor.constraint(equalTo: MonthViewBackground.widthAnchor).isActive = true
        
        TotalLabel.topAnchor.constraint(equalTo: WeekViewBackground.bottomAnchor, constant: 12).isActive = true
        TotalLabel.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 12).isActive = true
        TotalLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        TotalLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
         
        TotalViewBackground.topAnchor.constraint(equalTo: TotalLabel.bottomAnchor, constant: 6).isActive = true
        TotalViewBackground.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 36).isActive = true
        TotalViewBackground.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        TotalViewBackground.heightAnchor.constraint(equalTo: TotalViewBackground.widthAnchor).isActive = true
        
        DayPercentLabel.centerXAnchor.constraint(equalTo: DayViewBackground.centerXAnchor).isActive = true
        DayPercentLabel.centerYAnchor.constraint(equalTo: DayViewBackground.centerYAnchor).isActive = true
        DayPercentLabel.widthAnchor.constraint(equalToConstant: 34).isActive = true
        DayPercentLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        WeekPercentLabel.centerXAnchor.constraint(equalTo: WeekViewBackground.centerXAnchor).isActive = true
        WeekPercentLabel.centerYAnchor.constraint(equalTo: WeekViewBackground.centerYAnchor).isActive = true
        WeekPercentLabel.widthAnchor.constraint(equalToConstant: 34).isActive = true
        WeekPercentLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        MonthPercentLabel.centerXAnchor.constraint(equalTo: MonthViewBackground.centerXAnchor).isActive = true
        MonthPercentLabel.centerYAnchor.constraint(equalTo: MonthViewBackground.centerYAnchor).isActive = true
        MonthPercentLabel.widthAnchor.constraint(equalToConstant: 34).isActive = true
        MonthPercentLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        TotalPercentLabel.centerXAnchor.constraint(equalTo: TotalViewBackground.centerXAnchor).isActive = true
        TotalPercentLabel.centerYAnchor.constraint(equalTo: TotalViewBackground.centerYAnchor).isActive = true
        TotalPercentLabel.widthAnchor.constraint(equalToConstant: 34).isActive = true
        TotalPercentLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
 
        let time = StudyItem.ListDay
        let hour = time / 3600
        let min = (time % 3600) / 60
        let sec = time % 60
        
        let Weektime = StudyItem.ListWeek
        let Weekhour = Weektime / 3600
        let Weekmin = (Weektime % 3600) / 60
        let Weeksec = Weektime % 60
        
        let Monthtime = StudyItem.ListMonth
        let Monthhour = Monthtime / 3600
        let Monthmin = (Monthtime % 3600) / 60
        let Monthsec = Monthtime % 60
        
        let Totaltime = StudyItem.ListTotal
        
        let DayTotal = totalDayTime()
        let DayTotalhour = DayTotal / 3600
        let DayTotalmin = (DayTotal % 3600) / 60
        let DayTotalsec = DayTotal % 60
        
        let WeekTotal = totalWeekTime()
        let WeekTotalhour = WeekTotal / 3600
        let WeekTotalmin = (WeekTotal % 3600) / 60
        let WeekTotalsec = WeekTotal % 60
        
        let MonthTtal = totalMonthTime()
        let MonthTtalhour = MonthTtal / 3600
        let MonthTtalmin = (MonthTtal % 3600) / 60
        let MonthTtalsec = MonthTtal % 60
        
        let TotalTotal = totalTotalTime()
        let TotalTotalhour = TotalTotal / 3600
        let TotalTotalmin = (TotalTotal % 3600) / 60
        let TotalTotalsec = TotalTotal % 60
        
        
        
        NameLabel.text = "과목 : \(StudyItem.ListItem)"
        DayLabel.text = String(format:"하루 : %d:%02d:%02d / %d:%02d:%02d", hour, min, sec, DayTotalhour, DayTotalmin, DayTotalsec)
        WeekLabel.text = String(format:"1주 : %d:%02d:%02d / %d:%02d:%02d", Weekhour, Weekmin, Weeksec, WeekTotalhour, WeekTotalmin, WeekTotalsec)
        MonthLabel.text = String(format:"1개월 : %d:%02d:%02d / %d:%02d:%02d", Monthhour, Monthmin, Monthsec, MonthTtalhour, MonthTtalmin, MonthTtalsec)
        TotalLabel.text = String(format:"총 : %d:%02d:%02d / %d:%02d:%02d", Monthhour, Monthmin, Monthsec, TotalTotalhour, TotalTotalmin, TotalTotalsec)
        
        DayPercentLabel.text = String(format:"%2.f%%", Float(time)/Float(DayTotal) * 100)
        WeekPercentLabel.text = String(format:"%2.f%%", Float(Weektime)/Float(WeekTotal) * 100)
        MonthPercentLabel.text = String(format:"%2.f%%", Float(Monthtime)/Float(MonthTtal) * 100)
        TotalPercentLabel.text = String(format:"%2.f%%", Float(Totaltime)/Float(TotalTotal) * 100)
        
        
        
        DayViewBackground.outlineColor = UIColor.rgb(CGFloat(StudyItem.Listred*255), green: CGFloat(StudyItem.Listgreen*255), blue:CGFloat(StudyItem.Listblue*255))
        WeekViewBackground.outlineColor = UIColor.rgb(CGFloat(StudyItem.Listred*255), green: CGFloat(StudyItem.Listgreen*255), blue:CGFloat(StudyItem.Listblue*255))
        MonthViewBackground.outlineColor = UIColor.rgb(CGFloat(StudyItem.Listred*255), green: CGFloat(StudyItem.Listgreen*255), blue:CGFloat(StudyItem.Listblue*255))
        TotalViewBackground.outlineColor = UIColor.rgb(CGFloat(StudyItem.Listred*255), green: CGFloat(StudyItem.Listgreen*255), blue:CGFloat(StudyItem.Listblue*255))
        
        DayViewBackground.EndAngle = CGFloat(Float(time)/Float(DayTotal)) * 2 * π
        WeekViewBackground.EndAngle = CGFloat(Float(Weektime)/Float(WeekTotal)) * 2 * π
        MonthViewBackground.EndAngle = CGFloat(Float(Monthtime)/Float(MonthTtal)) * 2 * π
        TotalViewBackground.EndAngle = CGFloat(Float(Totaltime)/Float(TotalTotal)) * 2 * π
        /*
        DayView.leftAnchor.constraintEqualToAnchor(DayViewBackground.leftAnchor).active = true
        DayView.topAnchor.constraintEqualToAnchor(DayViewBackground.topAnchor).active = true
        DayView.heightAnchor.constraintEqualToAnchor(DayViewBackground.heightAnchor).active = true
        
        WeekView.leftAnchor.constraintEqualToAnchor(WeekViewBackground.leftAnchor).active = true
        WeekView.topAnchor.constraintEqualToAnchor(WeekViewBackground.topAnchor).active = true
        WeekView.heightAnchor.constraintEqualToAnchor(WeekViewBackground.heightAnchor).active = true
        
        MonthView.leftAnchor.constraintEqualToAnchor(MonthViewBackground.leftAnchor).active = true
        MonthView.topAnchor.constraintEqualToAnchor(MonthViewBackground.topAnchor).active = true
        MonthView.heightAnchor.constraintEqualToAnchor(MonthViewBackground.heightAnchor).active = true
        
        TotalView.leftAnchor.constraintEqualToAnchor(TotalViewBackground.leftAnchor).active = true
        TotalView.topAnchor.constraintEqualToAnchor(TotalViewBackground.topAnchor).active = true
        TotalView.heightAnchor.constraintEqualToAnchor(TotalViewBackground.heightAnchor).active = true
        
        
        if(DayTotal == 0){
            DayView.widthAnchor.constraintEqualToAnchor(DayViewBackground.widthAnchor, multiplier: 0).active = true
        }else{
            DayView.widthAnchor.constraintEqualToAnchor(DayViewBackground.widthAnchor, multiplier: CGFloat(Float(time)/Float(DayTotal))).active = true
        }
        if(WeekTotal == 0){
            WeekView.widthAnchor.constraintEqualToAnchor(WeekViewBackground.widthAnchor, multiplier: 0).active = true
        }else{
            WeekView.widthAnchor.constraintEqualToAnchor(WeekViewBackground.widthAnchor, multiplier: CGFloat(Float(time)/Float(DayTotal))).active = true
        }
        if(MonthTtal == 0){
            MonthView.widthAnchor.constraintEqualToAnchor(MonthViewBackground.widthAnchor, multiplier: 0).active = true
        }else{
            MonthView.widthAnchor.constraintEqualToAnchor(MonthViewBackground.widthAnchor, multiplier: CGFloat(Float(time)/Float(DayTotal))).active = true
        }
        if(TotalTotal == 0){
            TotalView.widthAnchor.constraintEqualToAnchor(TotalViewBackground.widthAnchor, multiplier: 0).active = true
        }else{
            TotalView.widthAnchor.constraintEqualToAnchor(TotalViewBackground.widthAnchor, multiplier: CGFloat(Float(time)/Float(DayTotal))).active = true
        }
        */
    }
    
    func start() {
        
        if(Flag2 == 0)
        {
            StratTimeStamp = Int(Date().timeIntervalSince1970)
            print(StratTimeStamp)
            
            motionManager.accelerometerUpdateInterval = 1
            
            Flag2 = 1
        }
        
    }
    
    func stop() {
        
        motionManager.stopAccelerometerUpdates()
        motionManager.stopDeviceMotionUpdates()
        
        
        let StopTimeStamp:Int = Int(Date().timeIntervalSince1970)
        let Time = StopTimeStamp - StratTimeStamp
        
        print(StopTimeStamp)
        print(Time)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "ListEntity")
        //let fetchRequest = NSFetchRequest(entityName: "ListEntity")
        let timestampSort = NSSortDescriptor(key: "timestamp", ascending: true)
        fetchRequest.sortDescriptors = [timestampSort]
        
        do {
            
            let results = try managedContext.fetch(fetchRequest)
            let count = results.count
            var i = 0
            
            if(count != 0){
                var match = results[0] as! NSManagedObject
                var DayTime = match.value(forKey: "day") as! Int
                var WeekTime = match.value(forKey: "week") as! Int
                var MonthTime = match.value(forKey: "month") as! Int
                var TotalTime = match.value(forKey: "total") as! Int
                
                while(i < count) {
                    
                    match = results[i] as! NSManagedObject
                    DayTime = match.value(forKey: "day") as! Int
                    WeekTime = match.value(forKey: "week") as! Int
                    MonthTime = match.value(forKey: "month") as! Int
                    TotalTime = match.value(forKey: "total") as! Int
                    
                    if(match.value(forKey: "timestamp") as! Int == StudyItem.Listtimestamp ){
                        DayTime = DayTime + Time
                        WeekTime = WeekTime + Time
                        MonthTime = MonthTime + Time
                        TotalTime = TotalTime + Time
                        
                        match.setValue(DayTime, forKey: "day")
                        match.setValue(WeekTime, forKey: "week")
                        match.setValue(MonthTime, forKey: "month")
                        match.setValue(TotalTime, forKey: "total")
                    }
                    i = i + 1
                }
            }
            
            
            try managedContext.save()
            
        }catch {
            print("error")
        }
        
        
        let mainViewController = MainViewController()
        let navController = UINavigationController(rootViewController: mainViewController)
        
        present(navController, animated: true, completion: nil)
        
        
    }
    
    func totalDayTime() -> Int {
        let StopTimeStamp:Int = Int(Date().timeIntervalSince1970)
        var Time = StopTimeStamp - StratTimeStamp
        
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
        let StopTimeStamp:Int = Int(Date().timeIntervalSince1970)
        var Time = StopTimeStamp - StratTimeStamp
        
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
        let StopTimeStamp:Int = Int(Date().timeIntervalSince1970)
        var Time = StopTimeStamp - StratTimeStamp
        
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
     let StopTimeStamp:Int = Int(Date().timeIntervalSince1970)
     var Time = StopTimeStamp - StratTimeStamp
     
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
     var TotalTime = match.value(forKey: "total") as! Int
     
     while(i < count) {
     
        match = results[i] as! NSManagedObject
        TotalTime = match.value(forKey: "total") as! Int
     
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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
