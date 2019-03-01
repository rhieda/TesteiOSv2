//
//  LoginPresenterTestCase.swift
//  TesteiOSV2_Rafael_HiedaTests
//
//  Created by Rafael Hieda on 01/03/19.
//  Copyright © 2019 Rafael Hieda. All rights reserved.
//

import XCTest
@testable import TesteiOSV2_Rafael_Hieda

class LoginPresenterTestCase: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        presenter = LoginPresenter()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    var presenter : LoginPresenter?
    
    //MARK: - Doubles
    class ViewControllerSpy : LoginDisplayLogic {
        var isViewControllerPassingDataToRouter = false
        //MARK: Spied Methods
        func storeUserResponseCredentials(viewModel: UserAccount) {
            isViewControllerPassingDataToRouter = true
        }
    }
    
    func testPresenterShouldReceiveDataAndPassToViewControllerToDisplay() {
        let controller = ViewControllerSpy()
        presenter?.viewController = controller
        let userAccount = UserAccount()
        let error = ResponseError()
        let userResponse = UserResponse(account: userAccount , error: error)
        presenter?.presentUserData(userResponse)
        
        XCTAssertEqual(controller.isViewControllerPassingDataToRouter, true)
    }
    
}
