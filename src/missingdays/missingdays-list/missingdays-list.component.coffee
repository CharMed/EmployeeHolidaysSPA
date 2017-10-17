((angular) ->
  class MissingDaysListCntl
    constructor: ($stateParams, MissingDaysService) ->
      @stateParams = $stateParams
      @service = MissingDaysService
    $onInit:()->
      @fromdate = @stateParams.fromDate
      @todate = @stateParams.toDate
      @userid = @stateParams.userid

  angular.module('missingdays.list', [
    'ui.router',
    'missingdays.block'
    ])
    .component 'ehaMissingDaysList',
        templateUrl: './template/missingdays-list.component.html'
        controller: [
          '$stateParams', 'MissingDaysService'
           MissingDaysListCntl]
        bindings:
          'missingsdays': '<'
  return
)(window.angular)
