((angular) ->
  class EmployeeBlockViewCntl
    constructor: (UtilService) ->
      @util = UtilService
    $onInit:()->
      if not(@add)
        @employee.statusClass = @getClass(@employee.activity)
      return
    getClass:(status)->
      if (status )
        'text-success'
      else
        'text-muted'
        
  angular.module('employee.blockview', [
    'ui.router',
    'util.service',
    'ui.bootstrap.tooltip'])
    .component 'ehaEmployeeBlock',
      templateUrl: './template/employee-block.component.html'
      controller: ['UtilService', EmployeeBlockViewCntl],
      bindings:
        employee: '<'
        add: '<'
  return
)(window.angular)