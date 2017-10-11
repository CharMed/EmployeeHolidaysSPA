((angular) ->
    StatisticMainCntl = ['$scope', '$element', '$attrs',
    ($scope, $element, $attrs) ->
        console.log 'This is StatisticMainCntl'
        return
    ]
    
    angular.module('statistic.main', [])
        .component 'ehaStatisticMain',
        templateUrl: './template/statistic-main.component.html'
        controller: StatisticMainCntl
    return
)(window.angular)