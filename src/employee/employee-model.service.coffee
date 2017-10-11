((angular) ->
    angular.module('employee.employee-model', [])
        .factory 'EmployeeModelService', [() ->
            new class EmployeeModelService
                constructor: ->
                    console.log 'This is EmployeeModelService'
    ]
)(window.angular)