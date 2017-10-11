((angular) ->
    NavController = ['$scope', '$element', '$attrs', 
    ($scope, $element, $attrs) ->
        @name = 'Angular'
        return
    ]
    angular.module('navComponent', [
        'ui.bootstrap.dropdown',
        'ui.router',
        'shared.current-date'])
        .component 'ehaNav',
            templateUrl: './template/nav.component.html'
            controller: NavController
    return
)(window.angular)