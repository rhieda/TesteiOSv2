//
//  LoginPresenter.swift
//  TesteiOSV2_Rafael_Hieda
//
//  Created by Rafael  Hieda on 10/28/18.
//  Copyright (c) 2018 Rafael Hieda. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LoginPresentationLogic
{
    func presentUserData(_ response : UserResponse)
}

class LoginPresenter: LoginPresentationLogic
{
  weak var viewController: LoginDisplayLogic?
  
  // MARK: Do something
  
    func presentUserData(_ response : UserResponse)
    {
        if let userAccount = response.userAccount
        {
            viewController?.storeUserResponseCredentials(viewModel: userAccount)
        }
    }
}
