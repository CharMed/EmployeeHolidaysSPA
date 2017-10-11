((angular) ->
    SettingsCntl = ['$scope', '$element', '$attrs', 
    ($scope, $element, $attrs) ->
        console.log This is SettingsCntl
        return
    ]

    angular.module('settings.view', [])
    .component 'ehaSettings',
        templateUrl: './template/settings.component.html'
        controller: SettingsCntl
    return
)(window.angular)
