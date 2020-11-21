//
//  TabbarCoordinator.swift
//  AreUDone
//
//  Created by a1111 on 2020/11/21.
//

import UIKit
import NetworkFramework


final class TabbarCoordinator: Coordinator {
  
  // MARK: - Property
  private let router: Router
  private let signInCoordinator: SigninCoordinator
  
  private let tabbarController: UITabBarController
  private let coordinators: [Coordinator]
  
  private var controllers: [UINavigationController] = []
  
  // MARK: - Initializer
  
  init(
    router: Router,
    signInCoordinator: SigninCoordinator,
    tabbarController: UITabBarController,
    coordinators: [Coordinator]
  ) {
    self.router = router
    self.signInCoordinator = signInCoordinator
    self.tabbarController = tabbarController
    self.coordinators = coordinators
  }
  
  
  // MARK: - Method
  
  func start() -> UIViewController {
    // TODO: 캘린더, 보드, 환경설정 넣을 예정
    coordinators.forEach {
      configureController(with: $0)
    }
    
    tabbarController.viewControllers = controllers
     
    return tabbarController
  }
  
  private func configureController(with coordinator: Coordinator) {
    let navigationController = UINavigationController()
    
    let viewController = coordinator.start()
    navigationController.pushViewController(viewController, animated: false)
    navigationController.tabBarItem = UITabBarItem(title: "캘린더", image: UIImage(systemName: "circle"), tag: 0)
    
    controllers.append(navigationController)
  }
}