//
//  UserAccountBalancePresenterTestCase.swift
//  TesteiOSV2_Rafael_HiedaTests
//
//  Created by Rafael Hieda on 01/03/19.
//  Copyright © 2019 Rafael Hieda. All rights reserved.
//

import XCTest
@testable import TesteiOSV2_Rafael_Hieda

class UserAccountBalancePresenterTestCase: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        presenter = UserAccountBalancePresenter()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    var presenter : UserAccountBalancePresenter?
    
    class ViewControllerSpy : UserAccountBalanceDisplayLogic {
        var vm: [Registry]?
        var isViewControllerCalled = false
        func displayRegistries() {
            isViewControllerCalled = true
        }
        
    }
    
    func testPresenterPassDataToDisplayToViewController() {
        let controller = ViewControllerSpy()
        presenter?.viewController = controller
        let accountBalance = AccountBalance()
        accountBalance.statementList = [Registry()]
        presenter?.presentAccountBalance(response: accountBalance)
        XCTAssertEqual(controller.isViewControllerCalled, true)
    }

}
