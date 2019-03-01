//
//  UserAccountBalanceViewController.swift
//  TesteiOSV2_Rafael_HiedaTests
//
//  Created by Rafael Hieda on 01/03/19.
//  Copyright © 2019 Rafael Hieda. All rights reserved.
//

import XCTest
@testable import TesteiOSV2_Rafael_Hieda

class UserAccountBalanceViewControllerTestCase: XCTestCase {
    
    var window : UIWindow!
    var controller : UserAccountBalanceViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        window = UIWindow()
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        controller = storyboard.instantiateViewController(withIdentifier: "UserAccountBalanceViewController") as! UserAccountBalanceViewController
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func loadView() {
        window.addSubview(controller.view)
        RunLoop.current.run(until: Date())
    }
    
    //MARK: Test Doubles
    
    class UserAccountBalanceInteractorSpy : UserAccountBalanceBusinessLogic {
        var didLoadRegistry = false
        func loadRegistry(id: Int) {
            didLoadRegistry = true
        }
    }
    
    class TableViewSpy : UITableView {
        var reloadCalled = false
        override func reloadData() {
            reloadCalled = true
        }
    }

    func testShouldBringRegistriesWhenInViewDidLoad() {
        let interactor = UserAccountBalanceInteractorSpy()
        controller.interactor = interactor
        let account = UserAccount()
        account.userId = 1
        controller.userAccount = account
        loadView()
        
        //when
        controller.viewDidLoad()
        XCTAssertEqual(interactor.didLoadRegistry, true)
        //XCTAssertEqual(tableView.reloadCalled, true)
    }
    
    func testShouldDisplayFetchedRegistries() {
        let registry = Registry()
        registry.date = String("20-10-2018")
        registry.title = "Food"
        registry.value = 33.23
        registry.description = "Lunch with peers"
        let registries = [registry]
        
        let tableView = TableViewSpy()
        
        controller.tableView = tableView
        controller.vm = registries
        
        controller.displayRegistries()
        XCTAssertEqual(tableView.reloadCalled, true)
        
    }
    
    func testTableViewShouldHaveOneSectionOnly() {
        let tableView = TableViewSpy()
        controller.tableView = tableView
        let numberOfSections = tableView.numberOfSections
        
        XCTAssertEqual(numberOfSections, 1, "Should have only one")
    }
    
    func testTableViewShouldHaveExactNumberOfRowsComparedToViewModel() {
        let registry = Registry()
        registry.date = String("20-10-2018")
        registry.title = "Food"
        registry.value = 33.23
        registry.description = "Lunch with peers"
        let vm = [registry]
        let expected = vm.count
        
        let tableView = TableViewSpy()
        controller.vm = vm
        controller.tableView = tableView
        //controller.tableView.reloadData()
        let rows = controller.tableView(tableView, numberOfRowsInSection : 0)
        
        XCTAssertEqual(rows, expected, "Same number of rows are expected from viewModel to tableView")
    }
    
    func testTableViewShouldDisplayCellInfoCorrectly() {
        
        let registry = Registry()
        registry.date = String("20-10-2018")
        registry.description = "Food"
        registry.value = 33.23
        let vm = [registry]
        
        controller.vm = vm
    
        let tableView = TableViewSpy()
        controller.tableView = tableView
        let indexPath = IndexPath(item: 0, section: 0)
        controller.viewDidAppear(true)
        let cell = controller.tableView(tableView, cellForRowAt: indexPath) as! RegistryTableViewCell
        
        XCTAssertEqual("20-10-2018", cell.dataTextField.text , "Date should be equal")
        XCTAssertEqual("Food", cell.descricaoTextField.text , "description should be equal")
        XCTAssertEqual(String.valueToBRL(value: registry.value!), cell.pagamentoTextField.text , "Amount paid should be equal")
        
    }

}
