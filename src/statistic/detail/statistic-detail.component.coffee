((angular) ->
    StatisticDetailCntl = ['$scope', '$element', '$attrs',
    ($scope, $element, $attrs) ->
        console.log 'This is StatisticDetailCntl'
        return
    ]
    
    angular.module('statistic.detail', [])
        .component 'ehaStatisticDetail',
        templateUrl: './template/statistic-detail.component.html'
        controller: StatisticDetailCntl
    return
)(window.angular)