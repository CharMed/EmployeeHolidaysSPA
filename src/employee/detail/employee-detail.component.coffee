((angular) ->
    EmployeeDetailCntl = ($scope, $element, $attrs) ->
        console.log 'This is EmployeeDetailCntl'
        return

    angular.module('employee.detail', [])
        .component 'ehaEmployeeDetail',
        templateUrl: './template/employee-detail.component.html'
        controller: EmployeeDetailCntl
    return
)(window.angular)