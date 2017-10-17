((angular) ->
  angular.module('missingdays.model', ['util.service'])
    .factory 'MissingDaysModelService', [ 'UtilService', (UtilService)->
      class MissingDaysModelService
        constructor: (userid = 0,
         type,
         fromDate = new Date(),
         toDate = new Date()) ->
          # console.log 'This is MissingDaysModelService'
          # @util = UtilService
          @id = UtilService.quuid()
          @userId = userid
          @type =  type || UtilService.missingdaystypes.working.id
          @from = UtilService.normalizeDate(fromDate)
          @to  = UtilService.normalizeDate(toDate)
          @transformPeriod = UtilService.transformToPeriod(@from, @to)
        # transform: (fromDate, toDate) ->
        #   res = {}
        #   curr =  fromDate
        #   while(curr <= toDate)
        #     date = new Date(curr)
        #     nmMount = if date.getMonth() < 10 then "0
        #{date.getMonth()}" else date.getMonth()
        #     yearmounth = "#{date.getFullYear()}-#{nmMount}"
        #     if res?.hasOwnProperty(yearmounth)
        #       index = res[yearmounth].indexOf(date.getDate())
        #       if index is -1
        #         res[yearmounth].push(date.getDate())
        #     else
        #         res[yearmounth] = []
        #         res[yearmounth].push(date.getDate())
        #     curr.setDate(curr.getDate() + 1)
        #   return res
        Object.defineProperty(@, 'to',
          set: (val) ->
            @to = val
            @transformPeriod = UtilService.transformToPeriod(@from, val)
            return
        )
        Object.defineProperty(@, 'from',
          set: (val) ->
            @from = val
            @transformPeriod = UtilService.transformToPeriod(val, @to)
            return
        )
    ]
)(window.angular)
