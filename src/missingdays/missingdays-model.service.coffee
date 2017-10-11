((angular) ->
    angular.module('missingdays.model', [])
    .factory 'MissingDaysModelService', [ () ->
        new class MissingDaysModelService
            constructor: ->
                console.log 'This is MissingDaysModelService'
    ]
)(window.angular)
