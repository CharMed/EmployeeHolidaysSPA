# TODO:FIX Рефакторинг
((angular) ->
  class SettingsCntl
    constructor: (UtilService, SettingsService) ->
      @service = SettingsService
      @util = UtilService
    $onInit: () ->
      # console.log @settings
      @dt = new Date()
      @options =
        'customClass': @getDayClass,
        'startingDay': 1
      setTimeout (->@dt = null), 1000
    
    getDayClass:(data)=>
      mode = data.mode
      date = data.date
      'is-weekends' if (mode is 'day') and (@util.isDateInList(date, @weekends))

    isWeekendsDate: (day)-> @util.isDateInList(day, @weekends)
    saveSettings: ()->
      console.log 'Save'
      @service.setSettings(@settings).then( (data)->
        console.log data
      , (errMsg) -> console.err errMsg)
    
    setWeekends: (date, deleted)->
      @service.setWeekend(date, deleted).then( (data)=>
        @weekends = data.data
      , (errMsg) -> console.err errMsg)

    initWeekends: ()->
      dateFrom = new Date(@dt.getFullYear(), 0, 1 , 0, 0, 0)
      dateTo = new Date(@dt.getFullYear(), 11, 31 , 0, 0, 0)
      @weekends = @service.initWeekends(dateFrom, dateTo)


  angular.module('settings.view', [
    'ui.bootstrap.tooltip'
    'ui.bootstrap.datepicker',
    'settings.service'
    'util.service'
    ])
    .component 'ehaSettings',
      templateUrl: "./template/settings.component.html"
      controller: ['UtilService', 'SettingsService', SettingsCntl]
      bindings:
        'weekends': '<',
        'settings': '<'
  return
)(window.angular)