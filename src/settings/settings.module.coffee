((angular)->
  angular.module 'app.settings', [
    'settings.service',
    'settings.view'
  ]
  .config ['$stateProvider', '$urlServiceProvider',
    ($stateProvider, $urlServiceProvider) ->
      $stateProvider.state 'settings',
        url: '/settings'
        component: 'ehaSettings'
        resolve:
              'weekends': [
                  '$stateParams',
                  '$state',
                  'SettingsService',
                  ($stateParams, $state, SettingsService) ->
                    SettingsService
                    .getWeekends()
                    .then((data)-> data.data)
                ],
              'settings': [
                  '$stateParams',
                  '$state',
                  'SettingsService',
                  ($stateParams, $state, SettingsService) ->
                    SettingsService
                    .getSettings()
                    .then((data)-> data.data)
                ]
      return
    ]
  return
)(window.angular)