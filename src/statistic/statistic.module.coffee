((angular)->
    angular.module 'app.statistic', [
        'ui.router',
        'statistic.service',
        'statistic.main',
        'statistic.detail'
    ]
    .config ['$stateProvider', '$urlServiceProvider',
    ($stateProvider, $urlServiceProvider) ->
        # $urlServiceProvider.rules.otherwise { state: 'employee.detail' }
        
        # $stateProvider.state 'employee',
        #     url: '/employee'
        #     component: 'ehaEmployeeList'
            
        $stateProvider.state 'statistic.detail',
            url: '/:id'
            component: 'ehaStatisticDetail'
    ]
    return
)(window.angular)
