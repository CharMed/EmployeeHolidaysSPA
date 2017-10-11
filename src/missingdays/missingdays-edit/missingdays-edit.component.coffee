((angular) ->
    MissingDaysEditCntl = ($scope, $element, $attrs) ->
        console.log 'This is MissingDaysEditCntl'
        return

    angular.module('missingdays.edit', [])
        .component 'ehaMissingDaysEdit',
        templateUrl: './template/missingdays-edit.component.html'
        controller: MissingDaysEditCntl
    return
)(window.angular)
