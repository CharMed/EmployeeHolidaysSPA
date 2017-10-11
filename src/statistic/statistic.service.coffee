###
    Сервіс для отримання статистики:
    1. отримання даних для графіка для кожного місяця:
        workingdays - робочих днів,
        hollydays - відпукних,
        truancy - прогулів,
        other- інших,
        weekends - вихідних
    [{ workingdays, hollydays, missingdays, other, weekends}, {} ... {} ]
    2. Отримання вихідних за  рік/місяць
    3. Отримання відпускних за рік/місяць
    4. отримання прогулів за рік/місяць

###
((angular) ->
    angular.module('statistic.service', [])
        .factory 'StatisticService', [() ->
            new class StatisticService
                constructor: ->
                    console.log 'This is StatisticService'
    ]
)(window.angular)
