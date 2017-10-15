# TODO:FIX Рефакторинг
((angular) ->
  angular.module('settings.service', [])
    .factory 'SettingsService', ['$q',($q) ->
      new class SettingsService
        constructor: ->
          @debounce = 1000
          @settingsServer = true
          console.log 'This is SettingsService'
        # TODO:ADD Додати державні вихідні, а не тільки суботу і неділю 
        initWeekends: (year) ->
          startDay = new Date "#{year}/01/01"
          endDay = new Date (year+'/12/31')
          console.log  "st = #{startDay} end #{endDay}"
          curr = new Date(startDay)
          while(+curr <= +endDay)
            console.log curr
            if curr.getDay() is 6 or curr.getDay() is 0
              console.log "IS Sun or Sam"
              @setWeekendsNow(curr, false)
            curr.setDate(curr.getDate() + 1)
          return
        getSettings: ->
          deferred = $q.defer()
          setTimeout (->
            if @settingsServer
              data =
                'maxYearHollydaysCount': localStorage.getItem 'maxYearHollydaysCount'
                'maxMounthHollydaysCount': localStorage.getItem 'maxMounthHollydaysCount'
              deferred.resolve {'data': data, 'status': 200}
            else
              deferred.reject {'status': 500}
          ).bind(@), @debounce
          deferred.promise
        setSettings: (data) ->
          deferred = $q.defer()
          setTimeout (->
            if @settingsServer
              console.log "True"
              localStorage.setItem "maxYearHollydaysCount", data.maxYearHollydaysCount
              localStorage.setItem "maxMounthHollydaysCount", data.maxMounthHollydaysCount
              deferred.resolve { status: 200}
            else
              console.log "False"
              deferred.reject {status: 500}
          ).bind(@), @debounce
          deferred.promise
        getWeekends: () ->
          deferred = $q.defer()
          setTimeout (->
            if @settingsServer
              data = JSON.parse localStorage.getItem "weekends"
              deferred.resolve { data: data, status: 200}
            else
              deferred.reject {status: 500}
          ).bind(@), @debounce
          deferred.promise
        setWeekends: (day, deleted = false)->
          deferred = $q.defer()
          setTimeout ( ->
            if @settingsServer
              weekends = @setWeekendsNow(day, deleted)
              deferred.resolve {status: 200, data: weekends}
            else
              deferred.reject {status: 500}
          ).bind(@), @debounce
          deferred.promise

        setWeekendsNow : (day, deleted = false) ->
          weekends = (JSON.parse localStorage.getItem "weekends") || {}
          date = new Date(day)
          yearmounth = "#{date.getFullYear()}-#{date.getMonth()}"
          if weekends?.hasOwnProperty(yearmounth)
            index = weekends[yearmounth].indexOf(date.getDate())
            if index isnt -1 and deleted
              weekends[yearmounth].splice(index, 1)
            else if index is -1 and not deleted
              weekends[yearmounth].push(date.getDate())
          else
              weekends[yearmounth] = []
              weekends[yearmounth].push(date.getDate()) if not deleted
            localStorage.setItem "weekends", JSON.stringify weekends
          return weekends
    ]
)(window.angular)
