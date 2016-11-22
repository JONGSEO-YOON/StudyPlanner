//
//  File.swift
//  StudyPlanner
//
//  Created by 윤종서 on 2016. 9. 14..
//  Copyright © 2016년 윤종서. All rights reserved.
//

import UIKit
import CoreData

class TotalStudyContoller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  
    let Cell = "Cell"
    let Cell1 = "Cell1"
    let Cell2 = "Cell2"
    let Cell3 = "Cell3"
    
    let scrollView = UIScrollView(frame: UIScreen.main.bounds)
    
    let DayTableView: UITableView = {
        let tv = UITableView()
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        return tv
    }()
    
    let WeekTableView: UITableView = {
        let tv = UITableView()
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        return tv
    }()
    
    let MonthTableView: UITableView = {
        let tv = UITableView()
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        return tv
    }()
    
    let TotalTableView: UITableView = {
        let tv = UITableView()
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        return tv
    }()
    
    let DayLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "하루"
        label.textColor = UIColor.black
        
        return label
    }()
    
    let WeekLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1주"
        label.textColor = UIColor.black
        
        return label
    }()
    
    let MonthLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1개월"
        label.textColor = UIColor.black
        
        return label
    }()
    
    let TotalLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "총 공부"
        label.textColor = UIColor.black
        
        return label
    }()
    
    let SeperateBar1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = UIColor.rgb(255, green: 218, blue: 230)
        
        return view
    }()
    
    let SeperateBar2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = UIColor.rgb(255, green: 218, blue: 230)
        
        return view
    }()
    
    let SeperateBar3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = UIColor.rgb(255, green: 218, blue: 230)
        
        return view
    }()
    
    var DayViewBackground: DayCounterView = {
        var view = DayCounterView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = UIColor.rgb(255, green: 218, blue: 230)
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var WeekViewBackground: WeekCounterView = {
        var view = WeekCounterView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = UIColor.rgb(255, green: 218, blue: 230)
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var MonthViewBackground: MonthCounterView = {
        var view = MonthCounterView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = UIColor.rgb(255, green: 218, blue: 230)
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var TotalViewBackground: TotalCounterView = {
        var view = TotalCounterView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = UIColor.rgb(255, green: 218, blue: 230)
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var DayPercentLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0%"
        label.textColor = UIColor.black
        
        return label
    }()
    
    var WeekPercentLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0%"
        label.textColor = UIColor.black
        
        return label
    }()
    
    var MonthPercentLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0%"
        label.textColor = UIColor.black
        
        return label
    }()
    
    var TotalPercentLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.font = UIFont(name: "IowanOldStyle-Bold", size: 15)
        label.text = "0%"
        label.textColor = UIColor.black
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-2"), style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(handleTimeviewController))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        self.view = self.scrollView
        view.backgroundColor = UIColor.white
        self.scrollView.contentSize = CGSize(width: 0, height: 850)
        
        setupConst()
        
        DaySortAndList()
        WeekSortAndList()
        MonthSortAndList()
        TotalSortAndList()
        
        DayTableView.dataSource = self
        DayTableView.delegate = self
        DayTableView.register(UITableViewCell.self, forCellReuseIdentifier: Cell)
        
        WeekTableView.dataSource = self
        WeekTableView.delegate = self
        WeekTableView.register(UITableViewCell.self, forCellReuseIdentifier: Cell1)
        
        MonthTableView.dataSource = self
        MonthTableView.delegate = self
        MonthTableView.register(UITableViewCell.self, forCellReuseIdentifier: Cell2)
        
        TotalTableView.dataSource = self
        TotalTableView.delegate = self
        TotalTableView.register(UITableViewCell.self, forCellReuseIdentifier: Cell3)
        
        self.DayTableView.register(TotalCell.self, forCellReuseIdentifier: Cell)
        self.WeekTableView.register(TotalCell.self, forCellReuseIdentifier: Cell1)
        self.MonthTableView.register(TotalCell.self, forCellReuseIdentifier: Cell2)
        self.TotalTableView.register(TotalCell.self, forCellReuseIdentifier: Cell3)
    }
    
    func handleCancel() {
        let mainViewController = MainViewController()
        let navController = UINavigationController(rootViewController: mainViewController)
        
        present(navController, animated: true, completion: nil)
    }
    
    func setupConst() {
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
        
        view.addSubview(DayTableView)
        view.addSubview(WeekTableView)
        view.addSubview(MonthTableView)
        view.addSubview(TotalTableView)
        
        view.addSubview(SeperateBar1)
        view.addSubview(SeperateBar2)
        view.addSubview(SeperateBar3)
        
        DayLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 6).isActive = true
        DayLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        DayLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        DayLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        DayViewBackground.topAnchor.constraint(equalTo: DayLabel.bottomAnchor, constant: 6).isActive = true
        DayViewBackground.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 36).isActive = true
        DayViewBackground.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        DayViewBackground.heightAnchor.constraint(equalTo: DayViewBackground.widthAnchor).isActive = true
        
        WeekLabel.topAnchor.constraint(equalTo: DayViewBackground.bottomAnchor, constant: 12).isActive = true
        WeekLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        WeekLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        WeekLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        WeekViewBackground.topAnchor.constraint(equalTo: WeekLabel.bottomAnchor, constant: 6).isActive = true
        WeekViewBackground.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 36).isActive = true
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
        
        TotalLabel.topAnchor.constraint(equalTo: MonthViewBackground.bottomAnchor, constant: 12).isActive = true
        TotalLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        TotalLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        TotalLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        TotalViewBackground.topAnchor.constraint(equalTo: TotalLabel.bottomAnchor, constant: 6).isActive = true
        TotalViewBackground.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 36).isActive = true
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
        
        DayTableView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 6).isActive = true
        DayTableView.leftAnchor.constraint(equalTo: DayViewBackground.rightAnchor, constant: 12).isActive = true
        DayTableView.bottomAnchor.constraint(equalTo: DayViewBackground.bottomAnchor).isActive = true
        DayTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        
        WeekTableView.topAnchor.constraint(equalTo: DayViewBackground.bottomAnchor, constant: 12).isActive = true
        WeekTableView.leftAnchor.constraint(equalTo: WeekViewBackground.rightAnchor, constant: 12).isActive = true
        WeekTableView.bottomAnchor.constraint(equalTo: WeekViewBackground.bottomAnchor).isActive = true
        WeekTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        
        MonthTableView.topAnchor.constraint(equalTo: WeekViewBackground.bottomAnchor, constant: 12).isActive = true
        MonthTableView.leftAnchor.constraint(equalTo: MonthViewBackground.rightAnchor, constant: 12).isActive = true
        MonthTableView.bottomAnchor.constraint(equalTo: MonthViewBackground.bottomAnchor).isActive = true
        MonthTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        
        TotalTableView.topAnchor.constraint(equalTo: MonthViewBackground.bottomAnchor, constant: 12).isActive = true
        TotalTableView.leftAnchor.constraint(equalTo: TotalViewBackground.rightAnchor, constant: 12).isActive = true
        TotalTableView.bottomAnchor.constraint(equalTo: TotalViewBackground.bottomAnchor).isActive = true
        TotalTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        
        SeperateBar1.topAnchor.constraint(equalTo: DayViewBackground.bottomAnchor, constant: 6).isActive = true
        SeperateBar1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        SeperateBar1.rightAnchor.constraint(equalTo: DayTableView.rightAnchor).isActive = true
        SeperateBar1.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        SeperateBar2.topAnchor.constraint(equalTo: WeekViewBackground.bottomAnchor, constant: 6).isActive = true
        SeperateBar2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        SeperateBar2.rightAnchor.constraint(equalTo: DayTableView.rightAnchor).isActive = true
        SeperateBar2.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        SeperateBar3.topAnchor.constraint(equalTo: MonthViewBackground.bottomAnchor, constant: 6).isActive = true
        SeperateBar3.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        SeperateBar3.rightAnchor.constraint(equalTo: DayTableView.rightAnchor).isActive = true
        SeperateBar3.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
    }
    
    func DaySortAndList() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "ListEntity")
        let timestampSort = NSSortDescriptor(key: "day", ascending: true)
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
        
        ItemList1 = Array()
        
        
        
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
                    
                    
                    ItemList1.append(ListComp(Listred: listred, Listgreen: listgreen, Listblue: listblue, Listitem: listitem, Listtimestamp: listtimestamp, Listday: listday, Listweek: listweek, Listmonth: listmonth, Listtotal: listtotal))
                    //print("count: \(count-1), name: \(listitem), timestamp: \(listtimestamp)")
                    i = i + 1
                }
            }
            
            //ListItem = results as! [NSManagedObject]
            
        }catch {
            print("error")
        }
        
        //self.tableView.reloadData()
        DayTableView.reloadData()
        
    }
    
    func WeekSortAndList() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "ListEntity")
        let timestampSort = NSSortDescriptor(key: "week", ascending: true)
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
        
        ItemList2 = Array()
        
        
        
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
                    
                    
                    ItemList2.append(ListComp(Listred: listred, Listgreen: listgreen, Listblue: listblue, Listitem: listitem, Listtimestamp: listtimestamp, Listday: listday, Listweek: listweek, Listmonth: listmonth, Listtotal: listtotal))
                    //print("count: \(count-1), name: \(listitem), timestamp: \(listtimestamp)")
                    i = i + 1
                }
            }
            
            //ListItem = results as! [NSManagedObject]
            
        }catch {
            print("error")
        }
        
        //self.tableView.reloadData()
        WeekTableView.reloadData()
        
    }
    
    func MonthSortAndList() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "ListEntity")
        let timestampSort = NSSortDescriptor(key: "month", ascending: true)
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
        
        ItemList3 = Array()
        
        
        
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
                    
                    
                    ItemList3.append(ListComp(Listred: listred, Listgreen: listgreen, Listblue: listblue, Listitem: listitem, Listtimestamp: listtimestamp, Listday: listday, Listweek: listweek, Listmonth: listmonth, Listtotal: listtotal))
                    //print("count: \(count-1), name: \(listitem), timestamp: \(listtimestamp)")
                    i = i + 1
                }
            }
            
            //ListItem = results as! [NSManagedObject]
            
        }catch {
            print("error")
        }
        
        //self.tableView.reloadData()
        MonthTableView.reloadData()
        
    }
    
    func TotalSortAndList() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "ListEntity")
        let timestampSort = NSSortDescriptor(key: "total", ascending: true)
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
        
        ItemList4 = Array()
        
        
        
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
                    
                    
                    ItemList4.append(ListComp(Listred: listred, Listgreen: listgreen, Listblue: listblue, Listitem: listitem, Listtimestamp: listtimestamp, Listday: listday, Listweek: listweek, Listmonth: listmonth, Listtotal: listtotal))
                    //print("count: \(count-1), name: \(listitem), timestamp: \(listtimestamp)")
                    i = i + 1
                }
            }
            
            //ListItem = results as! [NSManagedObject]
            
        }catch {
            print("error")
        }
        
        //self.tableView.reloadData()
        TotalTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of items in the sample data structure.
        
        
        var count:Int?
        
        if tableView == self.DayTableView {
            count = ItemList1.count
        }
        
        if tableView == self.WeekTableView {
            count =  ItemList2.count
        }
        
        if tableView == self.MonthTableView {
            count =  ItemList3.count
        }
        
        if tableView == self.TotalTableView {
            count =  ItemList4.count
        }
        
        
        
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: TotalCell?
        
        if tableView == self.DayTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: Cell, for: indexPath) as! TotalCell
            
            let time = ItemList1[(indexPath as NSIndexPath).row].ListDay
            let hour = time / 3600
            let min = (time % 3600) / 60
            let sec = time % 60
            
            
            let red = (CGFloat(ItemList1[(indexPath as NSIndexPath).row].Listred))*255
            let green = (CGFloat(ItemList1[(indexPath as NSIndexPath).row].Listgreen))*255
            let blue = (CGFloat(ItemList1[(indexPath as NSIndexPath).row].Listblue))*255
            let item = ItemList1[(indexPath as NSIndexPath).row].ListItem
            
            cell!.profileImageView.backgroundColor = UIColor.rgb(red, green: green, blue: blue)
            cell!.timeLabel.text = item
            cell!.studyTimeLabel.text = String(format:"%d:%02d:%02d", hour, min, sec)
            
        }
        
        if tableView == self.WeekTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: Cell1, for: indexPath) as! TotalCell
            
            let time = ItemList2[(indexPath as NSIndexPath).row].ListWeek
            let hour = time / 3600
            let min = (time % 3600) / 60
            let sec = time % 60
            
            
            let red = (CGFloat(ItemList2[(indexPath as NSIndexPath).row].Listred))*255
            let green = (CGFloat(ItemList2[(indexPath as NSIndexPath).row].Listgreen))*255
            let blue = (CGFloat(ItemList2[(indexPath as NSIndexPath).row].Listblue))*255
            let item = ItemList2[(indexPath as NSIndexPath).row].ListItem
            
            cell!.profileImageView.backgroundColor = UIColor.rgb(red, green: green, blue: blue)
            cell!.timeLabel.text = item
            cell!.studyTimeLabel.text = String(format:"%d:%02d:%02d", hour, min, sec)
            
        }
        
        if tableView == self.MonthTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: Cell2, for: indexPath) as! TotalCell
            
            let time = ItemList3[(indexPath as NSIndexPath).row].ListMonth
            let hour = time / 3600
            let min = (time % 3600) / 60
            let sec = time % 60
            
            
            let red = (CGFloat(ItemList3[(indexPath as NSIndexPath).row].Listred))*255
            let green = (CGFloat(ItemList3[(indexPath as NSIndexPath).row].Listgreen))*255
            let blue = (CGFloat(ItemList3[(indexPath as NSIndexPath).row].Listblue))*255
            let item = ItemList3[(indexPath as NSIndexPath).row].ListItem
            
            cell!.profileImageView.backgroundColor = UIColor.rgb(red, green: green, blue: blue)
            cell!.timeLabel.text = item
            cell!.studyTimeLabel.text = String(format:"%d:%02d:%02d", hour, min, sec)
            
        }
        
        
        if tableView == self.TotalTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: Cell3, for: indexPath) as! TotalCell
            
            let time = ItemList4[(indexPath as NSIndexPath).row].ListTotal
            let hour = time / 3600
            let min = (time % 3600) / 60
            let sec = time % 60
            
            
            let red = (CGFloat(ItemList4[(indexPath as NSIndexPath).row].Listred))*255
            let green = (CGFloat(ItemList4[(indexPath as NSIndexPath).row].Listgreen))*255
            let blue = (CGFloat(ItemList4[(indexPath as NSIndexPath).row].Listblue))*255
            let item = ItemList4[(indexPath as NSIndexPath).row].ListItem
            
            cell!.profileImageView.backgroundColor = UIColor.rgb(red, green: green, blue: blue)
            cell!.timeLabel.text = item
            cell!.studyTimeLabel.text = String(format:"%d:%02d:%02d", hour, min, sec)
            
        }
        
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "ListEntity")
        var timestampSort = NSSortDescriptor(key: "timestamp", ascending: true)
        fetchRequest.sortDescriptors = [timestampSort]
        
        var time = StudyItem.ListDay
        var Weektime = StudyItem.ListWeek
        var Monthtime = StudyItem.ListMonth
        var Totaltime = StudyItem.ListTotal
        
        let DayTotal = totalDayTime()
        let WeekTotal = totalWeekTime()
        let MonthTtal = totalMonthTime()
        let TotalTotal = totalTotalTime()
        
        
        
        
        
        if tableView == self.DayTableView {
            timestampSort = NSSortDescriptor(key: "day", ascending: true)
            fetchRequest.sortDescriptors = [timestampSort]
            
            do {
                
                var results = try managedContext.fetch(fetchRequest)
                let match = results[(indexPath as NSIndexPath).row] as! NSManagedObject
                time = match.value(forKey: "day") as! Int
                
            }catch {
                print("error")
            }

            
            DayViewBackground.Index = (indexPath as NSIndexPath).row
            DayPercentLabel.text = String(format:"%2.f%%", Float(time)/Float(DayTotal) * 100)
            DayViewBackground.setNeedsDisplay()
        }
        
        if tableView == self.WeekTableView {
            timestampSort = NSSortDescriptor(key: "week", ascending: true)
            fetchRequest.sortDescriptors = [timestampSort]
            
            do {
                
                var results = try managedContext.fetch(fetchRequest)
                let match = results[(indexPath as NSIndexPath).row] as! NSManagedObject
                Weektime = match.value(forKey: "week") as! Int
                
            }catch {
                print("error")
            }

            
            WeekViewBackground.Index = (indexPath as NSIndexPath).row
            WeekPercentLabel.text = String(format:"%2.f%%", Float(Weektime)/Float(WeekTotal) * 100)
            WeekViewBackground.setNeedsDisplay()
        }
        
        if tableView == self.MonthTableView {
            timestampSort = NSSortDescriptor(key: "month", ascending: true)
            fetchRequest.sortDescriptors = [timestampSort]
            
            do {
                
                var results = try managedContext.fetch(fetchRequest)
                let match = results[(indexPath as NSIndexPath).row] as! NSManagedObject
                Monthtime = match.value(forKey: "month") as! Int
                
            }catch {
                print("error")
            }

            
            MonthViewBackground.Index = (indexPath as NSIndexPath).row
            MonthPercentLabel.text = String(format:"%2.f%%", Float(Monthtime)/Float(MonthTtal) * 100)
            MonthViewBackground.setNeedsDisplay()
        }
        
        if tableView == self.TotalTableView {
            let timestampSort = NSSortDescriptor(key: "total", ascending: true)
            fetchRequest.sortDescriptors = [timestampSort]
            
            do {
                
                var results = try managedContext.fetch(fetchRequest)
                let match = results[(indexPath as NSIndexPath).row] as! NSManagedObject
                Totaltime = match.value(forKey: "total") as! Int
                
            }catch {
                print("error")
            }

            
            TotalViewBackground.Index = (indexPath as NSIndexPath).row
            TotalPercentLabel.text = String(format:"%2.f%%", Float(Totaltime)/Float(TotalTotal) * 100)
            TotalViewBackground.setNeedsDisplay()
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


    func handleTimeviewController() {
        let mainViewController = TimeViewController()
        let navController = UINavigationController(rootViewController: mainViewController)
        
        present(navController, animated: true, completion: nil)
        
    }
}
