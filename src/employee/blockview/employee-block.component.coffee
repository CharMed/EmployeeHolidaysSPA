((angular) ->
    EmployeeBlockViewCntl = ($scope, $element, $attrs) ->
        console.log 'This is BlockViewCntl'
        return

    angular.module('employee.blockview', [])
        .component 'ehaEmployeeBlock',
        templateUrl: './template/employee-block.component.html'
        controller: EmployeeBlockViewCntl
    return
)(window.angular)