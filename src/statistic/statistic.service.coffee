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
# ###
# ((angular) ->
#   angular.module('statistic.service', ['settings.service', 'missingdays.service'])
#     .factory 'StatisticService', ['SettingsService', 'MissingDaysService', (SettingsService, MissingDaysService) ->
#       class StatisticService
#         constructor: (SettingsService, MissingDaysService ) ->
#       #     # SettingsService.getWeekends(((data)-> @weekends = data.data).bind(@))
#       #     # @hollydaysAll = getDatesObject(null, new Date().setMounth(0).setDate(1), new Date().setMounth(11).setDate(0))
#           console.log 'This is StatisticService'
#       #   init: ()->

#       #   monthNames: (num) ->
#       #     switch num
#       #       when 0 then 'Jan'
#       #       when 1 then 'Feb'
#       #       when 2 then 'Mar'
#       #       when 3 then 'Apr'
#       #       when 4 then 'Mai'
#       #       when 5 then 'June'
#       #       when 6 then 'Jule'
#       #       when 7 then 'Aug'
#       #       when 8 then 'Sep'
#       #       when 9 then 'Oct'
#       #       when 10 then 'Now'
#       #       when 11 then 'Dec'
#       #       else 'No mountd'
              
#       #   data: (userid = 0,
#       #     fromDate = new Date().setMounth(0),
#       #     toDate = new Date().setMounth(11))->
#       #     series = ['Working', 'Hollydays', 'Weekends', 'Others']
#       #     labels = []
#       #     data = [[],[],[],[]]
#       #     curr = fromDate.setDate(1)
#       #     endDate = toDate.setDate(0)
#       #     while(curr <= endDate)
#       #       days = curr.setDate(0).getDate()
#       #       labels.push @monthNames curr.getMonth()
#       #       for (i = 1; i <= days; i++)



#   ]
#   return
# )(window.angular)
