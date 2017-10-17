((angular) ->
  class StatisticMainCntl
    constructor: ($state, $stateParams, UtilService, MissingDaysService) ->
      @state = $state
      @stateParams = $stateParams
      @util = UtilService
      @miss = MissingDaysService
    $onInit:()->
      @options =
        'customClass': @getDayClass,
        'startingDay': 1
      @dateTo = new Date(@stateParams.toDate)
      @dateFrom = new Date(@stateParams.fromDate)
      @employee = @stateParams.userid
      # console.log @employeers
      @changeData( @employee, @dateFrom , @dateTo)
      return
    
    getEmployeeById:(id)->
      @employeers.find((elem)-> elem.id == id) if @employeers?

    getDayClass:(data)=>
      mode = data.mode
      date = data.date
      'is-weekends' if (mode is 'day') and (@util.isDateInList(date, @weekends))
    
    changeData:(userid, fromDate, toDate)->
      @missingsdays = []
      @missingsdaysarr = {}
      @miss.getAllByFilter(userid, fromDate, toDate)
      .then((data)=>
        @missingsdays = data.data
        @missingsdaysarr = @miss.getDatesObject(data)
        console.log  @missingsdaysarr )
      return

  angular.module('statistic.main', [
    'statistic.detail',
    'missingdays.list',
    'missingdays.service',
    'ui.router',
    'ui.bootstrap.typeahead',
    'ui.bootstrap.datepickerPopup',
    'ui.bootstrap.tooltip'
    'util.service'])
        .component 'ehaStatisticMain',
        templateUrl: './template/statistic-main.component.html'
        controller: ['$state', '$stateParams',
        'UtilService', 'MissingDaysService' , StatisticMainCntl]
        bindings:
          'employeers': '='
          'weekends':'='
  return
)(window.angular)