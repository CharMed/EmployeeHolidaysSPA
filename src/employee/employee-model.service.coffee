((angular) ->
  angular.module('employee.employee-model', ['util.service'])
    .factory 'EmployeeModelService', [ 'UtilService', (UtilService)->
      class EmployeeModelService
        constructor: (name = 'New employyer', dateStart = new Date()) ->
          @id = UtilService.quuid()
          @name = name
          @position = 'Position'
          @dateStart = UtilService.normalizeDate(dateStart)
          @dateEnd = null
          # @status = UtilService.missingdaystypes.working.id
          @activity = true
        # fire: (dt) ->
        #   @dateEnd = UtilService.normalizeDate(dt)
        #   @activity = false
        #   return
        #  resume: (dt) ->
        #   @dateStart = UtilService.normalizeDate(dateStart)
        #   @dateEnd = null
        #   @activity = true
        #   return
    ]
)(window.angular)