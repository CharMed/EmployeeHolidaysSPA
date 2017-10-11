((angular) ->
    class SettingsCntl
        constructor: () ->
            console.log 'This is SettingsCntl'
   
    angular.module('settings.view', [])
    .component 'ehaSettings',
        templateUrl: './template/settings.component.html'
        controller: [SettingsCntl]
    return
)(window.angular)
