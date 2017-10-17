((angular)->
  angular.module 'app.employee', [
    'ui.router',
    'employee.employee-model',
    'employee.employee-service',
    'employee.blockview',
    'employee.detail',
    'employee.list'
  ]
  .config ['$stateProvider', ($stateProvider) ->
      $stateProvider.state 'employee',
        url: '/employee'
        component: 'ehaEmployeeList'
        resolve:
          'employeers': ['EmployeeService', (EmployeeService) ->
             EmployeeService.getAll().then((data)-> data.data)]
      
      $stateProvider.state 'employeedetail',
        url: '/employee/:id'
        component: 'ehaEmployeeDetail'
        resolve:
          'employee': ['$stateParams',
            '$state',
            'EmployeeService',
            'EmployeeModelService',
            ($stateParams, $state, EmployeeService,  EmployeeModelService) ->
              if $stateParams.id is 'new'
                new EmployeeModelService()
              else EmployeeService.getById($stateParams.id).then((data)->
                  console.log data
                  data.data
              , (err)->
                  err.data
              )
          ]
        # ($stateParams, $state, $uibModal) ->
        # onEnter: ['$stateParams', '$state', '$uibModal',
        # ($stateParams, $state, $uibModal) ->
        #   $uibModal.open(
        #     component: 'ehaEmployeeDetail'
        #     # resolve:
        #     #   'employeer': ($stateParams,
        # $state, EmployeeService,  EmployeeModelService) ->
        #     #     if $stateParams.id is 'new'
        #     #       new EmployeeModelService()
        #     #     else EmployeeService.getById($stateParams.id)
        #     #       .then((data)->
        #     #         console.log data
        #     #         data.data
        #     #       , (err)-> err.data)
        #   )
        #     #  // change route after modal result
        #   .result.then(() ->
        #       $state.go('employee')
        #   ,() ->
        #       $state.go('employee')
        #   )
        #
      return
    ]
  return
)(window.angular)

###
  $stateProvider.state('userlist.detail', {
    url: '/:userId',
    component: 'userDetail',
    resolve: {
      user: function($transition$, users) {
        let userId = $transition$.params().userId;
        return users.find(user => user.id == userId);
      }
    }
  });
###