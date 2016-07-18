/* Author : Manoj Kumar Mahato
  Developed for Pepal Project*/
(function ($) {
    $.PieChart = function (data) {
        var Chart = {
            BindPieChart: function (data) {
                var myColor = ["#cc3a17", "#cc196e", "#761bcc", "#591dcc", "#217acc", "#23accc", "#1fccc7", "#21cca3", "#14cc66", "#aacc17", "#e8e154", "#e5a355"];
                var myData = [0, 0, 0, 0, 0];
                var regionID = [0, 0, 0, 0, 0];
                function getRandomColor() {
                    var letters = '0123456789ABCDEF'.split('');
                    var color = '#';
                    for (var i = 0; i < 6; i++) {
                        color += letters[Math.floor(Math.random() * 16)];
                    }
                    return color;
                }
                $.each(data, function (index, item) {
                    myData[index] = item.Total;
                    regionID[index] = item.ReasonID;
                    if (index > 11) {
                        myColor[index] = getRandomColor();
                    }
                });
                function getTotal() {
                    var myTotal = 0;
                    for (var j = 0; j < myData.length; j++) {
                        myTotal += (typeof myData[j] == 'number') ? myData[j] : 0;
                    }
                    return myTotal;
                }
                var tworadious = $('#pieGraph').width();
                $('#canvasPieGraph').attr({ 'width': tworadious });
                $('#canvasPieGraph').attr({ 'height': tworadious });
                var radious = (tworadious) / 2;
                function plotData() {
                    var canvas;
                    var ctx;
                    var lastend = -Math.PI / 2;
                    var myTotal = getTotal();
                    var radius = radious;
                    canvas = document.getElementById("canvasPieGraph");
                    ctx = canvas.getContext("2d");
                    ctx.clearRect(0, 0, canvas.width, canvas.height);
                    ctx.beginPath();
                    ctx.moveTo(radius, radius);
                    ctx.arc(radius, radius, radius, 0, 2 * Math.PI, false);
                    ctx.fillStyle = '#E5D7E7';
                    ctx.fill();
                    for (var i = 0; i < myData.length; i++) {
                        ctx.fillStyle = myColor[i];
                        ctx.beginPath();
                        ctx.moveTo(radius, radius);
                        ctx.arc(radius, radius, radius, lastend, lastend + (Math.PI * 2 * (myData[i] / myTotal)), false);
                        ctx.lineTo(radius, radius);
                        ctx.fill();
                        if (myData[i] != 0 && i != 0) {
                            ctx.beginPath();
                            ctx.strokeStyle = '#f7f7f7';
                            ctx.moveTo(radius, radius);
                            ctx.lineWidth = 1.5;
                            ctx.lineTo(radius + (Math.cos(lastend) * radius), radius + (Math.sin(lastend) * radius));
                            ctx.stroke();
                        }
                        if (i == (myData.length - 1) && myTotal != 0) {
                            ctx.beginPath();
                            ctx.strokeStyle = '#f7f7f7';
                            ctx.lineWidth = 1.5;
                            ctx.moveTo(radius, radius);
                            ctx.lineTo(radius, 0);
                            ctx.stroke();
                        }

                        lastend += (Math.PI * 2 * (myData[i] / myTotal));

                    }
                }
                plotData();
            },
            htmlEncode: function (html) {
                return document.createElement('a').appendChild(
                    document.createTextNode(html)).parentNode.innerHTML;
            },
            init: function () {
                $('#btnGenerate').on('click', function () {
                    Chart.BindPieChart(data);
                });
            }
        };
        Chart.init();
    };
    $.fn.PieChart = function (p) {
        $.PieChart(p);
    };
})(jQuery);