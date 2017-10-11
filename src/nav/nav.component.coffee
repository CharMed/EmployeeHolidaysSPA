((angular) ->
    class NavController
        constructor: ()->
            @isVisibleNav = true
        onInit: () ->
            @isVisibleNav = true
            return
        toggleVisibilityLinks: () ->
            @isVisibleNav = not(@isVisibleNav)
            return
        
    angular.module('navComponent', [
        'ui.bootstrap.dropdown',
        'ui.bootstrap.collapse',
        'ui.router',
        'shared.current-date'])
        .component 'ehaNav',
            templateUrl: './template/nav.component.html'
            controller: [NavController]
    return
)(window.angular)