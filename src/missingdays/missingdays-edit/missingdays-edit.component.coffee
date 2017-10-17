((angular) ->
  class MissingDaysEditCntl
    constructor: ($stateParams, $state, UtilService, MissingDaysService) ->
      @service = MissingDaysService
      @stateParams = $stateParams
      @state = $state
      @util = UtilService
    $onInit: ()->
      console.log (@missingsday)
      @options =
        'customClass': @getDayClass,
        'startingDay': 1

      @typeslist = @util.missingdaysTypesToArray()
      @userid = @stateParams.userid
      @mode = if (@stateParams.id is 'new') then 'add' else 'edit'
      @ms = angular.copy(@missingsday)
      @ms.userId = @userid
      @ms.from = new Date(@missingsday.from)
      @ms.to = new Date(@missingsday.to)
      return
    
    getDayClass:(data)=>
      mode = data.mode
      date = data.date
      'is-weekends' if (mode is 'day') and (@util.isDateInList(date, @weekends))

    back:()->
      window.history.back()

    add: () ->
      @service.add(@ms).then((data)=>
        @back()
      , (err) ->
        console.error err
      )
    edit: () ->
      @serv.edit(@ms).then((data)=>
        @back()
      , (err) ->
        console.error err
      )
    delete: () ->
      @serv.del(@ms).then((data)=>
        @back()
      , (err) ->
        console.error err
      )
    
    genererate: ()->
      console.info @employee
      missings = @util.genereteUserMissing(@employee.dateStart, @employee.dateEnd)
      for miss in missings
        miss.userId = @userid
        miss.from = new Date(miss.dateFrom)
        miss.to = new Date(miss.dateTo)
        @service.add(miss).then((data)->
          console.log data
        , (err) ->
          console.error err
        )
      @back()
      
  angular.module('missingdays.edit',[
    'missingdays.service',
    'ui.router',
    'ui.bootstrap.datepickerPopup',
    'ui.bootstrap.tooltip'
    'util.service'])
      .component 'ehaMissingDaysEdit',
        templateUrl: './template/missingdays-edit.component.html'
        controller: ['$stateParams',
            '$state',
            'UtilService',
            'MissingDaysService',
             MissingDaysEditCntl]
        bindings:
          'missingsday': '<',
          'weekends': '<',
          'employee':'<'
  return
)(window.angular)
