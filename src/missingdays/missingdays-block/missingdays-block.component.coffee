((angular) ->
    MissingDaysBlockCntl = ($scope, $element, $attrs) ->
        console.log 'This is MissingDaysBlockCntl'
        return

    angular.module('missingdays.block', [])
        .component 'ehaMissingDaysBlock',
        templateUrl: './template/missingdays-block.component.html'
        controller: MissingDaysBlockCntl
    return
)(window.angular)
