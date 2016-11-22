//
//  TimeView.swift
//  Gayomi
//
//  Created by 윤종서 on 2016. 9. 25..
//  Copyright © 2016년 윤종서. All rights reserved.
//

import UIKit
import CoreData

class TimeViewController: UIViewController {

    let StartLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "하루"
        label.textColor = UIColor.black
        
        return label
    }()
    
    let EndLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "하루"
        label.textColor = UIColor.black
        
        return label
    }()
    
    let TotalLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "하루"
        label.textColor = UIColor.black
        
        return label
    }()
    
    let StartTimeLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "하루"
        label.textColor = UIColor.black
        
        return label
    }()
    
    let EndTimeLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "하루"
        label.textColor = UIColor.black
        
        return label
    }()
    
    let TotaTimelLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "하루"
        label.textColor = UIColor.black
        label.font = UIFont(name: "IowanOldStyle-Bold", size: 60)
        
        
        return label
    }()
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-2"), style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        setup()
    }
    
    func handleCancel() {
        let mainViewController = TotalStudyContoller()
        let navController = UINavigationController(rootViewController: mainViewController)
        
        present(navController, animated: true, completion: nil)
    }
    
    func setup() {
        view.addSubview(StartLabel)
        view.addSubview(EndLabel)
        view.addSubview(TotalLabel)
        view.addSubview(StartTimeLabel)
        view.addSubview(EndTimeLabel)
        view.addSubview(TotaTimelLabel)
        
        
        TotalLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        TotalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        TotalLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        TotalLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        TotaTimelLabel.topAnchor.constraint(equalTo: TotalLabel.bottomAnchor, constant: 24).isActive = true
        TotaTimelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        TotaTimelLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        TotaTimelLabel.widthAnchor.constraint(equalToConstant: 240).isActive = true
        
        StartLabel.topAnchor.constraint(equalTo: TotaTimelLabel.bottomAnchor, constant: 12).isActive = true
        StartLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        StartLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        StartLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        StartTimeLabel.topAnchor.constraint(equalTo: StartLabel.bottomAnchor, constant: 12).isActive = true
        StartTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        StartTimeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        StartTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        EndLabel.topAnchor.constraint(equalTo: StartTimeLabel.bottomAnchor, constant: 12).isActive = true
        EndLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        EndLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        EndLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        EndTimeLabel.topAnchor.constraint(equalTo: EndLabel.bottomAnchor, constant: 12).isActive = true
        EndTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        EndTimeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        EndTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        let DayTotal = totalDayTime()
        let DayTotalhour = DayTotal / 3600
        let DayTotalmin = (DayTotal % 3600) / 60
        let DayTotalsec = DayTotal % 60
        
        TotalLabel.text = String(format:"총 공부")
        TotaTimelLabel.text = String(format:"%d:%02d:%02d ", DayTotalhour, DayTotalmin, DayTotalsec)
        StartLabel.text = String(format:"출첵시간")
        
        EndLabel.text = String(format:"퇴첵시간")
        
    }
    
    
    func totalDayTime() -> Int {
        var StopTimeStamp:Int = Int(Date().timeIntervalSince1970)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = (NSFetchRequest(entityName: "ListEntity"))
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

    
}
