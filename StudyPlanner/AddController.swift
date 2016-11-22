//
//  AddController.swift
//  gayomi
//
//  Created by 윤종서 on 2016. 8. 30..
//  Copyright © 2016년 윤종서. All rights reserved.
//

import UIKit
import CoreData

class AddController: UIViewController, UINavigationControllerDelegate {
    
    let SignButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        button.setTitle("등록!", for: UIControlState())
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.rgb(255, green: 218, blue: 230)
        
        return button
    }()
    
    let RedValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    let GreenValueLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    let BlueValueLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let RedColorView: UIView = {
        let View = UIView()
        
        View.translatesAutoresizingMaskIntoConstraints = false
        
        View.layer.cornerRadius = 10
        View.backgroundColor = UIColor.red
        
        return View
    }()
    let BlueColorView: UIView = {
        let View = UIView()
        
        View.translatesAutoresizingMaskIntoConstraints = false
        View.layer.cornerRadius = 10
        View.backgroundColor = UIColor.blue
        
        return View
    }()

    let GreenColorView: UIView = {
        let View = UIView()
        
        View.translatesAutoresizingMaskIntoConstraints = false
        View.layer.cornerRadius = 10
        View.backgroundColor = UIColor.green
        
        return View
    }()


    
    let NameLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "과목명"
        label.font = UIFont(name: "IowanOldStyle-Bold", size: 15)
        
        return label
    }()
    let TextField: UITextField = {
        let tf = UITextField()
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "과목을 입력해 주셔요!"
        
        return tf
    }()
    let RedSlider: UISlider = {
        let sl = UISlider()
        sl.translatesAutoresizingMaskIntoConstraints = false
        sl.value = 0.5
        return sl
    }()
    let BlueSlider: UISlider = {
        let sl = UISlider()
        sl.translatesAutoresizingMaskIntoConstraints = false
        sl.value = 0.5
        
        return sl
    }()
    let GreenSlider: UISlider = {
        let sl = UISlider()
        sl.translatesAutoresizingMaskIntoConstraints = false
        sl.value = 0.5
        return sl
    }()
    let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-2"), style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        RedSlider.addTarget(self, action: #selector(setColorLabelValue), for: .valueChanged)
        BlueSlider.addTarget(self, action: #selector(setColorLabelValue), for: .valueChanged)
        GreenSlider.addTarget(self, action: #selector(setColorLabelValue), for: .valueChanged)
        SignButton.addTarget(self, action: #selector(SignUP), for: .touchUpInside)
        
        
        setColorLabelValue()
        SetupFirst()
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    func handleCancel() {
        let mainViewController = MainViewController()
        let navController = UINavigationController(rootViewController: mainViewController)
        
        
        present(navController, animated: true, completion: nil)
    }
    
    func SetupFirst() {
        
        view.addSubview(colorView)
        view.addSubview(RedSlider)
        view.addSubview(GreenSlider)
        view.addSubview(BlueSlider)
        view.addSubview(NameLabel)
        view.addSubview(TextField)
        view.addSubview(RedColorView)
        view.addSubview(RedValueLabel)
        view.addSubview(GreenColorView)
        view.addSubview(GreenValueLabel)
        view.addSubview(BlueColorView)
        view.addSubview(BlueValueLabel)
        view.addSubview(SignButton)
    
        TextField.bottomAnchor.constraint(equalTo: colorView.topAnchor, constant: -12).isActive = true
        TextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        TextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        TextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        NameLabel.bottomAnchor.constraint(equalTo: TextField.topAnchor, constant: -12).isActive = true
        NameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        NameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        NameLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        colorView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        colorView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        colorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        colorView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        
        RedColorView.centerYAnchor.constraint(equalTo: RedSlider.centerYAnchor).isActive = true
        RedColorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        RedColorView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        RedColorView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        RedSlider.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 12).isActive = true
        RedSlider.leftAnchor.constraint(equalTo: RedColorView.rightAnchor, constant: 12).isActive = true
        RedSlider.rightAnchor.constraint(equalTo: RedValueLabel.leftAnchor, constant: -12).isActive = true
        RedSlider.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        RedValueLabel.centerYAnchor.constraint(equalTo: RedSlider.centerYAnchor).isActive = true
        RedValueLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        RedValueLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        RedValueLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        ///////////////
        ///////////////
        GreenColorView.centerYAnchor.constraint(equalTo: GreenSlider.centerYAnchor).isActive = true
        GreenColorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        GreenColorView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        GreenColorView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        GreenSlider.topAnchor.constraint(equalTo: RedSlider.bottomAnchor, constant: 12).isActive = true
        GreenSlider.leftAnchor.constraint(equalTo: GreenColorView.rightAnchor, constant: 12).isActive = true
        GreenSlider.rightAnchor.constraint(equalTo: GreenValueLabel.leftAnchor, constant: -12).isActive = true
        GreenSlider.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        GreenValueLabel.centerYAnchor.constraint(equalTo: GreenSlider.centerYAnchor).isActive = true
        GreenValueLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        GreenValueLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        GreenValueLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        ///////////////
        ///////////////
        BlueColorView.centerYAnchor.constraint(equalTo: BlueSlider.centerYAnchor).isActive = true
        BlueColorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        BlueColorView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        BlueColorView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        BlueSlider.topAnchor.constraint(equalTo: GreenSlider.bottomAnchor, constant: 12).isActive = true
        BlueSlider.leftAnchor.constraint(equalTo: BlueColorView.rightAnchor, constant: 12).isActive = true
        BlueSlider.rightAnchor.constraint(equalTo: BlueValueLabel.leftAnchor, constant: -12).isActive = true
        BlueSlider.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        BlueValueLabel.centerYAnchor.constraint(equalTo: BlueSlider.centerYAnchor).isActive = true
        BlueValueLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        BlueValueLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        BlueValueLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        
        SignButton.topAnchor.constraint(equalTo: BlueSlider.bottomAnchor, constant: 12).isActive = true
        SignButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        SignButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        SignButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setColorLabelValue() {
        BlueValueLabel.text = "\(Float32(BlueSlider.value))"
        GreenValueLabel.text = "\(Float32(GreenSlider.value))"
        RedValueLabel.text = "\(Float32(RedSlider.value))"
        
        colorView.backgroundColor = UIColor.rgb(CGFloat(RedSlider.value)*255, green: CGFloat(GreenSlider.value)*255, blue: CGFloat(BlueSlider.value)*255)
    }
    func SignUP() {
        
        let mainViewController = MainViewController()
        let navController = UINavigationController(rootViewController: mainViewController)
        
        
        
        let textString: String = TextField.text!
        
        if(textString == ""){
            print("텍스트 입력해주라")
        }else{
            //mainViewController.tableView.reloadData()
            mainViewController.saveItem(textString, red: RedSlider.value, green: GreenSlider.value, blue: BlueSlider.value)
            mainViewController.SortAndList()
            present(navController, animated: true, completion: nil)
        }
        
        
    }
    
    
    
}
