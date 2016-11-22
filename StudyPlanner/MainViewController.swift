//
//  ViewController.swift
//  StudyPlanner
//
//  Created by 윤종서 on 2016. 9. 7..
//  Copyright © 2016년 윤종서. All rights reserved.
//

import UIKit
import CoreData
import CoreMotion

class MainViewController: UITableViewController {

    
    var motionManager = CMMotionManager()
    let Cell = "Cell"
    /*
    let button1: UIButton = {
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor.rgb(255, green: 78, blue: 78)
        let image = UIImage(named: "back-2")
        button.setImage(image, forState: .Normal)
        button.tintColor = UIColor.whiteColor()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        button.layer.cornerRadius = 10
        
        
        
        return button
    }()
    
    let button2: UIButton = {
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor.rgb(255, green: 78, blue: 78)
        let image = UIImage(named: "back-2")
        button.setImage(image, forState: .Normal)
        button.tintColor = UIColor.whiteColor()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        button.layer.cornerRadius = 10
        
        
        return button
    }()
    
    let button3: UIButton = {
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor.rgb(255, green: 78, blue: 78)
        let image = UIImage(named: "back-2")
        button.setImage(image, forState: .Normal)
        button.tintColor = UIColor.whiteColor()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        button.layer.cornerRadius = 10
        
        //button.addTarget(self, action: #selector(handleMenuButton), forControlEvents: .TouchUpInside)
        
        return button
    }()
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        motionManager.stopAccelerometerUpdates()
        motionManager.stopDeviceMotionUpdates()
        
        tableView.register(UserCell.self, forCellReuseIdentifier: Cell)
        let addcontroller = AddController()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(AddStudy))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(TotalStudy))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        
        
        /*
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        
        button1.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        button1.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        button1.heightAnchor.constraintEqualToConstant(50).active = true
        button1.widthAnchor.constraintEqualToConstant(100).active = true
        
        button2.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        button2.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        button2.heightAnchor.constraintEqualToConstant(50).active = true
        button2.widthAnchor.constraintEqualToConstant(100).active = true
        
        button3.leftAnchor.constraintEqualToAnchor(button2.rightAnchor,constant: 10).active = true
        button3.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        button3.heightAnchor.constraintEqualToConstant(50).active = true
        button3.widthAnchor.constraintEqualToConstant(100).active = true
        
        button1.addTarget(self, action: #selector(dayinit1), forControlEvents: .TouchUpInside)
        button2.addTarget(self, action: #selector(weekinit1), forControlEvents: .TouchUpInside)
        button3.addTarget(self, action: #selector(monthinit1), forControlEvents: .TouchUpInside)*/
        
        SortAndList()
        firstDay()
        
