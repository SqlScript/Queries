/* Author : Manoj Kumar Mahato
Developed for Pepal Event Calendar
*/
(function ($) {
    $.EC = function (p) {
        p = $.extend({
            selector: null,
            title: '',
            setting: { pYear: 2015, pMonth: 7, pStart: 26, pEnd: 31, end: 31 },
            Action: { calPrev: '', calNext: '', calMonth: '' },
            Current: { cYear: 2016, cMonth: 1 }
        }, p);
        var Month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
        var Months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
        var EC = {
            config: {
                selector: p.selector,
                title: p.title,
                setting: p.setting,
                Action: p.Action,
                Current: p.Current
            },
            executeFunctionByName: function (functionName, context, args) {
                var args = [].slice.call(arguments).splice(2);
                var namespaces = functionName.split(".");
                var func = namespaces.pop();
                for (var i = 0; i < namespaces.length; i++) {
                    context = context[namespaces[i]];
                }
                return context[func].apply(this, args);
            },
            CreateHTML: function () {
                EC.CreateHtml(EC.config.setting);
            },
            CreateHtml: function (setting) {
                var headerHtml = '<div>' + EC.config.title + '</div><div class="fc-toolbar">';
                // start datepicker
                headerHtml += '<div class="fc-center sfAlignCenter">';
                headerHtml += '<span class="hrisicon-prev callevent" method="' + EC.config.Action.calPrev + '"><</span>';
                headerHtml += '<span class="callDate" method="' + EC.config.Action.calMonth + '"><span class="hrisicon-calendar"></span>' + ' ' + Month[(EC.config.Current.cMonth - 1)] + ' ' + EC.config.Current.cYear + ' ' + '</span>';
                // headerHtml += '<span class="hrisicon-calendar" method="' + EC.config.Action.calMonth + '">&nbsp;</span>';
                headerHtml += '<span class="hrisicon-next callevent" method="' + EC.config.Action.calNext + '">></span>';
                headerHtml += '</div>';
                headerHtml += EC.MonthPicker(EC.config.Current.cYear, EC.config.Current.cMonth, false);
                // end datepicker
                headerHtml += '</div>';
                EC.config.selector.html(headerHtml);
                $('.event-more').on('click', function () {
                    $(this).hide();
                    $(this).parents('tr').siblings('tr').find('.event-less').show();
                    var heights = $(this).parents('.fc-row').find('.fc-content-skeleton').height();
                    $(this).parents('.fc-row').css('height', '' + heights + 'px');
                });
                $('.event-less').on('click', function () {
                    $(this).hide();
                    $(this).parents('tr').siblings('tr').find('.event-more').show();
                    var heights = 152;//14
                    $(this).parents('.fc-row').css('height', '' + heights + 'px');
                });
                EC.FireEvents();
            },
            convertToTwoDigit: function (num) {
                return num / 10 < 1 ? ("0" + num) : (num);
            },
            MonthPicker: function (year, month, isShow) {
                var html = '<div class="month-picker"';
                if (!isShow) {
                    html += 'style="display:none;"';
                }
                html += '>';
                html += '<table>';
                html += '<thead><tr><th colspan="4"><div class="month-picker-yr">';
                html += '<span class="icon-arrow-w sfFloatLeft" title="Previous Year"><</span>';
                html += '<span class="holder">' + year + '</span>'
                html += '<span class="icon-arrow-e sfFloatRight" title="Next Year">></span>';
                html += '</div></th></tr></thead><tbody>';
                for (var i = 0; i < 3; i++) {
                    html += '<tr>';
                    for (var j = 0; j < 4; j++) {
                        html += '<td>';
                        if (month == ((i * 4 + j) + 1)) {
                            html += '<div title="' + Months[i * 4 + j] + '" class="current month callevent" method="' + EC.config.Action.calMonth + '" args="' + year + '.' + ((i * 4 + j) + 1) + '" val=' + ((i * 4 + j) + 1) + '>' + Month[i * 4 + j] + '</div>';
                        }
                        else {
                            html += '<div title="' + Months[i * 4 + j] + '" method="' + EC.config.Action.calMonth + '" class="month callevent" args="' + year + '.' + ((i * 4 + j) + 1) + '" val=' + ((i * 4 + j) + 1) + '>' + Month[i * 4 + j] + '</div>';
                        }
                        html += '</td>';

                    } html += '</tr>';
                }
                html += '</tbody></table>';
                html += '</div>';
                return html;
            },
            FireEvents: function () {
                $('.fc-toolbar').on('click', '.callevent', function () {
                    var current = $(this);
                    if (current.attr('method') != '') {
                        var callMethod = current.attr('method');
                        var args = current.attr('args');
                        EC.executeFunctionByName(callMethod, window, args);
                    }
                });
                $('.calendar-wrap').on('click', '.callevent', function () {
                    var current = $(this);
                    if (current.attr('method') != '') {
                        var callMethod = current.attr('method');
                        var args = current.attr('args');
                        EC.executeFunctionByName(callMethod, window, args);
                    }
                });
                $('.hrisicon-calendar').parent('span').on('click', function () {
                    $(this).parents('.fc-toolbar').find('.month-picker').slideToggle();
                });
                $('.fc-toolbar').on('click', ' .month-picker .icon-arrow-w', function () {
                    var selector = $(this).parents('.month-picker').parents('.fc-toolbar');
                    EC.config.Current.cYear = EC.config.Current.cYear - 1;
                    EC.config.Current.cMonth = 0;
                    selector.find('.month-picker').remove();
                    selector.append(EC.MonthPicker(EC.config.Current.cYear, EC.config.Current.cMonth, true));
                });
                $('.fc-toolbar ').on('click', '.month-picker .icon-arrow-e', function () {
                    var selector = $(this).parents('.month-picker').parents('.fc-toolbar');
                    EC.config.Current.cYear = EC.config.Current.cYear + 1;
                    EC.config.Current.cMonth = 0;
                    selector.find('.month-picker').remove();
                    selector.append(EC.MonthPicker(EC.config.Current.cYear, EC.config.Current.cMonth, true));
                });
            },
            init: function () {
                EC.CreateHTML();
            }
        };
        EC.init();
    };
    $.fn.MonthPicker = function (p) {
        $.EC(p);
    };
})(jQuery);