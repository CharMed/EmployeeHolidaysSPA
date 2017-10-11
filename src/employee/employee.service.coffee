###
    Сервіс для управління користувачами.
    Модель користувача:
    id - ідентифікатор
    name - ПІБ
    position - посада
    status - статус
    activity - активний
    dateStart - дата найму
    dateEnd - дата звільнення
    1. Додавання нового
    2. Звільнення (Переведення статусу активний у false)
    3. Відновлення (дата найму змінюється на поточну)
    3. Редагування (посада, ПІБ)
    4. Список усіх доступних користувачів (з фільтром): активний, ПІБ
    5. Користувач по ідентифікатору
###

((angular) ->
    angular.module('employee.employee-service', [])
        .factory 'EmployeeService', [() ->
            new class EmployeeService
                constructor: ->
                    console.log 'This is EmployeeService'
    ]
)(window.angular)