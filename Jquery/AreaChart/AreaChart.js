/* Author : Manoj Kumar Mahato,
            Suresh Thapa, 
            Dipika Agrawal
  Developed for Pepal Project
            */
(function ($) {
    $.AreaChart = function (data) {
        var Chart = {
            ChartBuild: function (data) {
                $('#divGraph').show();
                var intWidth = parseInt($('#Graph').parent('div').width());
                var intHeight = 325;
                $('#Graph').attr({ width: intWidth, height: intHeight });
                var arrYear = [], arrMonth = [], arrSalary = [], arrFormatSalary = [], dif = 0, preYr = '', nextYr = '', defaultCurrency = '';
                if (data.d.length > 0) {
                    var myData = data.d;
                    $.each(myData, function (index, item) {
                        arrYear.push(item.Year);
                        arrMonth.push(item.Month);
                        arrSalary.push(item.TotalSalary);
                        arrFormatSalary.push(item.FormatSalary);
                        defaultCurrency = item.DefaultCurrency;
                        if (index != 0 && item.Year != myData[index - 1].Year) {
                            dif = index;
                        }
                    });
                    var cht = intHeight - 35;
                    var width = intWidth;
                    var height = intHeight;
                    var MaxSalary = Math.max.apply(Math, arrSalary)
                    var l = arrSalary.length;
                    preYr = myData[0].Year;
                    var c = document.getElementById("Graph");
                    var ctx = c.getContext("2d");
                    ctx.save();
                    ctx.restore();
                    ctx.clearRect(0, 0, c.width, c.height);
                    var m = (240 - 20) / MaxSalary;
                    ctx.fillStyle = "transparent";
                    ctx.fillRect(5, 0, c.width, c.height); // fill Color
                    ctx.font = "700 14px Lato";
                    ctx.fillStyle = '#060709';
                    ctx.fillText(preYr, 21.17, 21.17); // current year 
                    var a = (width - 10) / (l - 1);
                    if (dif > 0) {
                        nextYr = myData[myData.length - 1].Year;
                        ctx.fillText(nextYr, (a * dif) - (a / 2) + 21.17, 21.27);
                        ctx.strokeStyle = '#e2e2e2';
                        ctx.beginPath();
                        ctx.moveTo((a * dif) - (a / 2) + 5, 0);
                        ctx.lineTo((a * dif) - (a / 2) + 5, cht);
                        ctx.lineWidth = 1;
                        ctx.stroke();
                        //first line y-axis
                        ctx.beginPath();
                        ctx.moveTo(5, 0);
                        ctx.lineTo(5, cht);
                        ctx.stroke();

                        //bottom line y-axis
                        ctx.beginPath();
                        ctx.moveTo(5, cht);
                        ctx.lineTo(width - 5, cht);
                        ctx.stroke();

                        //last line y-axis
                        ctx.beginPath();
                        ctx.moveTo(width - 5, 0);
                        ctx.lineTo(width - 5, cht);
                        ctx.stroke();
                    }
                    ctx.beginPath();
                    for (var i = 0; i < l; i++) {

                        ctx.lineTo((a * i) + 5, cht - arrSalary[i] * m);

                        ctx.stroke();
                        if (i == 0) {
                            ctx.textAlign = "left";
                        }
                        else if (i == (l - 1)) {
                            ctx.textAlign = "right";
                        }
                        else {
                            ctx.textAlign = "center";
                        }
                        ctx.fillStyle = '#a39da8';
                        ctx.font = "700 11.6666px Lato";
                        ctx.fillText(arrMonth[i], (a * i) + 5, (cht + 21.17));
                        ctx.strokeStyle = '#9764B6';
                    }
                    ctx.lineTo(width - 5, cht);
                    ctx.lineTo(5, cht);
                    ctx.fillStyle = "rgba(151,101,183,0.1)";
                    ctx.fill();
                    for (var i = 0; i < l; i++) {
                        ctx.fillStyle = "#9764B6";
                        ctx.beginPath();
                        ctx.arc((a * i) + 5, cht - arrSalary[i] * m, 5, 0, 2 * Math.PI, false);
                        ctx.lineWidth = 2;
                        ctx.fill();
                        ctx.strokeStyle = '#ffffff';
                        ctx.stroke();
                    }
                    for (var i = 0; i < l; i++) {
                        ctx.font = "700 11.6666px Lato";
                        ctx.fillStyle = '#a39da8';
                        if (i == 0) {
                            ctx.textAlign = "left";
                        }
                        else if (i == (l - 1)) {
                            ctx.textAlign = "right";
                        }
                        else {
                            ctx.textAlign = "center";
                        }
                        var salary = Chart.nFormatter(arrSalary[i], 1);
                        ctx.fillText(salary, (a * i) + 5, cht - arrSalary[i] * m - 10);

                    }
                    ctx.fillStyle = "rgba(0,0,0,0.02)";
                    ctx.fillRect(5, cht - 250, (a * dif) - (a / 2), 250); // fill Color
                }
            },
            nFormatter: function (num, digits) {
                var si = [
                  { value: 1E18, symbol: "E" },
                  { value: 1E15, symbol: "P" },
                  { value: 1E12, symbol: "T" },
                  { value: 1E9, symbol: "G" },
                  { value: 1E6, symbol: "M" },
                  { value: 1E3, symbol: "k" }
                ], i;
                for (i = 0; i < si.length; i++) {
                    if (num >= si[i].value) {
                        return (num / si[i].value).toFixed(digits).replace(/\.0+$|(\.[0-9]*[1-9])0+$/, "$1") + si[i].symbol;
                    }
                }
                return num.toString();
            },
            init: function () {

                $('#btnGenerate').on('click', function () {
                    Chart.ChartBuild(data);
                });
            },
        };
        Chart.init();
    };
    $.fn.AreaChart = function (data) {
        $.AreaChart(data);
    };
})(jQuery);