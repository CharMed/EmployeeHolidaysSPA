((angular) ->
    EmployeeListCntl = ['$scope', '$element', '$attrs', ($scope, $element, $attrs) ->
        console.log 'This is EmployeeListCntl'
        return
    ]
    
    angular.module('employee.list', [])
        .component 'ehaEmployeeList',
        templateUrl: './template/employee-list.component.html'
        controller: EmployeeListCntl
    return
)(window.angular)