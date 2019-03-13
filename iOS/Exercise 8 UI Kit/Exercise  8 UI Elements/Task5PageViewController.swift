//
//  Task5PageViewController.swift
//  Exercise  8 UI Elements
//
//  Created by Abhishek Maurya on 12/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class Task5PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Task 5 Navigation Bar"
        self.dataSource = self
        if let firstViewController = pageViewControllerArray.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }

        // Do any additional setup after loading the view.
    }
    
    lazy var pageViewControllerArray: [UIViewController] = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let firstController = storyboard.instantiateViewController(withIdentifier: "FirstViewController")
        let secondController = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        let thirdController = storyboard.instantiateViewController(withIdentifier: "ThirdViewController")
        return [firstController, secondController, thirdController]
    }()
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerCount = pageViewControllerArray.index(of: viewController) else {
            return nil
        }
        let previousPage = viewControllerCount - 1
        guard previousPage >= 0 else {
            return nil
        }
        guard pageViewControllerArray.count > previousPage else {
            return nil
        }
        return pageViewControllerArray[previousPage]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerCount = pageViewControllerArray.index(of: viewController) else {
            return nil
        }
        let nextPage = viewControllerCount + 1
        guard pageViewControllerArray.count != nextPage else {
            return nil
        }
        guard pageViewControllerArray.count > nextPage else {
            return nil
        }
        return pageViewControllerArray[nextPage]
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
