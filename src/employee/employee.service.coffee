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
  angular.module('employee.employee-service', ['employee.employee-model', 'util.service'])
  .factory 'EmployeeService', ['UtilService', 'EmployeeModelService',(UtilService, EmployeeModelService)->
    new class EmployeeService
      constructor:()->
          @util = UtilService
          @list = @getAllNow()
      saveToStorage: ()->
          @util.save @util.storagesnames.employee, @list
      getAllNow:()->
          @list = (@util.get @util.storagesnames.employee) || []
      getByIdNow:(id)->
          @list.find (elem)-> elem.id is id
      getByIdIndexNow:(id)->
          @list.findIndex (elem)-> elem.id is id

      getAll:()->
          resolveData = ()=>
            if @util.server.employee
              {'data': @list, 'status': 200}
          rejectsData = [
            {
              rejectFn: {status: 500, text: 'Server error'}
              rejectIf: !@util.server.employee
            }
          ]
          @util.asyncData(resolveData(), rejectsData, @util.debounce)
        
      getAllByFilter: (username, status)->
          resolveData = () =>
            if @util.server.employee
              result = @list.filter((elem)->
                isName = isStatus = true
                elemname = elem.name.toUpperCase()
                usname = username.toUpperCase() if username?
                isName = (elemname.indexOf(usname) isnt -1) if username?
                isStatus = (elem.status is status) if status?
                (isName) and (isStatus)
              )
              {'data': result, 'status': 200}
          
          rejectsData = [{
              rejectFn: {status: 500, text: 'Server error'}
              rejectIf: !@util.server.employee
            }]
          @util.asyncData(resolveData(), rejectsData, @util.debounce)
      getById: (id)->
          resolveData = ()=>
            if @util.server.employee
              {'data':  @getByIdNow(id), 'status': 200}
          rejectsData = [
            {
              rejectFn: {status: 500, text: 'Server error'}
              rejectIf: !@util.server.employee
            }
          ]
          @util.asyncData(resolveData(), rejectsData, @util.debounce)
      add: (data) ->
          @list = @getAllNow()
          resolveFn = () =>
            if @util.server.employee
              employee = new EmployeeModelService(data.name, data.dateStart)
              employee.position = data.position
              @list.push employee
              @saveToStorage()
              {status: 200, data: employee}
          rejectsData = [
            {
              rejectFn: {status: 500, text: 'Server error'}
              rejectIf: !@util.server.employee
            }
          ]
          @util.asyncData(resolveFn(), rejectsData, @util.debounce)
      edit: (data) ->
          @list =  @getAllNow()
          resolveData = ()=>
            if @util.server.employee
              index = @getByIdIndexNow(data.id)
              @list[index].position = data.position
              @list[index].name = data.name
              @saveToStorage()
              {'data':  @list[index], 'status': 200}
          rejectsData = [
            {
              rejectFn: {status: 500, text: 'Server error'}
              rejectIf: !@util.server.employee
            }
          ]
          @util.asyncData(resolveData(), rejectsData, @util.debounce)
      del: (data) ->
          @list = @getAllNow()
          resolveData = ()=>
            if @util.server.employee
              index = @getByIdIndexNow(data.id)
              @list[index].dateEnd = @util.normalizeDate(data.dateEnd)
              @list[index].activity = false
              @saveToStorage()
              {'data':   @list[index], 'status': 200}
          rejectsData = [
            {
              rejectFn: {status: 500, text: 'Server error'}
              rejectIf: !@util.server.employee
            }
          ]
          @util.asyncData(resolveData(), rejectsData, @util.debounce)
       
      resume: (data)=>
          @list = @getAllNow()
          resolveData = ()=>
            if @util.server.employee
              index = @getByIdIndexNow(data.id)
              @list[index].dateStart = UtilService.normalizeDate(data.dateStart)
              @list[index].dateEnd = null
              @list[index].activity = true
              @saveToStorage()
              {'data':   @list[index], 'status': 200}
          rejectsData = [{
              rejectFn: {status: 500, text: 'Server error'}
              rejectIf: !@util.server.employee
            }]
          @util.asyncData(resolveData(), rejectsData, @util.debounce)
    ]
)(window.angular)