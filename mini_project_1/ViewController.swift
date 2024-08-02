//
//  ViewController.swift
//  mini_project_1
//
//  Created by FDC-KYLE-NC-WEB on 7/29/24.
//

import UIKit
import SwiftUI
import Combine

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var viewModel = TeacherViewModel()
    private var detailsViewModel = TeacherDetailModel()
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var rankingScrollView: UIScrollView!
    @IBOutlet weak var lessonDraw: UIStackView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!

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

        viewModel.$teacherlist
            .sink { [weak self] _ in
                self?.tableView.reloadData()
                self?.populateRankingScrollView() // Call after data is fetched
            }
            .store(in: &cancellables)

        detailsViewModel.fetchTeacherDetails()
        // Fetch data
        viewModel.fetchTeacher()
        
        // Call APIHelper
        let apiHelper = APIHelper()
        apiHelper.request { result in
            switch result {
            case .success(let json):
                print("Received JSON: \(json)")
                // Handle the JSON data here, e.g., update UI on the main thread
                DispatchQueue.main.async {
                    // Update your UI or view model here
                }
            case .failure(let error):
                print("Failed with error: \(error)")
                // Handle the error here, e.g., show an alert
            }
        }
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
        
        if !UserDefaults.standard.bool(forKey: "hasPresentedTabBar") {
            presentTabBarController()
            UserDefaults.standard.set(true, forKey: "hasPresentedTabBar")
        }
    }
    
    func populateRankingScrollView() {
        rankingScrollView.subviews.forEach { $0.removeFromSuperview() }
//        print("teacherCount:\(viewModel.teacherlist.teachers.count)")
        let padding: CGFloat = 10
        let imageSize: CGFloat = 100
        let totalWidth = CGFloat(viewModel.teacherlist.teachers.count) * (imageSize + padding) + padding
        rankingScrollView.contentSize = CGSize(width: totalWidth, height: rankingScrollView.frame.height)
        
        for (index, teacher) in viewModel.teacherlist.teachers.enumerated() {
//            print("Teacher image URL: \(teacher.imageMain)")
//            print("Teacher image URL:")
            let imageView = UIImageView()
            imageView.frame = CGRect(x: CGFloat(index) * (imageSize + padding) + padding,
                                     y: 0,
                                     width: imageSize,
                                     height: imageSize)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 5
            imageView.isUserInteractionEnabled = true
            
            // Load image from URL
            if let imageURLString = teacher.imageMain, let imageURL = URL(string: imageURLString) {
                imageView.loadImage(from: imageURL, placeholder: UIImage(named: "placeholder")) // Use a placeholder if needed
            } else {
                imageView.image = UIImage(named: "placeholder") // Fallback image if URL is invalid
            }
            
            // Uncomment if you want to add gesture recognizers
            // let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap(_:)))
            // imageView.addGestureRecognizer(tapGesture)
            // imageView.tag = index
            
            rankingScrollView.addSubview(imageView)
        }
    }
    
//    @objc func handleImageTap(_ sender: UITapGestureRecognizer) {
//        guard let imageView = sender.view as? UIImageView else { return }
//        let index = imageView.tag
//        guard index >= 0 && index < viewModel.teacherlist.teachers.count else { return }
//
//        let selectedTeacher = viewModel.teacherlist.teachers[index]
//
//        print(selectedTeacher)
//        
//        let waitingDetailView = WaitingDetails(teacher: selectedTeacher, allData: viewModel.teacherlist.teachers)
//        let host = UIHostingController(rootView: waitingDetailView)
//        
//        if let navController = self.navigationController {
//            navController.pushViewController(host, animated: true)
//        }
//    }

    func presentTabBarController() {
        let tabBarVc = UITabBarController()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else {
            print("Failed to instantiate ViewController with identifier 'ViewController'.")
            return
        }
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house")?.withRenderingMode(.alwaysTemplate), tag: 0)

        let vc1 = FirstViewController()
        vc1.tabBarItem = UITabBarItem(title: "Favorite tutor", image: UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate), tag: 1)

        let vc2 = SecondViewController()
        vc2.tabBarItem = UITabBarItem(title: "Textbook", image: UIImage(systemName: "book.closed")?.withRenderingMode(.alwaysTemplate), tag: 2)
        
        let vc3 = ThirdViewController()
        vc3.tabBarItem = UITabBarItem(title: "Learning", image: UIImage(systemName: "pencil.line")?.withRenderingMode(.alwaysTemplate), tag: 3)

        let vc4 = FourthViewController()
        vc4.tabBarItem = UITabBarItem(title: "My Page", image: UIImage(systemName: "person")?.withRenderingMode(.alwaysTemplate), tag: 4)

        tabBarVc.viewControllers = [navigationController, vc1, vc2, vc3, vc4]

        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = UIColor.black
            
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
            tabBarVc.tabBar.barTintColor = UIColor.black
            tabBarVc.tabBar.tintColor = UIColor.white
            tabBarVc.tabBar.unselectedItemTintColor = UIColor.gray
        }

        tabBarVc.modalPresentationStyle = .fullScreen
        present(tabBarVc, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.teacherlist.teachers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let teacher = viewModel.teacherlist.teachers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        cell.teacherName.text = teacher.nameEng
        
        if let imageURLString = teacher.imageMain, let imageURL = URL(string: imageURLString) {
            cell.iconImageView.loadImage(from: imageURL, placeholder: UIImage(named: "placeholder"))
        } else {
            cell.iconImageView.image = UIImage(named: "placeholder") // Fallback image
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTeacher = viewModel.teacherlist.teachers[indexPath.row]
        
        // Initialize APIHelper and make the request
        let apiHelper = APIHelper()
        apiHelper.request { [weak self] result in
            switch result {
            case .success(let json):
                print("Received JSON: \(json)")
                
                // Parse the JSON data into a suitable model if necessary
                // Here you should parse the JSON data into your model, e.g., TeacherDetailList
                // For simplicity, let's assume you have a method to parse this JSON into a model
                do {
                    let data = try JSONSerialization.data(withJSONObject: json, options: [])
                    let decodedDetails = try JSONDecoder().decode(TeacherDetailList.self, from: data)
                    
                    DispatchQueue.main.async {
                        // Create the WaitingDetails view with the fetched data
                        let waitingDetailView = WaitingDetails(
                            teacher: selectedTeacher,
                            allData: self?.viewModel.teacherlist.teachers ?? []
                        )
                        let host = UIHostingController(rootView: waitingDetailView)
                        
                        if let navController = self?.navigationController {
                            navController.pushViewController(host, animated: true)
                        }
                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                    DispatchQueue.main.async {
                        // Handle the error, e.g., show an alert
                    }
                }
                
            case .failure(let error):
                print("Failed with error: \(error)")
                DispatchQueue.main.async {
                    // Handle the error, e.g., show an alert
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension UIImageView {
    func loadImage(from url: URL, placeholder: UIImage? = nil) {
        // Set placeholder image
        self.image = placeholder
        
        // Start a background task to fetch the image
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                print("Failed to load image from URL: \(url), error: \(String(describing: error))")
                return
            }
            
            // Update UI on the main thread
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
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

