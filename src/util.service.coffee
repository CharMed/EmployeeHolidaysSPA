((angular) ->
  angular.module('util.service', [])
    .factory 'UtilService', ['$q', ($q) ->
      new class UtilService
        constructor: ( ) ->
          @debug = false
          @debounce = 1000
          @server =
            'settings': true
            'weekends': true
            'statistic': true
            'employee':true
            'missingdays':true
          @storagesnames =
            'settings': 'SettingsData'
            'weekends': 'WeekendsData'
            'employee': 'EmployeersData'
            'missingdays': 'MissingDaysData'
          @missingdaystypes =
            'missings' :  {'id': "0", 'name': 'Відсутність'}
            'working':    {'id': "1", 'name': 'Робота'}
            'hollydays':  {'id': "2", 'name': 'Відпустка'}
            'fired':      {'id': "3", 'name': 'Звільненння'}
        save: (property, value)->
          localStorage.setItem property, JSON.stringify value
        
        get: (property)->
          JSON.parse localStorage.getItem property
        
        normalizeMonthNumber: (month)->
          if (month < 10) then "0#{month}" else "#{month}"
        
        getNameForDay: (day)->
          date = new Date(day)
          "#{date.getFullYear()}-#{@normalizeMonthNumber date.getMonth()}"
        
        monthNameByNumber:(numb)->
          switch numb
            when 0 then 'Cічень'
            when 1 then 'Лютий'
            when 2 then 'Березень'
            when 3 then 'Квітень'
            when 4 then 'Травень'
            when 5 then 'Червень'
            when 6 then 'Липень'
            when 7 then 'Серпень'
            when 8 then 'Вересень'
            when 9 then 'Жовтень'
            when 10 then 'Листопад'
            when 11 then 'Грудень'
            else 'Не місяць'
        ###
          Check if date is weekends
        ###
        isDateInList: (dt = 0, list) ->
          date = @normalizeDate(dt)
          index = -1
          index = list.findIndex((el)-> +el is +date) if list?
          index isnt -1
          # date = new Date(dt)
          # yearmount = @getNameForDay(date)
          # if list?.hasOwnProperty(yearmount)
          #   index = list[yearmount].indexOf(date.getDate())
          #   index isnt -1
          # else
          #   false

        normalizeDate:(day)->
          date = new Date (day)
          newDate = new Date( date.getFullYear(),
                              date.getMonth(),
                              date.getDate(),
                              0,
                              0,
                              0)
        
        transformToPeriod:(fromDate, toDate) ->
          dateFrom = @normalizeDate(fromDate)
          dateTo = @normalizeDate(toDate)
          curr = dateFrom
          result = []
          while(+curr <= +dateTo)
            str = +curr
            result.push str
            curr.setDate(curr.getDate() + 1)
          return result
            # date = new Date(curr)
            # nmMount = if date.getMonth() < 10
            # then "0#{date.getMonth()}" else date.getMonth()
            # yearmounth = "#{date.getFullYear()}-#{nmMount}"
            # if res?.hasOwnProperty(yearmounth)
            #   index = res[yearmounth].indexOf(date.getDate())
            #   if index is -1
            #     res[yearmounth].push(date.getDate())
            # else
            #     res[yearmounth] = []
            #     res[yearmounth].push(date.getDate())
        getInPeriod: (fromDate, toDate, list)->
          dateFrom = @normalizeDate(fromDate)
          dateTo = @normalizeDate(toDate)
          list.filter (elem)-> elem >= dateFrom and elem <= dateTo
       
        ###
        rejectsData [{rejectFn: fn(), rejectIf : bool}]
        ###
        asyncData: (resolveData, rejectsData, debounce) ->
          deferred = $q.defer()
          setTimeout (->
            deferred.reject rj.rejectFn for rj in rejectsData when rj.rejectIf
            deferred.resolve resolveData
          ), debounce
          deferred.promise
        
        quuid:()->
          str = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, (c)->
            r = Math.random() * 16 | 0
            v = if c is 'x' then   r else (r & 0x3 | 0x8)
            v.toString(16)
          )
        
        nameMissingdaysTypes: (id)->
          keys = Object.keys(@missingdaystypes)
          return @missingdaystypes[key].name for key in keys when (@missingdaystypes[key].id is id)

        missingdaysTypesToArray: ()->
          keys = Object.keys(@missingdaystypes)
          @missingdaystypes[key] for key in keys
        
        randBetween:(min, max)->
          Math.floor(Math.random() * ((max-min)+1) + min)
        
        genereteUserData: ()->
          firstnames = ['Загороднюк', 'Пилипчук', 'Пончик', 'Козак', 'Мироненко', 'Піпененко', 'Аваконепалоперебрановальська', 'Андрієнко', 'Цурява', 'Панама']
          secondnames = ['Василина', 'Катерина', 'Григорій', 'Інокентій', 'Владислав', 'Ігор', 'Марина', 'Палагея', 'Дарт Вейдер', 'Руслан']
          lastnames = ['Іванівна', 'Катеринівна', 'Віталівна', 'Олександрівна', 'Пилонівна', 'Святославович', 'Кирилович', 'Дарт Молович', 'Білосніжович', 'Ебонітович']
          positions = ['Тестувальник', 'Програміст', 'Розробник', 'Архвтектор', 'Поїдач пончиків', 'Знищувач кави', 'Головний лентяй', '...', 'Ситемний адміністратор', 'Просто Вася']

          name = firstnames[ @randBetween(0, 9)] + ' ' + secondnames[ @randBetween(0, 9)] + ' ' + lastnames[ @randBetween(0, 9)]
          position = positions[ @randBetween(0, 9)]
          dateStart = new Date(@randBetween(+(new Date(2015, 0, 1)), +(new Date())))
          dateEndRand = new Date(@randBetween(+(new Date(2015, 0, 1)), +(new Date(2020, 0, 1))))
          dateEnd = dateEndRand if +dateEndRand < +(new Date())
          { name : name, position: position, dateStart: dateStart, dateEnd: dateEnd }

        genereteUserMissing: ( dateStart, dateEnd)->
          mxDays = @get(@storagesnames.settings)
          maxDays = Math.max(mxDays.maxYearHollydays, )
          missingdays = []
          dtStart = new Date(dateStart).getTime()
          dtEnd = if dateEnd? then dateEnd.getTime() else (new Date()).getTime()
          days =  mxDays.maxMonthHollydays
          if (mxDays.maxYearHollydays > 0 and mxDays.maxMonthHollydays > 0) 
              if (mxDays.maxYearHollydays > mxDays.maxMonthHollydays )
                charts = Math.ceil(mxDays.maxYearHollydays / mxDays.maxMonthHollydays)
              else 
                charts = 1
          else 
              charts = 1 
              days = mxDays.maxYearHollydays if mxDays.maxYearHollydays > 0
          mounts = Math.floor(12 / charts) ## 12 in years
          dateFrom = dtStart
          dateTo = dtStart + mounts * 30 * 24 * 3600 * 1000
          while( dateTo <= dtEnd)
              date = @randBetween(dateFrom, dateTo)
              missingdays.push({type: @missingdaystypes.hollydays.id, dateFrom: date, dateTo: date + days * 24 * 3600 * 1000 })
              if (@randBetween(0, 10) < 2)
                date = @randBetween(dateFrom, dateTo)
                missingdays.push({type: @missingdaystypes.missings.id, dateFrom: date, dateTo: date + 24 * 3600 * 1000})
              dateFrom = dateTo
              dateTo = +dateFrom + mounts * 30 * 24 * 3600 * 1000
          missingdays
        ]
  return
)(window.angular)
