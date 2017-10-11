((angular)->
    angular.module 'app.missingdays', [
        'missingdays.model',
        'missingdays.service',
        'missingdays.edit',
        'missingdays.block'
    ]
    return
)(window.angular)


###