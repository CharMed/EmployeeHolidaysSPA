# TODO:FIX Рефакторинг
((angular) ->
  angular.module('settings.service', ['util.service'])
    .factory 'SettingsService', ['UtilService', (UtilService)->
      new class SettingsService
        constructor: () ->
          @util = UtilService
          @list = @getSettingsNow()
          @weeks = @getWeekendsNow()
        saveSettingsToStorage: () ->
          @util.save @util.storagesnames.settings, @list
        getSettingsNow:()->
          @list = (@util.get @util.storagesnames.settings) || {}
        getSettings: () ->
          @list = @getSettingsNow()
          resolveData = ()=>
            if @util.server.settings
              {'data': @list, 'status': 200}
          rejectsData = [{
            rejectFn: {status: 500, text: 'Server error'}
            rejectIf: !@util.server.settings
          }]
          @util.asyncData(resolveData(), rejectsData, @util.debounce)
        setSettings: (data)->
          resolveData = ()=>
            if @util.server.settings
              @list = data
              @saveSettingsToStorage()
              {'data': @list, 'status': 200}
          rejectsData = [{
            rejectFn: {status: 500, text: 'Server error'}
            rejectIf: !@util.server.settings
          }]
          @util.asyncData(resolveData(), rejectsData, @util.debounce)
        saveWeekendsToStorage: () ->
          @util.save @util.storagesnames.weekends, @weeks
        getWeekendsNow:()->
          @weeks = (@util.get @util.storagesnames.weekends) || []
        getWeekends: (dateFrom, dateTo) ->
          @weeks = @getWeekendsNow()
          resolveFn = () =>
            if @util.server.weekends
              result = []
              if dateFrom? and dateTo? and dateFrom > 0 and dateTo > 0
                result = @util.getInPeriod(dateFrom, dateTo, data)
              else
                result = angular.copy(@weeks)
              {'data': result, 'status': 200}
          rejectsData = [
            {
              rejectFn: {status: 500, text: 'Server error'}
              rejectIf: !@util.server.weekends
            }
          ]
          @util.asyncData(resolveFn(), rejectsData, @util.debounce)
        setWeekend: (day, isDelete = false) ->
          resolveData = ()=>
            if @util.server.weekends
              date = @util.normalizeDate(day)
              index = @weeks.findIndex((elem)-> +elem is +date)
              if isDelete and index isnt -1
                @weeks.splice(index, 1)
              else if not(isDelete) and index is -1
                @weeks.push(+date)
              @saveWeekendsToStorage()
              {'data': @weeks, 'status': 200}
          rejectsData = [{
            rejectFn: {status: 500, text: 'Server error'}
            rejectIf: !@util.server.settings
          }]
          @util.asyncData(resolveData(), rejectsData, @util.debounce)
        # TODO:ADD Додати державні вихідні, а не тільки суботу і неділю 
        initWeekends: (fromDate, toDate) ->
          dateFrom = @util.normalizeDate(fromDate)
          dateTo = @util.normalizeDate(toDate)
          curr = dateFrom
          while(+curr <= +dateTo)
            # console.info curr.getDay()
            if curr.getDay() is 6 or curr.getDay() is 0
              @weeks.push(+curr)
            curr.setDate(curr.getDate() + 1)
          @saveWeekendsToStorage()
          # console.info @weeks
          return @weeks
    ]
)(window.angular)
