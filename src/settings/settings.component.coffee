# TODO:FIX Рефакторинг
((angular) ->
  class SettingsCntl
    constructor: (SettingsService) ->
      @settings = SettingsService
      console.log "SettingsCntl constructor"
      @weekends = new Object()
    $onInit: () ->
      @settings.getSettings().then ((data) ->
        @maxYearHollydays = +data.data.maxYearHollydaysCount
        @maxMounthHollydays = +data.data.maxMounthHollydaysCount
        return
      ).bind(@), ((errMsg) ->
        @errtext = "Error status: #{errMsg.status}."
        @errvissibility = true
        return
      ).bind(@)
      @settings.getWeekends().then ((data) ->
        @weekends = data.data
        @dt = new Date()
        # console.log  @weekends
        return
      ).bind(@), ((errMsg) ->
        @errtext = "Error status: #{errMsg.status}."
        @errvissibility = true
        return
      ).bind(@)
      @options =
          customClass: @getDayClass.bind(@)
      @dt = null
      console.log "SettingsCntl onInit"
      return

    getDayClass: (data) ->
      # console.log data
      date = data.date
      mode = data.mode
      yearmount = "#{date.getFullYear()}-#{date.getMonth()}"
      if ((mode is 'day') and @isWeekendsDate(date)) then 'is-weekends' else ''
      # if ((mode is 'day') and (date.getDay() is 0 or date.getDay() is 6))
      #   'is-weekends'
      # else
      #   ''
    isWeekendsDate: (dt) ->
      date = new Date(dt)
      yearmount = "#{date.getFullYear()}-#{date.getMonth()}"
      if @weekends?.hasOwnProperty(yearmount)
        index = @weekends[yearmount].indexOf(date.getDate())
        if index isnt -1 then true else false
      else
        false
    
    submit: () ->
      console.log "submit settings"
      @settings.setSettings(
        'maxYearHollydaysCount': @maxYearHollydays
        'maxMounthHollydaysCount': @maxMounthHollydays
      ).then (()->
        console.log "Save settings"
      ).bind(@), ((errMsg) ->
        @errtext = "Error status: #{errMsg.status}."
        @errvissibility = true
        return
      ).bind(@)
      return
    
    initWeekends: ->
      date = new Date (@dt)
      console.log date
      @settings.initWeekends(date.getFullYear())

    setWeekends:(date, deleted) ->
      @settings.setWeekends(date, deleted).then ((data)->
        @weekends = data.data
        console.log "Set/Unset weekends"
        console.log @weekends
      ).bind(@), ((errMsg) ->
        @errtext = "Error status: #{errMsg.status}."
        @errvissibility = true
        return
      ).bind(@)
      return


  angular.module('settings.view', [
    'ui.bootstrap.datepicker',
    'settings.service'
    ])
    .component 'ehaSettings',
      templateUrl: "./template/settings.component.html"
      controller: ['SettingsService', SettingsCntl]
    .config(['uibDatepickerConfig', ($uibDatepickerConfig)->
      $uibDatepickerConfig.startingDay = 1
    ])
  return
)(window.angular)