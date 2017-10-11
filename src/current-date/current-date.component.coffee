((angular) ->

    class CurrentDateCntl
        constructor: ($filter) ->
            @filter = $filter
        $onInit: () ->
            @today = new Date()
            @format = 'dd.MM.yyyy'
            @formetedDate = @filter('date')(@today,  @format)
            return

    angular.module('shared.current-date', [])
    .component 'ehaCurrentDate',
        templateUrl: './template/current-date.component.html'
        controller: ['$filter', CurrentDateCntl]
    return

)(window.angular)