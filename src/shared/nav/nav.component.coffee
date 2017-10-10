((angular) ->
    NavController = ($scope, $element, $attrs) ->
        @name = 'Angular'
        return

    angular.module('navComponent', ['ui.bootstrap.dropdown']).component 'ehaNav',
        templateUrl: './template/nav.component.html'
        controller: NavController
    return
)(window.angular)