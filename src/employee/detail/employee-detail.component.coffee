((angular) ->
  class EmployeeDetailCntl
    constructor: ($stateParams, $state, UtilService, EmployeeService) ->
      @service = EmployeeService
      @util = UtilService
      @stateParams = $stateParams
      @state = $state
      # console.log 'This is EmployeeDetailCntl'
    $onInit:->
      # console.log @employeer
      @mode = if (@stateParams.id is 'new') then 'add' else 'edit'
      @empl = @employee
      @empl.dateStart = new Date(@employee.dateStart)
      @empl.dateEnd= new Date(@employee.dateEnd) if @employee.dateEnd?
      @dateOptions =
        custumClass: @getDayClass,
        startingDay: 1
    
    getDayClass:(data)=>
      mode = data.mode
      date = data.date
      'is-weekends' if (mode is 'day') and (@util.isDateInList(date, @weekends))

    add:() ->
      @service.add(@empl).then(
        (data)=>
          console.log 'Success'
          @back()
        , (err) -> console.log err
      )
    
    edit: () ->
      @service.edit(@empl).then(
        (data)=>
          console.log 'Success'
          @back()
      , (err) -> console.log err )

    resume: () ->
      @service.resume(@empl).then(
        (data)=>
          console.log 'Success'
          @back()
        , (err) ->
          console.log err
      )

    fire: () ->
      @service.del(@empl).then(
        (data)=>
          console.log 'Success'
          @back()
        , (err) ->
          console.log err
      )
    generate:() ->
      @empl = @util.genereteUserData()
      @add()

    back:()->
      window.history.back()


  angular.module('employee.detail', ['employee.employee-service', 'ui.router', 'ui.bootstrap.tooltip', 'ui.bootstrap.datepickerPopup'])
        .component 'ehaEmployeeDetail',
        templateUrl: './template/employee-detail.component.html'
        controller: ['$stateParams', '$state', 'UtilService','EmployeeService', EmployeeDetailCntl]
        bindings:
          'employee': '<',
          'weekends': '<'
  return
)(window.angular)