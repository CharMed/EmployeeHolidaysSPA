((angular)->
  angular.module 'app.missingdays', [
    'missingdays.model',
    'settings.service',
    'missingdays.service',
    'missingdays.edit',
    'missingdays.block',
    'employee.employee-service'
  ]
  .config ['$stateProvider', ($stateProvider) ->
    $stateProvider.state 'missingdaysedit',
      url: '/employee/:userid/:id'
      component: 'ehaMissingDaysEdit'
      resolve:
        'missingsday': [
          '$stateParams',
          '$state',
          'MissingDaysService',
          'MissingDaysModelService',
          ($stateParams, $state, MissingDaysService, MissingDaysModelService) ->
            # console.log $stateParams.userid
            if $stateParams.id is 'new'
              new MissingDaysModelService()
            else MissingDaysService.getById($stateParams.id).then((data)->
                # console.log data
                data.data
            , (err)->
                err.data
            )
          ]
        'weekends': [
                '$stateParams',
                '$state',
                'SettingsService',
                ($stateParams, $state, SettingsService) ->
                  SettingsService
                  .getWeekends(0,0)
                  .then(((data)-> data.data))
              ],
        'employee': ['$stateParams', '$state','EmployeeService',
            ($stateParams, $state, EmployeeService) ->
              EmployeeService.getById($stateParams.userid).then((data)->
                  data.data
              , (err)->
                  err.data
              )
          ]
    return
  ]
  return
)(window.angular)
