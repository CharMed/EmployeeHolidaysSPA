((angular) ->
    angular.module('app.main', [    'ui.router',
                                    'anim-in-out',
                                    'main.view',
                                    'app.employee',
                                    'app.settings',
                                    'app.statistic',
                                    'app.missingdays'])
    .config ['$stateProvider', '$urlServiceProvider',
    ($stateProvider, $urlServiceProvider) ->
        $urlServiceProvider.rules.otherwise { state: 'statistic' }
        
        # $stateProvider.state 'employee',
        #     url: '/employee'
        #     component: 'ehaEmployeeList'
        # $stateProvider.state 'settings',
        #     url: '/settings'
        #     component: 'ehaSettings'

      
        return
    ]
    return
)(window.angular)