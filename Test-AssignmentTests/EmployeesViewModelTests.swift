import XCTest
@testable import Test_Assignment

final class EmployeesViewModelTests: XCTestCase {
    
    private var sut: EmployeesListViewModel!
    private var mockEmployeesListDelegate: MockEmployeesListDelegate!
    private var mockEmployeesAPI: MockEmployeeAPI!

    override func setUpWithError() throws {
       try super.setUpWithError()
        mockEmployeesListDelegate = MockEmployeesListDelegate()
        mockEmployeesAPI = MockEmployeeAPI()
        sut = EmployeesListViewModel(employeeAPI: mockEmployeesAPI)
        sut.delegate = mockEmployeesListDelegate
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        mockEmployeesAPI = nil
        mockEmployeesListDelegate = nil
    }
    
    private func employeeListModel() -> EmployeesListModel {
        return EmployeesListModel(employees: [
            EmployeeModel(fullName: "Steve Buscemi",
                          phoneNumber: "1231231234".toPhoneNumber(),
                          emailAddress: "steeeve@gmail.com",
                          biography: "To me, it doesn't really matter how big the part is as long as the part is important to the story.",
                          smallPhotoURL: "",
                          largePhotoURL: "",
                          team: "Hollywood",
                          employeeType: .fullTime)
        ])
    }
    
    func test_loadData_success() {
        mockEmployeesAPI.stubbedResult = .success(employeeListModel())
        
        sut.loadData()
        waitForNextMainQueueDispatch()
        
        XCTAssertTrue(mockEmployeesListDelegate.invokeLoadingStarted)
        XCTAssertTrue(mockEmployeesListDelegate.invokeLoadingEnded)
        XCTAssertTrue(mockEmployeesListDelegate.invokeEmptyViewIsHidden)
        XCTAssertFalse(mockEmployeesListDelegate.invokeEmptyViewIsVisible)
    }
    
    func test_loadData_emptyList() {
        mockEmployeesAPI.stubbedResult = .success(EmployeesListModel(employees: [
        ]))
        
        sut.loadData()
        waitForNextMainQueueDispatch()
        
        XCTAssertTrue(mockEmployeesListDelegate.invokeLoadingStarted)
        XCTAssertTrue(mockEmployeesListDelegate.invokeLoadingEnded)
        XCTAssertFalse(mockEmployeesListDelegate.invokeEmptyViewIsHidden)
        XCTAssertTrue(mockEmployeesListDelegate.invokeEmptyViewIsVisible)
    }
    
    func test_loadData_failure() {
        mockEmployeesAPI.stubbedResult = .failure(EmployeeListAPI.APIError.badResponse)
        
        sut.loadData()
        
        waitForNextMainQueueDispatch()
        
        XCTAssertTrue(mockEmployeesListDelegate.invokeLoadingStarted)
        XCTAssertTrue(mockEmployeesListDelegate.invokeLoadingEnded)
        XCTAssertFalse(mockEmployeesListDelegate.invokeEmptyViewIsHidden)
        XCTAssertTrue(mockEmployeesListDelegate.invokeEmptyViewIsVisible)
        XCTAssertEqual(mockEmployeesListDelegate.invokeShowAlertTitle, "Error")
        XCTAssertEqual(mockEmployeesListDelegate.invokeShowAlertMessage, "Couldn't load employees list. Press Ok to try again.")
        XCTAssertTrue(mockEmployeesListDelegate.invokeShowAlertOkAction != nil)
    }
    
    private func waitForNextMainQueueDispatch() {
        let expectation = expectation(description: "main queue dispatch")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_employeeModel() {
        mockEmployeesAPI.stubbedResult = .success(employeeListModel())
        
        sut.loadData()
        waitForNextMainQueueDispatch()
        
        XCTAssertNil(sut.employeeModel(for: IndexPath(row: 2, section: 2)))
        XCTAssertNotNil(sut.employeeModel(for: IndexPath(row: 0, section: 0)))
    }
}
