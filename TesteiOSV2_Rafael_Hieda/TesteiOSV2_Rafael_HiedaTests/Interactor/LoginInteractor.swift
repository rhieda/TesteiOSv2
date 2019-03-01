//
//  LoginInteractor.swift
//  TesteiOSV2_Rafael_HiedaTests
//
//  Created by Rafael Hieda on 01/03/19.
//  Copyright © 2019 Rafael Hieda. All rights reserved.
//

import XCTest
@testable import TesteiOSV2_Rafael_Hieda

class LoginInteractorTestCase: XCTestCase {
    
    var interactor : LoginInteractor!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        interactor = LoginInteractor()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //MARK: - Test doubles
    
    class WorkerProtocolSpy : BankWorkerDataProtocol {
        var baseUrl: String = ""
        
        
        func login(_ userLogin: UserLogin, completionHandler: @escaping (UserResponse) -> Void) {
            isLoginCalled = true
            let userAccount = UserAccount()
            let error = ResponseError()
            let userResponse = UserResponse(account: userAccount , error: error)
            completionHandler(userResponse)
            
        }
        
        func getAccountBalance(_ id: Int, completionHandler: @escaping (AccountBalance) -> Void) {
            //do nothing here
        }
        
        var isLoginCalled : Bool = false
        var isGetAccountCalled : Bool = false
    }
    
    class PresenterProtocolSpy : LoginPresentationLogic {
        var presentUserData = false
        
        func presentUserData(_ response : UserResponse) {
            presentUserData = true
        }
        
    }
    
    //MARK: - Unit Testing
    
    func testLoginAndPassDataToPresenter() {
        let presenterSpy = PresenterProtocolSpy()
        let workerSpy = WorkerProtocolSpy()
        interactor.presenter = presenterSpy
        interactor.worker = workerSpy
        
        let login = UserLogin("teste", password: "@123Qa")
        interactor.login(login)
        XCTAssertEqual(presenterSpy.presentUserData, true)
        XCTAssertEqual(workerSpy.isLoginCalled, true)
    }

}
