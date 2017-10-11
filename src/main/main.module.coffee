((angular) ->
    angular.module('app.main', [    'ui.router',
                                    'main.view',
                                    'app.employee',
                                    'app.settings',
                                    'app.statistic',
                                    'app.missingdays'])
    .config ['$stateProvider', '$urlServiceProvider',
    ($stateProvider, $urlServiceProvider) ->
        $urlServiceProvider.rules.otherwise { state: 'statistic' }
        
        $stateProvider.state 'employee',
            url: '/employee'
            component: 'ehaEmployeeList'
        $stateProvider.state 'settings',
            url: '/settings'
            component: 'ehaSettings'
        $stateProvider.state 'statistic',
            url: '/statistic'
            component: 'ehaStatisticMain'
        $stateProvider.state 'missingdays.edit',
            url: '/missingdays/:id'
            component: 'ehaMissingDaysEdit'
        return
    ]
    return
)(window.angular)