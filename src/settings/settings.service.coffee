((angular) ->
    angular.module('settings.service', [])
        .factory 'SettingsService', [() ->
            new class SettingsService
                constructor: ->
                    console.log 'This is SettingsService'
    ]
)(window.angular)
