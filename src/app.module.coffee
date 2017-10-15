((angular) ->
    angular.module 'app', ['app.main', 'ui.router', 'ui.bootstrap', 'ngSanitize', 'ngAnimate']
    return
)(window.angular)