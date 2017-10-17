((angular) ->
  class StatisticDetailCntl
    constructor: ($stateParams, UtilService) ->
      @stateParams = $stateParams
      @util = UtilService
      @labels = []
      @series = []
      @data = []
      # console.log 'This is StatisticDetailCntl'
    $onInit:()->
      @fromDate = new Date(@stateParams.fromDate)
      @toDate = new Date(@stateParams.toDate)
      @userid = @stateParams.userid
    
    $onChanges: (changes) ->
      @formData()
    
    _areElementsResolved: (changes) ->
      changes.elements && Array.isArray(changes.elements.currentValue)

      # console.log @userid
      # console.info @fromDate
      # console.info @toDate
      # console.info @userid

      # @labels = ['2006', '2007', '2008', '2009', '2010', '2011', '2012']
      # @series = ['A', 'B', 'C', 'D']
      # @data = [
      #   [65, 59, 80, 81, 56, 55, 40],
      #   [28, 48, 40, 19, 86, 27, 90],
      #   [65, 59, 80, 81, 56, 55, 40],
      #   [28, 48, 40, 19, 86, 27, 90]
      # ]
      

    formData:()->
      @labels = []
      @data = []
      @series = ['Робочі', 'Відпустка', 'Вихідні', 'Інші']
      curr = @util.normalizeDate(@fromDate)
      counterHollydays = 0
      counterOthers = 0
      counterWeekends = 0
      counterWorking = 0
      prevMonth = curr.getMonth()
      arrayWorking =[]
      arrayHollydays =[]
      arrayWeekends =[]
      arrayOthers =[]
      today = @util.normalizeDate(new Date())

      while (curr <= @toDate )
        currMonth = curr.getMonth()
        if @isDateInHollydays(curr)
          counterHollydays++
        else if @isDateInOthers(curr).lenght > 0
          counterOthers++
        else if @isDateInWeekends(curr)
          counterWeekends++
        else
          counterWorking++
        
        if prevMonth isnt currMonth
          @labels.push( @util.monthNameByNumber prevMonth)
          arrayWorking.push(counterWorking)
          arrayHollydays.push(counterHollydays)
          arrayWeekends.push(counterWeekends)
          arrayOthers.push(counterOthers)
          prevMonth = currMonth
          counterHollydays = 0
          counterOthers = 0
          counterWeekends = 0
          counterWorking = 0
        # console.log(curr)
        curr.setDate(curr.getDate() + 1)
      @labels.push( @util.monthNameByNumber currMonth)
      arrayWorking.push(counterWorking)
      arrayHollydays.push(counterHollydays)
      arrayWeekends.push(counterWeekends)
      arrayOthers.push(counterOthers)
      @data.push arrayWorking
      @data.push arrayHollydays
      @data.push arrayWeekends
      @data.push arrayOthers
      # console.log @data
      # console.log @series
      # console.log @labels
      return
    
    isDateInHollydays: (day)->
      if @missingsdaysarr?[@util.missingdaystypes.hollydays.name]?
        @util.isDateInList(day, @missingsdaysarr[@util.missingdaystypes.hollydays.name])
      else
        false
    
    isDateInOthers: (day)->
      for own key, value of @missingsdaysarr
        if key isnt @util.missingdaystypes.hollydays.name
          @util.isDateInList(day, @missingsdaysarr[key])
  
    isDateInWeekends: (day)->
      if @weekends?
        @util.isDateInList(day, @weekends)
      else
        false
    


  angular.module('statistic.detail', [
    'missingdays.list',
    'chart.js',
    'ui.router',
    'util.service'])
        .component 'ehaStatisticDetail',
        templateUrl: './template/statistic-detail.component.html'
        controller: ['$stateParams', 'UtilService', StatisticDetailCntl],
        bindings:
          'weekends': '<'
          'missingsdaysarr': '<'
  return
)(window.angular)