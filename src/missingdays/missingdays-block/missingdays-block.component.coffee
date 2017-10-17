((angular) ->
  class MissingDaysBlockCntl
    constructor: (UtilService) ->
      @util = UtilService
      # console.log 'This is MissingDaysBlockCntl'
    $onInit:()->
      # console.log @missing
      @missing.typename = @util.nameMissingdaysTypes(@missing.type)
      return
  angular.module('missingdays.block', ['ui.bootstrap.tooltip', 'util.service'])
        .component 'ehaMissingDaysBlock',
        templateUrl: './template/missingdays-block.component.html'
        controller: ['UtilService', MissingDaysBlockCntl]
        bindings:
          'missing': '<'
          'add': '<'
  return
)(window.angular)
