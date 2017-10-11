((angular)->
    angular.module 'app.employee', [
        'ui.router',
        'employee.employee-model',
        'employee.employee-service',
        # 'employee.missingdays-model',
        # 'employee.missingdays-service',
        'employee.blockview',
        'employee.detail',
        'employee.list'
        # 'employee.missingdays-edit',
        # 'employee.missingdays-block'
    ]
    .config ['$stateProvider', '$urlServiceProvider',
    ($stateProvider, $urlServiceProvider) ->
        # $urlServiceProvider.rules.otherwise { state: 'employee.detail' }
        
        # $stateProvider.state 'employee',
        #     url: '/employee'
        #     component: 'ehaEmployeeList'
            
        $stateProvider.state 'employee.detail',
            url: '/:id'
            component: 'ehaEmployeeDetail'
        
        # $stateProvider.state 'employee.missingdays-edit',
        #     url: '/missingdays/:id'
        #     component: 'ehaMissingDaysEdit'
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