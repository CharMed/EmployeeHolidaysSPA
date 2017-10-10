((angular) ->
    MainController = ($scope, $element, $attrs) ->
        @name = 'Angular'
        return

    angular.module('mainComponent', ['navComponent']).component 'ehaMain',
        templateUrl: './template/app.component.html'
        controller: MainController
    return
)(window.angular)

