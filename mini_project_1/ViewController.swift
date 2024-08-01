//
//  ViewController.swift
//  mini_project_1
//
//  Created by FDC-KYLE-NC-WEB on 7/29/24.
//

import UIKit
import SwiftUI

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var rankingScrollView: UIScrollView!
    @IBOutlet weak var lessonDraw: UIStackView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    let data: [Teacher] = [
        Teacher(title:"TeacherOne", imageName: "teacher", status: "busy"),
        Teacher(title:"TeacherCat", imageName: "cat", status: "offline"),
        Teacher(title:"TeacherDOG", imageName: "dog", status: "busy"),
        Teacher(title:"TeacherBini", imageName: "bini_2", status: "busy"),
        Teacher(title:"TeacherOne", imageName: "teacher", status: "offline"),
        Teacher(title:"TeacherOne", imageName: "teacher", status: "offline")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
   
        guard tableView != nil else {
            fatalError("TableView not connected or initialized.")
        }
        tableView.dataSource = self
        tableView.delegate = self
        mainScrollView.delegate = self
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        lessonDraw.layer.cornerRadius = lessonDraw.frame.height / 2
                lessonDraw.layer.masksToBounds = true
        
        populateRankingScrollView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        populateRankingScrollView() // Recalculate sizes and positions on layout changes
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if scrollView == mainScrollView {
                let xOffset = scrollView.contentOffset.x + 280
                let yOffset = scrollView.contentOffset.y + 715
                lessonDraw.frame.origin = CGPoint(x: xOffset, y: yOffset)
            }
        }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Check if tab bar controller has been presented before
        if !UserDefaults.standard.bool(forKey: "hasPresentedTabBar") {
            presentTabBarController()
            UserDefaults.standard.set(true, forKey: "hasPresentedTabBar")
        }
    }
    
    func populateRankingScrollView() {
        // Clear any existing subviews
        rankingScrollView.subviews.forEach { $0.removeFromSuperview() }
        
        let padding: CGFloat = 10
        let imageSize: CGFloat = 100
        let totalWidth = CGFloat(data.count) * (imageSize + padding) + padding
        
        rankingScrollView.contentSize = CGSize(width: totalWidth, height: rankingScrollView.frame.height)
        
        for (index, teacher) in data.enumerated() {
            let imageView = UIImageView(image: UIImage(named: teacher.imageName))
            imageView.frame = CGRect(x: CGFloat(index) * (imageSize + padding) + padding,
                                     y: 0,
                                     width: imageSize,
                                     height: imageSize)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 5
            imageView.isUserInteractionEnabled = true // Enable user interaction
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap(_:)))
            imageView.addGestureRecognizer(tapGesture)
            imageView.tag = index
            
            rankingScrollView.addSubview(imageView)
        }
    }
    
    @objc func handleImageTap(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else { return }
        let index = imageView.tag
        guard index >= 0 && index < data.count else { return }
        
        let selectedTeacher = data[index]
        
        print(selectedTeacher)
        
        let waitingDetailView = WaitingDetails(teacher: selectedTeacher, allData: data)
        let host = UIHostingController(rootView: waitingDetailView)
        
        if let navController = self.navigationController {
            navController.pushViewController(host, animated: true)
        }
    }

    func presentTabBarController() {
        let tabBarVc = UITabBarController()

        // Create instances of your view controllers
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else {
            print("Failed to instantiate ViewController with identifier 'ViewController'.")
            return
        }
        
        // Wrap the ViewController in a UINavigationController
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house")?.withRenderingMode(.alwaysTemplate), tag: 0)

        // Create other view controllers
        let vc1 = FirstViewController()
        vc1.tabBarItem = UITabBarItem(title: "Favorite tutor", image: UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate), tag: 1)

        let vc2 = SecondViewController()
        vc2.tabBarItem = UITabBarItem(title: "Textbook", image: UIImage(systemName: "book.closed")?.withRenderingMode(.alwaysTemplate), tag: 2)
        
        let vc3 = ThirdViewController()
        vc3.tabBarItem = UITabBarItem(title: "Learning", image: UIImage(systemName: "pencil.line")?.withRenderingMode(.alwaysTemplate), tag: 3)

        let vc4 = FourthViewController()
        vc4.tabBarItem = UITabBarItem(title: "My Page", image: UIImage(systemName: "person")?.withRenderingMode(.alwaysTemplate), tag: 4)

        tabBarVc.viewControllers = [navigationController, vc1, vc2, vc3, vc4]

        // Customize the tab bar appearance
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = UIColor.black // Tab bar background color
            
            // Configure item appearance for both normal and selected states
            let itemAppearance = UITabBarItemAppearance()
            itemAppearance.normal.iconColor = UIColor.gray
            itemAppearance.selected.iconColor = UIColor.white
            itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
            itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

            appearance.stackedLayoutAppearance = itemAppearance
            appearance.inlineLayoutAppearance = itemAppearance
            appearance.compactInlineLayoutAppearance = itemAppearance
            
            tabBarVc.tabBar.standardAppearance = appearance
            tabBarVc.tabBar.scrollEdgeAppearance = appearance
        } else {
            // Fallback on earlier versions
            tabBarVc.tabBar.barTintColor = UIColor.black
            tabBarVc.tabBar.tintColor = UIColor.white
            tabBarVc.tabBar.unselectedItemTintColor = UIColor.gray
        }

        // Present the tab bar controller
        tabBarVc.modalPresentationStyle = .fullScreen
        present(tabBarVc, animated: false)
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
        
        let waitingDetailView = WaitingDetails(teacher: selectedTeacher, allData: data)
        let host = UIHostingController(rootView: waitingDetailView)
        
        if let navController = self.navigationController {
            navController.pushViewController(host, animated: true)
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

class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }
}

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
}

class ThirdViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

class FourthViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

