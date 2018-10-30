//
//  UserAccountBalancePresenter.swift
//  TesteiOSV2_Rafael_Hieda
//
//  Created by Rafael  Hieda on 10/29/18.
//  Copyright (c) 2018 Rafael Hieda. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol UserAccountBalancePresentationLogic
{
  func presentSomething(response: UserAccountBalance.Something.Response)
  func presentAccountBalance(response : AccountBalance)
}

class UserAccountBalancePresenter: UserAccountBalancePresentationLogic
{
  weak var viewController: UserAccountBalanceDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: UserAccountBalance.Something.Response)
  {
    let viewModel = UserAccountBalance.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
    
    func presentAccountBalance(response: AccountBalance)
    {
        
    }
    
    
}