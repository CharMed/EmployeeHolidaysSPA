###
    Сервіс для управління пропущеними періодами:
    відпустками,
    лікарняними,
    прогулами з поважної причини,
    прогулами без поважної причинами,
    переробітками.

    Модель: 
    userid - ідентифікатор користувача
    id - ідентифікатор пропущеного періоду
    type - тип пропуску
    dateStart - дата початку
    dateEnd- дата закінчення

    Функції:
    Додавання
    Видалення
    Редашування
    Отримання по ідентифікатору
    Отримання списку по фільтру:
    за період
    за типом
    за користувачем
###
((angular) ->
    angular.module('missingdays.service', [])
    .factory 'MissingDaysService', [ () ->
        new class MissingDaysService
            constructor: ->
                console.log 'This is MissingDaysService'
    ]
)(window.angular)