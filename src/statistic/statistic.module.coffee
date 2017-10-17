((angular)->
  angular.module 'app.statistic', [
    'ui.router',
    # 'statistic.service',
    'missingdays.list',
    'statistic.main',
    'statistic.detail',
    'employee.employee-service'
  ]
  .config ['$stateProvider', '$urlRouterProvider',
    ($stateProvider, $urlRouterProvider) ->
      $urlRouterProvider.when('/statistic','/statistic')
      # $urlServiceProvider.rules.otherwise { state: 'statistic' }
      # Resolves.WeeekendsPR = [
      #           '$stateParams',
      #           '$state',
      #           'SettingsService',
      #           ($stateParams, $state, SettingsService) ->
      #             SettingsService
      #             .getWeekends(0,0)
      #             .then(((data)-> data.data))
      #         ]

      $stateProvider.state 'statistic',
        url: '/statistic'
        component: 'ehaStatisticMain'
        # reloadOnSearch : false
        
        params:
          userid: null
          fromDate: new Date(new Date().getFullYear(), 0, 1, 0, 0, 0),
          toDate: new Date()
        # views:
        #   '':
        #     component: 'ehaStatisticMain'
        #     resolve:
        #       'employeers': ['EmployeeService', (EmployeeService) ->
        #                         EmployeeService.getAll().then((data)-> data.data)],
        #       'weekends': ['SettingsService', (SettingsService) ->
        #                         SettingsService.getWeekends(0,0).then((data)-> data.data)]
        #   'graph@statistic':
        #     component: 'ehaStatisticDetail',
        #     resolve:
        #       'weekends': ['SettingsService', (SettingsService) ->
        #                       SettingsService.getWeekends(0, 0).then((data)-> data.data)]
        #       'missingsdaysarr': ['$stateParams', 'MissingDaysService', ($stateParams, MissingDaysService) ->
        #                             MissingDaysService.getAllByFilter($stateParams.userid,
        #                             $stateParams.fromDate, $stateParams.toDate).then(MissingDaysService.getDatesObject)]
        #   'missings@statistic':
        #     component: 'ehaMissingDaysList',
        #     resolve:
        #       'missingsdays': ['$stateParams', 'MissingDaysService', ($stateParams,  MissingDaysService) ->
        #                         MissingDaysService.getAllByFilter( $stateParams.userid, 
        #                         $stateParams.fromDate, $stateParams.toDate).then((data)-> data.data)]
        resolve:
          'employeers': ['EmployeeService', (EmployeeService) ->
                EmployeeService.getAll().then((data)-> data.data)],
          'weekends': ['$stateParams','$state', 'SettingsService',
          ($stateParams, $state, SettingsService) ->
            SettingsService.getWeekends(0, 0)
              .then((data)-> data.data)],
          'missingsdaysarr': ['$stateParams', '$state','MissingDaysService',
            ($stateParams, $state, MissingDaysService) ->
              MissingDaysService.getAllByFilter($stateParams.userid, $stateParams.fromDate, $stateParams.toDate)
              .then(MissingDaysService.getDatesObject, (err)-> err.data)],
          'missingsdays': ['$stateParams', '$state', 'MissingDaysService',
              ($stateParams, $state, MissingDaysService) ->
                MissingDaysService.getAllByFilter( $stateParams.userid, $stateParams.fromDate, $stateParams.toDate)
                .then((data)-> data.data)
          ]
   ]
  return
)(window.angular)
