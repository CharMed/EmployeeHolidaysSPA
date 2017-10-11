((angular)->
    angular.module 'app.settings', [
        'settings.service',
        'settings.view'
    ]
    return
)(window.angular)