//
//  ViewController.swift
//  mini_project_1
//
//  Created by FDC-KYLE-NC-WEB on 7/29/24.
//

import UIKit
import SwiftUI

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    let data: [Teacher] = [
        Teacher(title:"TeacherOne", imageName: "teacher"),
        Teacher(title:"TeacherCat", imageName: "cat"),
        Teacher(title:"TeacherDOG", imageName: "dog"),
        Teacher(title:"TeacherBini", imageName: "bini_2"),
        Teacher(title:"TeacherOne", imageName: "teacher"),
        Teacher(title:"TeacherOne", imageName: "teacher")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let teacher = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.teacherName.text = teacher.title
        cell.iconImageView.image = UIImage(named: teacher.imageName)
        cell.selectionStyle = .none
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTeacher = data[indexPath.row]
        
        print(selectedTeacher)
        
        let waitingDetailView = WaitingDetails(teacher: selectedTeacher)
        let host = UIHostingController(rootView: waitingDetailView)
        
        if let navigationController = self.navigationController{
            navigationController.pushViewController(host, animated: true)
        } else {
            print("error")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

//    @IBAction func navigateButton(_ sender: Any) {
//        
//        let vc = UIHostingController(rootView: WaitingDetails())
//        
//        self.present(vc, animated: true)
//    }
    
}

