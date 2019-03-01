//
//  UserAccountBalanceInteractorTestCase.swift
//  TesteiOSV2_Rafael_HiedaTests
//
//  Created by Rafael Hieda on 01/03/19.
//  Copyright © 2019 Rafael Hieda. All rights reserved.
//

import XCTest
@testable import TesteiOSV2_Rafael_Hieda

class UserAccountBalanceInteractorTestCase: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        interactor = UserAccountBalanceInteractor()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    var interactor : UserAccountBalanceInteractor?
    
    class WorkerSpy : BankWorkerDataProtocol {
        var baseUrl: String = ""
        var isAccountBalanceCalled = false
        
        func login(_ userLogin: UserLogin, completionHandler: @escaping (UserResponse) -> Void) {
            //do nothing at all
        }
        
        func getAccountBalance(_ id: Int, completionHandler: @escaping (AccountBalance) -> Void) {
            isAccountBalanceCalled = true
            let accountBalance = AccountBalance()
            completionHandler(accountBalance)
            
        }
    }
    
    class PresenterSpy : UserAccountBalancePresentationLogic {
        var presentedAccountBalance = false
        func presentAccountBalance(response: AccountBalance) {
            presentedAccountBalance = true
        }
    }
    
    func testInteractorShouldBringDataFromWorkerAndPassToPresenter() {
        let presenter = PresenterSpy()
        let worker = WorkerSpy()
        
        interactor?.worker = worker
        interactor?.presenter = presenter
    
        interactor?.loadRegistry(id: 10)
        
        XCTAssertEqual(worker.isAccountBalanceCalled, true)
        XCTAssertEqual(presenter.presentedAccountBalance, true)
        
    }
}
