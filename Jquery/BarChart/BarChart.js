/* Author : Manoj Kumar Mahato
  Developed for Pepal Project*/
(function ($) {
    $.BarChart = function (data) {
        var Chart = {
            htmlEncode: function (html) {
                return document.createElement('a').appendChild(
                    document.createTextNode(html)).parentNode.innerHTML;
            },
            ChartBuild: function (data) {
                var graphWidth = $('#verticalGraph').width();
                $('#canvasGraph').width(graphWidth);
                var canvas = document.getElementById('canvasGraph');
                canvas.width = $("#verticalGraph").width();
                canvas.height = 325;
                var arrYear = [], arrMonth = [], arrEmp = [], dif = 0, preYr = '', nextYr = '';
                if (data.length > 0) {
                    var myData = data;
                    $.each(myData, function (index, item) {
                        arrYear.push(item.Year);
                        arrMonth.push(item.Month);
                        arrEmp.push(item.Data);
                        if (index != 0 && item.Year != myData[index - 1].Year) {
                            dif = index;
                        }
                    });
                    preYr = myData[0].Year;

                    //draw canvas                   
                    var c = document.getElementById("canvasGraph");
                    var ctx = c.getContext("2d");
                    ctx.clearRect(0, 0, c.width, c.height);
                    var l = data.length;

                    var maxValueInArray = Math.max.apply(Math, arrEmp);
                    var m = 240 / maxValueInArray;
                    var cht = $("#canvasGraph").attr('height');
                    var cWidth = $("#canvasGraph").attr('width')
                    var factor = (cWidth - 34.268) / l;
                    var width = factor / 2;//40

                    ctx.font = "700 14px Lato";
                    ctx.fillText(preYr, 34.268, 19.552);
                    ctx.strokeStyle = '#060709';


                    if (dif > 0) {

                        nextYr = myData[myData.length - 1].Year;
                        ctx.font = "700 14px Lato";
                        ctx.fillText(nextYr, factor * dif + 34.268, 19.552)
                        ctx.strokeStyle = '#060709';

                        ctx.beginPath();
                        ctx.moveTo(0, 34.268);
                        ctx.lineTo(factor * dif + 15.134, 34.268);
                        ctx.lineTo(factor * dif + 15.134, cht - 26.423);
                        ctx.lineTo(0, cht - 26.423);
                        ctx.closePath();
                        ctx.fillStyle = "#f4f4f4";
                        ctx.fill();

                        ctx.beginPath();
                        ctx.moveTo(factor * dif + 15.134, 0);
                        ctx.lineTo(factor * dif + 15.134, cht - 26.423);
                        ctx.lineWidth = 1;
                        ctx.strokeStyle = '#e2e2e2';
                        ctx.stroke();


                    }

                    ctx.beginPath();
                    ctx.moveTo(0, 0);
                    ctx.lineTo(0, cht - 26.423);
                    ctx.lineWidth = 1;
                    ctx.strokeStyle = '#e2e2e2';
                    ctx.stroke();

                    for (i = 0; i < l; i++) {
                        ctx.fillStyle = "#eeeeee";
                        ctx.fillRect(34.268 + (i * factor), 34.268, width, cht - 60.619);

                        ctx.fillStyle = "#9665B7";
                        ctx.fillRect(34.268 + (i * factor), (cht - 26.423) - (arrEmp[i] * m), width, (arrEmp[i] * m));

                        ctx.font = "700 11.6666px Lato";
                        ctx.fillStyle = "#a39da8";
                        ctx.textAlign = "center";
                        ctx.fillText(arrEmp[i], width + width / 4 + (i * factor), (cht - 34.268) - (arrEmp[i] * m));


                        ctx.font = "700 11.6666px Lato";
                        ctx.fillStyle = "#a39da8";
                        ctx.fillText(arrMonth[i], width + width / 4 + (i * factor), cht - 5);
                    }

                    ctx.beginPath();
                    ctx.moveTo(0, cht - 26.423);
                    ctx.lineTo(cWidth, cht - 26.423);//700-->900-->1020
                    ctx.lineWidth = 1;
                    ctx.strokeStyle = '#e2e2e2';
                    ctx.stroke();
                }
            },
            init: function () {
                $('#btnGenerate').on('click', function () {
                    Chart.ChartBuild(data);
                });
            }
        };
        Chart.init();
    };
    $.fn.BarChart = function (p) {
        $.BarChart(p);
    };
})(jQuery);