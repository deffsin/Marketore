//
//  MarketoreTests.swift
//  MarketoreTests
//
//  Created by Denis Sinitsa on 28.02.2024.
//

import XCTest
@testable import Marketore

final class MarketoreTests: XCTestCase {
    var viewModel: ChooseCategoryViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        viewModel = ChooseCategoryViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertNil(viewModel.selectedTag, "Изначально selectedTag должен быть nil")
        XCTAssertFalse(viewModel.isButton, "Изначально isButton должен быть false")
    }
    
    func testSaveDataAndNavigate() {
        // Сценарий без выбранной категории.
        viewModel.selectedTag = nil
        viewModel.initiateSavingCategory()
        XCTAssertFalse(viewModel.isButton, "isButton не должен переключаться, если selectedTag равен nil.")
        
        // Сценарий с выбранной категорией.
        viewModel.selectedTag = .computers
        viewModel.initiateSavingCategory()
        
        // Поскольку операция синхронная, мы можем сразу проверить результат без ожиданий.
        XCTAssertTrue(viewModel.isButton, "isButton должен переключаться, если selectedTag не равен nil.")
    }
}
