((angular) ->
  class EmployeeListCntl
    constructor: (EmployeeService, UtilService) ->
      @service = EmployeeService
      @util = UtilService
      # console.log 'This is EmployeeListCntl'
    $onInit: () ->
      # @typeslist = @util.missingdaysTypesToArray()
      @fullData = angular.copy(@employeers)
      @search = null
      # @status = @util.missingdaystypes.working.id
      @activity = true

  angular.module('employee.list', ['employee.blockview', 'employee.employee-service', 'util.service'])
  .component 'ehaEmployeeList',
      templateUrl: './template/employee-list.component.html'
      controller: ['EmployeeService', 'UtilService', EmployeeListCntl],
      bindings:
        'employeers' : '<'
  return
)(window.angular)