        DayInit()
        WeekInit()
        MonthInit()
        
    }
    
    func TotalStudy() {
        
        let addController = TotalStudyContoller()
        let navController = UINavigationController(rootViewController: addController)
        present(navController, animated: true, completion: nil)
        
    }
    
    func AddStudy() {
        
        let addController = AddController()
        let navController = UINavigationController(rootViewController: addController)
        present(navController, animated: true, completion: nil)
        
    }
    
    func saveItem(_ itemToSave: String, red: Float, green: Float, blue: Float) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let timestamp = NSNumber(Int(Date().timeIntervalSince1970))
        
        let entity = NSEntityDescription.entity(forEntityName: "ListEntity", in: managedContext)
        //let entity = NSEntityDescription.insertNewObjectForEntityForName("ListEntity", inManagedObjectContext: managedContext)
        
        //let Item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        let contact = ListEntity(entity: entity!, insertInto: managedContext)
        
        
        do{
            try managedContext.save()
            
            contact.item = itemToSave
            contact.red = red as NSNumber?
            contact.blue = blue as NSNumber?
            contact.green = green as NSNumber?
            contact.timestamp = timestamp
            contact.week = 0
            contact.day = 0
            contact.month = 0
            contact.total = 0
            
        }catch{
            
            print("Error")
            
        }
        
        
    }
    
    
   
     
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        //return Listred.count
        return ItemList.count
     
     
     }
     
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell) as! UserCell
     
        let time = ItemList[(indexPath as NSIndexPath).row].ListDay
        let hour = time / 3600
        let min = (time % 3600) / 60
        let sec = time % 60
        
        
        let red = (CGFloat(ItemList[(indexPath as NSIndexPath).row].Listred))*255
        let green = (CGFloat(ItemList[(indexPath as NSIndexPath).row].Listgreen))*255
        let blue = (CGFloat(ItemList[(indexPath as NSIndexPath).row].Listblue))*255
        let item = ItemList[(indexPath as NSIndexPath).row].ListItem
       
        cell.profileImageView.backgroundColor = UIColor.rgb(red, green: green, blue: blue)
        cell.timeLabel.text = item
        cell.studyTimeLabel.text = String(format:"%d:%02d:%02d", hour, min, sec)
        
    
        return cell
        
     }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "ListEntity")
        
        /////// sorting
        let timestampSort = NSSortDescriptor(key: "timestamp", ascending: true)
        fetchRequest.sortDescriptors = [timestampSort]
        //////
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.right)
        
        
        do {
            
            let results = try managedContext.fetch(fetchRequest)
            //var count = results.count
            var match = results[(indexPath as NSIndexPath).row] as! NSManagedObject
            //var matchname = match.valueForKey("item") as! String
            
            managedContext.delete(results[(indexPath as NSIndexPath).row] as! NSManagedObject)
            
            
            try managedContext.save()
            
        }catch {
            print("error")
        }

        
        //ItemList.removeAtIndex(indexPath.row)
    
        SortAndList()
        
        
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let studyController = StudyController()
        let navController = UINavigationController(rootViewController: studyController)
        present(navController, animated: true, completion: nil)
        
        //studyController.StudyItem[0] = ItemList[indexPath.row]
        
        //StudyItem[0] = ItemList[indexPath.row]
        
        
        StudyItem.Listblue = ItemList[(indexPath as NSIndexPath).row].Listblue
        StudyItem.Listred = ItemList[(indexPath as NSIndexPath).row].Listred
        StudyItem.Listgreen = ItemList[(indexPath as NSIndexPath).row].Listgreen
        StudyItem.ListItem = ItemList[(indexPath as NSIndexPath).row].ListItem
        StudyItem.Listtimestamp = ItemList[(indexPath as NSIndexPath).row].Listtimestamp
        StudyItem.ListDay = ItemList[(indexPath as NSIndexPath).row].ListDay
        StudyItem.ListWeek = ItemList[(indexPath as NSIndexPath).row].ListWeek
        StudyItem.ListMonth = ItemList[(indexPath as NSIndexPath).row].ListMonth
        StudyItem.ListTotal = ItemList[(indexPath as NSIndexPath).row].ListTotal
 
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SortAndList()
     }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func SortAndList() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "ListEntity")
        let timestampSort = NSSortDescriptor(key: "timestamp", ascending: true)
        fetchRequest.sortDescriptors = [timestampSort]
        
        
        var listitem = String()
        var listred = Float()
        var listgreen = Float()
        var listblue = Float()
        var listtimestamp = Int()
        var listday = Int()
        var listweek = Int()
        var listmonth = Int()
        var listtotal = Int()
        
        ItemList = Array()
        
        
        
        do {
            
            let results = try managedContext.fetch(fetchRequest)
            let count = results.count
            var i = 0
            
            if(count != 0){
                var match = results[0] as! NSManagedObject
                
                while(i < count) {
                    
                    match = results[i] as! NSManagedObject
                    
                    
                    if(match.value(forKey: "item") == nil){
                        listitem = "nil"
                    }else{
                        listitem = match.value(forKey: "item") as! String
                    }
                    listred = match.value(forKey: "red") as! Float
                    listgreen = match.value(forKey: "green") as! Float
                    listblue = match.value(forKey: "blue") as! Float
                    listtimestamp = match.value(forKey: "timestamp") as! Int
                    listday = match.value(forKey: "day") as! Int
                    listweek = match.value(forKey: "week") as! Int
                    listmonth = match.value(forKey: "month") as! Int
                    listtotal = match.value(forKey: "total") as! Int
                    
                    
                    ItemList.append(ListComp(Listred: listred, Listgreen: listgreen, Listblue: listblue, Listitem: listitem, Listtimestamp: listtimestamp, Listday: listday, Listweek: listweek, Listmonth: listmonth, Listtotal: listtotal))
                    i = i + 1
                }
            }
            
            //ListItem = results as! [NSManagedObject]
            
        }catch {
            print("error")
        }
        
        self.tableView.reloadData()
        
    }
    
    func firstDay() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "DayEntity")
        
        let entity = NSEntityDescription.entity(forEntityName: "DayEntity", in: managedContext)
        let contact = DayEntity(entity: entity!, insertInto: managedContext)
        let timestamp:NSNumber = NSNumber(Int(Date().timeIntervalSince1970))
        
        let timestampSort = NSSortDescriptor(key: "timestamp", ascending: true)
        fetchRequest.sortDescriptors = [timestampSort]
        
        do {
            
            let results = try managedContext.fetch(fetchRequest)
            let count = results.count
            
            if(count == 1){
                do{
                    
                    contact.day = "1"
                    contact.month = "2"
                    contact.week = "3"
                    contact.timestamp = timestamp
                    
                    
                    
                    try managedContext.save()
                    
                }catch{
                    
                    print("Error")
                    
                }
                
            }
            else if(count > 1){
                
                //delete
                do {
                    
                    let results = try managedContext.fetch(fetchRequest)
                    
                    
                    let match = results[0] as! NSManagedObject
                    
                    /*
                    while(count > 0){
                        print(results[count-1] as! NSManagedObject)
                        
                        count = count - 1
                        
                    }*/
                    
                    managedContext.delete(match)
                    
                    
                    try managedContext.save()
                    
                }catch {
                    print("error")
                }
            }
            
            //ListItem = results as! [NSManagedObject]
            
            
        }catch {
            print("error")
        }
        
    }
    
    func DayInit() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "DayEntity")
        let fetchRequest1 = NSFetchRequest(entityName: "ListEntity")
        
        let timestamp:NSNumber = NSNumber(Int(Date().timeIntervalSince1970))
        let timestampDate = Date(timeIntervalSince1970:  TimeInterval(timestamp))
        let string: String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        string = dateFormatter.string(from: timestampDate)
        
        
        do {
            
            let results = try managedContext.fetch(fetchRequest)
            
            let match = results[0] as! NSManagedObject
            

            if(match.value(forKey: "day") == nil){
                var DayTime = match.setValue("132", forKey: "day")
                
            }else{
                let DayTime = match.value(forKey: "day") as! String
                
                if(string != DayTime){
                    match.setValue(string, forKey: "day")
                    
                    do{
                        let results1 = try managedContext.fetch(fetchRequest1)
                        
                        var count = results1.count
                        
                        if(count != 0){
                            
                            var match = results1[0] as! NSManagedObject
                            
                            while(count > 0){
                                
                                
                                match = results1[count-1] as! NSManagedObject
                                match.setValue(0, forKey: "day")
                                
                                count = count - 1
                                
                            }
                        }
                        
                        
                    }
                    catch{
                        print("error")
                        
                    }
                }
                
            }
           
            //match.setValue(DayTime, forKey: "day")
               
            
            
            try managedContext.save()
            
        }catch {
            print("error")
        }
        
        
    }
    func WeekInit() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "DayEntity")
        let fetchRequest1 = NSFetchRequest(entityName: "ListEntity")
        
        let timestamp = NSNumber(Int(Date().timeIntervalSince1970))
        let timestampDate = Date(timeIntervalSince1970:  TimeInterval(timestamp))
        let string: String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        string = dateFormatter.string(from: timestampDate)
        
        
        print(string)
        
        do {
            
            let results = try managedContext.fetch(fetchRequest)
            
            let match = results[0] as! NSManagedObject
            
            
            if(match.value(forKey: "week") == nil){
                var DayTime = match.setValue("132", forKey: "week")
                
            }else{
                let DayTime = match.value(forKey: "week") as! String
                
                if(DayTime == "월"){
                    match.setValue(string, forKey: "week")
                    
                    do{
                        let results1 = try managedContext.fetch(fetchRequest1)
                        
                        var count = results1.count
                        
                        if(count != 0){
                            
                            var match = results1[0] as! NSManagedObject
                            while(count > 0){
                            
                                match = results1[count-1] as! NSManagedObject
                                match.setValue(0, forKey: "week")
                            
                                count = count - 1
                            
                            }
                        }
                    }
                    catch{
                        print("error")
                        
                    }
                }
                
            }
            
            try managedContext.save()
            
        }catch {
            print("error")
        }

        
    }
    func MonthInit() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "DayEntity")
        let fetchRequest1 = NSFetchRequest(entityName: "ListEntity")
        
        let timestamp:NSNumber = NSNumber(Int(Date().timeIntervalSince1970))
        let timestampDate = Date(timeIntervalSince1970:  TimeInterval(timestamp))
        let string: String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        string = dateFormatter.string(from: timestampDate)
        
        do {
            
            let results = try managedContext.fetch(fetchRequest)
            
            let match = results[0] as! NSManagedObject
            
            
            if(match.value(forKey: "month") == nil){
                var DayTime = match.setValue("132", forKey: "month")
                
            }else{
                let DayTime = match.value(forKey: "month") as! String
                
                if(string != DayTime){
                    match.setValue(string, forKey: "month")
                    
                    do{
                        let results1 = try managedContext.fetch(fetchRequest1)
                        var count = results1.count
                        
                        if(count != 0){
                            var match = results1[0] as! NSManagedObject
                            
                            while(count > 0){
                                
                                match = results1[count-1] as! NSManagedObject
                                match.setValue(0, forKey: "month")
                                
                                count = count - 1
                                
                            }
                            
                        }
                        
                        
                    }
                    catch{
                        print("error")
                        
                    }
                }
                
            }
            
            //match.setValue(DayTime, forKey: "day")
            
            
            
            try managedContext.save()
            
        }catch {
            print("error")
        }

        
    }

    /*
    func dayinit1() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "DayEntity")
        
        do {
            
            let results = try managedContext.executeFetchRequest(fetchRequest)
            
            var match = results[0] as! NSManagedObject
            
            
            
                var DayTime = match.valueForKey("day") as! String
            
                    match.setValue("1", forKey: "day")
                    
                   
            
        }catch {
            print("error")
        }
    }
    
    func weekinit1() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "DayEntity")
        
        do {
            
            let results = try managedContext.executeFetchRequest(fetchRequest)
            
            var match = results[0] as! NSManagedObject
            
            
            
            var DayTime = match.valueForKey("week") as! String
            
            match.setValue("1", forKey: "week")
            
            
            
        }catch {
            print("error")
        }
    }
    
    func monthinit1() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "DayEntity")
        
        do {
            
            let results = try managedContext.executeFetchRequest(fetchRequest)
            
            var match = results[0] as! NSManagedObject
            
            
            
            var DayTime = match.valueForKey("month") as! String
            
            match.setValue("1", forKey: "month")
            
            
            
        }catch {
            print("error")
        }
    }*/
}

