((angular) ->
    MainCntl = ['$scope', '$element', '$attrs', ($scope, $element, $attrs) ->
        @name = 'Angular'
        return
    ]

    angular.module('main.view', ['navComponent'])
    .component 'ehaMain',
        templateUrl: './template/main.component.html'
        controller: MainCntl
    return
)(window.angular)

