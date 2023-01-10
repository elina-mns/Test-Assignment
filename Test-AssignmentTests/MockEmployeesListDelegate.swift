import Foundation
@testable import Test_Assignment

final class MockEmployeesListDelegate: EmployeesListViewModelDelegate {
    
    var invokeLoadingStarted: Bool = false
    var invokeLoadingEnded: Bool = false
    var invokeEmptyViewIsHidden: Bool = false
    var invokeEmptyViewIsVisible: Bool = false
    var invokeShowAlertTitle: String = ""
    var invokeShowAlertMessage: String = ""
    var invokeShowAlertOkAction: (() -> Void)? = nil
    
    func showAlert(title: String, message: String, okAction: (() -> Void)?) {
        invokeShowAlertTitle = title
        invokeShowAlertMessage = message
        invokeShowAlertOkAction = okAction
    }
    
    func loadingStarted() {
        invokeLoadingStarted = true
    }
    
    func loadingEnded() {
        invokeLoadingEnded = true
    }
    
    func emptyViewIsHidden() {
        invokeEmptyViewIsHidden = true
    }
    
    func emptyViewIsVisible() {
        invokeEmptyViewIsVisible = true
    }
}
