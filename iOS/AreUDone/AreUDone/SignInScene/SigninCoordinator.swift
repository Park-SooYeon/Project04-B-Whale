//
//  SignInCoordinator.swift
//  AreUDone
//
//  Created by 서명렬 on 2020/11/18.
//

import NetworkFramework
import UIKit

final class SigninCoordinator: Coordinator {
  
  // MARK: - Property
  
  private var storyboard: UIStoryboard {
    return UIStoryboard.load(storyboard: .signin)
  }
  private let router: Routable
  
  init(router: Routable) {
    self.router = router
  }
  
  // MARK: - Method
  
  func start() -> UIViewController {
    guard let signInViewController = storyboard.instantiateViewController(
            identifier: SigninViewController.identifier,
            creator: { coder in
              let userService = UserService(router: self.router)
              let viewModel = SigninViewModel(userService: userService, videoPlayerLooper: VideoPlayerLooper())
              return SigninViewController(coder: coder, viewModel: viewModel)
            }) as? SigninViewController
    else { return UIViewController() }
    
    signInViewController.signinCoordinator = self
    
    return signInViewController
  }
}

// MARK: - Extension

extension SigninCoordinator {
  
  func openURL(endPoint: EndPointable) {
    guard let url = URL(string: "") else { return }
    if UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url)
    }
  }
}
