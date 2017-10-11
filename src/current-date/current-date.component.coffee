((angular) ->
    class CurrentDateCntl
        constructor: ($filter) ->
            console.log 'Constructor'
            @filter = $filter
        $onInit: () ->
            console.log 'onInit'
            @today = new Date()
            @format = 'dd.MM.yyyy'
            @formetedDate = @filter('date')(@today,  @format)
            console.log "onInit #{@formetedDate}"
            return
        
    # CurrentDateCntl = (['$filter', ($filter) => 
    #     ctrl = @
       
      
    #     @filterDate = (td = new Date(), fm = 'yyyy-MM-dd') => 
    #         $filter('date')(td, fm)

    #     $onInit = () =>
    #         @today = new Date()
    #         @formetedDate = $filter('date')(@today,  @format)
    #         return
    #     return

    # ])

    angular.module('shared.current-date', [])
    .component 'ehaCurrentDate',
        templateUrl: './template/current-date.component.html'
        controller: ['$filter', CurrentDateCntl]
    return

)(window.angular)