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
  angular.module('missingdays.service', ['missingdays.model','util.service'])
    .factory 'MissingDaysService', ['UtilService', 'MissingDaysModelService', (UtilService, MissingDaysModelService) ->
      new class MissingDaysService
        constructor: ()->
          @util = UtilService
          @list = @getAllNow()
        saveToStorage: () ->
          @util.save @util.storagesnames.missingdays, @list
        getAllNow:()->
          @list = (@util.get @util.storagesnames.missingdays) || []
        getByIdNow:(id) ->
          @list.find (elem) -> elem.id is id
        getByIdIndexNow:(id) ->
          @list.findIndex (elem) -> elem.id is id

        getAll: () ->
          @list = @getAllNow()
          resolveData = ()=>
            if @util.server.missingdays
              {'data': @list, 'status': 200}
          rejectsData = [{
            rejectFn: {status: 500, text: 'Server error'}
            rejectIf: !@util.server.missingdays
          }]
          @util.asyncData(resolveData(), rejectsData, @util.debounce)
            
        getAllByFilter: (userid, dateFrom, dateTo)->
          @list = @getAllNow()
          resolveData = () =>
            if @util.server.missingdays
              result = @list.filter((elem)->
                isUser = isInPeriod = true
                isUser = (elem.userId is userid) if userid? and userid isnt 0
                isElemFromInPeriod = (new Date(elem.from) >= new Date(dateFrom) and new Date(elem.from) < new Date(dateTo))
                isElemToInPeriod = (new Date(elem.to) > new Date(dateFrom) and new Date(elem.to) < new Date(dateTo))
                isInPeriod =(isElemFromInPeriod or isElemToInPeriod) if dateFrom? and dateTo?
                # console.log  isInPeriod
                isUser and isInPeriod
              )
              # console.log userid,
              # console.log dateFrom
              # console.log dateTo
              # console.log result
              # console.log @list
              {'data': result, 'status': 200}
          rejectsData = [{
            rejectFn: {status: 500, text: 'Server error'}
            rejectIf: !@util.server.missingdays
          }]
          @util.asyncData(resolveData(), rejectsData, @util.debounce)
        getById: (id)->
          @list = @getAllNow()
          resolveData = ()=>
            if @util.server.missingdays
              {'data':  @getByIdNow(id), 'status': 200}
          rejectsData = [{
            rejectFn: {status: 500, text: 'Server error'}
            rejectIf: !@util.server.missingdays
          }]
          @util.asyncData(resolveData(), rejectsData, @util.debounce)
        add: (data) ->
          @list = @getAllNow()
          resolveFn = () =>
            if @util.server.missingdays and data?.userId?
              newModel = new MissingDaysModelService(data.userId, data.type, data.from, data.to)
              @list.push newModel
              @saveToStorage()
              {status: 200, data: newModel}
          rejectsData = [{
              rejectFn: {status: 500, text: 'Server error'}
              rejectIf: !@util.server.missingdays
          },{
              rejectFn: {status: 404, text: 'No search user'}
              rejectIf: not(data?.userId?)
          }]
          @util.asyncData(resolveFn(), rejectsData, @util.debounce)
        edit: (data) ->
          @list = @getAllNow()
          resolveData = ()=>
            if @util.server.missingdays
              index = @getByIdIndexNow(data.id)
              @list.splice(index, 1, data)
              @saveToStorage()
              {'data':  @list[index], 'status': 200}
          rejectsData = [{
              rejectFn: {status: 500, text: 'Server error'}
              rejectIf: !@util.server.missingdays
          }]
          @util.asyncData(resolveData(), rejectsData, @util.debounce)
        del: (data) ->
          @list = @getAllNow()
          resolveData = ()=>
            if @util.server.missingdays
              index = @getByIdIndexNow(data.id)
              @list.splice(index, 1)
              @saveToStorage()
              {'data':  data, 'status': 200}
          rejectsData = [{
            rejectFn: {status: 500, text: 'Server error'}
            rejectIf: !@util.server.missingdays
          }]
          @util.asyncData(resolveData(), rejectsData, @util.debounce)
        getDatesObject:(data)=>
          result = {}
          if data.status isnt 200
            data
          else
            filter = data.data
            filter.forEach((elem)=>
              prop = @util.nameMissingdaysTypes(elem.type)
              if result?.hasOwnProperty(prop)
                result[prop] = result[prop].concat(elem.transformPeriod)
              else
                result[prop] = []
                result[prop] = elem.transformPeriod
            )
          # console.log result
          result
    ]
)(window.angular)