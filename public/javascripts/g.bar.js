/*
 * g.Raphael 0.3 - Charting library, based on Raphaël (http://raphaeljs.com)
 *
 * Copyright (c) 2009 Dmitry Baranovskiy (http://g.raphaeljs.com)
 * Licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) license.
 */

Raphael.fn.g.barchart = function (x, y, width, height, values, isVertical, opts) {
    opts = opts || {};
    var type = {round: "round", sharp: "sharp", soft: "soft"}[opts.type] || "square",
        gutter = parseFloat(opts.gutter || "20%"),
        chart = this.set(),
        bars = this.set(),
        covers = this.set(),
        covers2 = this.set(),
        total = Math.max.apply(Math, values),
        stacktotal = [],
        paper = this,
        multi = 0,
        colors = opts.colors || this.g.colors,
        len = values.length;
    if (this.raphael.isArray(values[0])) {
        total = [];
        multi = len;
        len = 0;
        for (var i = values.length; i--;) {
            total.push(Math.max.apply(Math, values[i]));
            len = Math.max(len, values[i].length);
        }
        if (opts.stacked) {
            for (var i = len; i--;) {
                var tot = 0;
                for (var j = values.length; j--;) {
                    tot +=+ values[j][i] || 0;
                }
                stacktotal.push(tot);
            }
        }
        for (var i = values.length; i--;) {
            if (values[i].length < len) {
                for (var j = len; j--;) {
                    values[i].push(0);
                }
            }
        }
        total = Math.max.apply(Math, opts.stacked ? stacktotal : total);
    }
    
    total = (opts.to) || total;
    if (!isVertical) {
        var barwidth = width / (len * (100 + gutter) + gutter) * 100,
            barhgutter = barwidth * gutter / 100,
            barvgutter = typeof opts.vgutter == "undefined" ? 20 : opts.vgutter,
            stack = [],
            X = x + barhgutter,
            Y = (height - 2 * barvgutter) / total;
        if (!opts.stretch) {
            barhgutter = Math.round(barhgutter);
            barwidth = Math.floor(barwidth);
        }
        !opts.stacked && (barwidth /= multi || 1);
        for (var i = 0; i < len; i++) {
            stack = [];
            for (var j = 0; j < multi; j++) {
                var h = Math.round((multi ? values[j][i] : values[i]) * Y),
                    top = y + height - barvgutter - h,
                    bar;
                bars.push(bar = this.g.finger(Math.round(X + barwidth / 2), top + h, barwidth, opts.init ? 0 : h, true, type).attr({stroke: "none", fill: colors[multi ? j : i]}));
                bar.y = top;
                bar.x = Math.round(X + barwidth / 2);
                bar.w = barwidth;
                bar.h = h;
                bar.value = multi ? values[j][i] : values[i];
                opts.init && bar.animate({path: this.g.finger(Math.round(X + barwidth / 2), top + h, barwidth, h, true, type, 1)}, (+opts.init - 1) || 1000, ">");
                if (!opts.stacked) {
                    X += barwidth;
                } else {
                    stack.push(bar);
                }
            }
            if (opts.stacked) {
                var cvr;
                covers2.push(cvr = this.rect(stack[0].x - stack[0].w / 2, y, barwidth, height).attr({stroke: "none", fill: "#000", opacity: 0}));
                cvr.bars = [];
                for (var s = 0, ss = stack.length; s < ss; s++) {
                    cvr.bars.push(stack[s]);
                }
                stack.sort(function (a, b) {
                    return a.value - b.value;
                });
                var size = 0;
                for (var s = stack.length; s--;) {
                    stack[s].toFront();
                }
                for (var s = 0, ss = stack.length; s < ss; s++) {
                    var bar = stack[s],
                        cover,
                        h = (size + bar.value) * Y,
                        path = this.g.finger(bar.x, y + height - barvgutter - !!size * .5, barwidth, h, true, type, 1);
                    size && opts.init && bar.animate({path: path}, (+opts.init - 1) || 1000, ">");
                    size && !opts.init && bar.attr({path: path});
                    bar.h = h;
                    bar.y = y + height - barvgutter - !!size * .5 - h;
                    covers.push(cover = this.rect(bar.x - bar.w / 2, bar.y, barwidth, bar.value * Y).attr({stroke: "none", fill: "#000", opacity: 0}));
                    cover.bar = bar;
                    size += bar.value;
                }

                X += barwidth;
            }
            X += barhgutter;
        }
        covers2.toFront();
        X = x + barhgutter;
        if (!opts.stacked) {
            for (var i = 0; i < len; i++) {
                for (var j = 0; j < multi; j++) {
                    var cover;
                    covers.push(cover = this.rect(Math.round(X), y + barvgutter, barwidth, height - barvgutter).attr({stroke: "none", fill: "#000", opacity: 0}));
                    cover.bar = bars[i * (multi || 1) + j];
                    X += barwidth;
                }
                X += barhgutter;
            }
        }
        chart.label = function (labels, isBottom) {
            labels = labels || [];
            this.labels = paper.set();
            var L, l = -Infinity;
            if (opts.stacked) {
                for (var i = 0; i < len; i++) {
                    var tot = 0;
                    for (var j = 0; j < multi; j++) {
                        tot += multi ? values[j][i] : values[i];
                        if (j == multi - 1) {
                            var label = paper.g.labelise(labels[i], tot, total);
                            L = paper.g.text(bars[i * (multi || 1) + j].x, y + height - barvgutter / 2, label).insertBefore(covers[i * (multi || 1) + j]);
                            var bb = L.getBBox();
                            if (bb.x - 7 < l) {
                                L.remove();
                            } else {
                                this.labels.push(L);
                                l = bb.x + bb.width;
                            }
                        }
                    }
                }
            } else {
                for (var i = 0; i < len; i++) {
                    for (var j = 0; j < multi; j++) {
                        var label = paper.g.labelise(multi ? labels[j] && labels[j][i] : labels[i], multi ? values[j][i] : values[i], total);
                        L = paper.g.text(bars[i * (multi || 1) + j].x, isBottom ? y + height - barvgutter / 2 : bars[i * (multi || 1) + j].y - 10, label).insertBefore(covers[i * (multi || 1) + j]);
                        var bb = L.getBBox();
                        if (bb.x - 7 < l) {
                            L.remove();
                        } else {
                            this.labels.push(L);
                            l = bb.x + bb.width;
                        }
                    }
                }
            }
            return this;
        };
    } else {
        var barheight = Math.floor(height / (len * (100 + gutter) + gutter) * 100),
            bargutter = Math.floor(barheight * gutter / 100),
            stack = [],
            Y = y + bargutter,
            X = (width - 1) / total;
        !opts.stacked && (barheight /= multi || 1);
        for (var i = 0; i < len; i++) {
            stack = [];
            for (var j = 0; j < multi; j++) {
                var val = multi ? values[j][i] : values[i],
                    bar;
                bars.push(bar = this.g.finger(x, Y + barheight / 2, opts.init ? 0 : Math.round(val * X), barheight - 1, false, type).attr({stroke: colors[multi > 1 ? j : i], fill: colors[multi > 1 ? j : i]}));
                bar.x = x + Math.round(val * X);
                bar.y = Y + barheight / 2;
                bar.w = Math.round(val * X);
                bar.h = barheight;
                bar.value = +val;
                opts.init && bar.animate({path: this.g.finger(x, Y + barheight / 2, Math.round(val * X), barheight - 1, false, type, 1)}, (+opts.init - 1) || 500, ">");
                if (!opts.stacked) {
                    Y += barheight;
                } else {
                    stack.push(bar);
                }
            }
            if (opts.stacked) {
                stack.sort(function (a, b) {
                    return a.value - b.value;
                });
                var size = 0;
                for (var s = stack.length; s--;) {
                    stack[s].toFront();
                }
                for (var s = 0, ss = stack.length; s < ss; s++) {
                    var bar = stack[s],
                        cover,
                        val = Math.round((size + bar.value) * X),
                        path = this.g.finger(x, bar.y, val, barheight - 1, false, type, 1);
                    size && opts.init && bar.animate({path: path}, (+opts.init - 1) || 1000, ">");
                    size && !opts.init && bar.attr({path: path});
                    bar.w = val;
                    bar.x = x + val;
                    covers.push(cover = this.rect(x + size * X, bar.y - bar.h / 2, bar.value * X, barheight).attr({stroke: "none", fill: "#000", opacity: 0}));
                    cover.bar = bar;
                    size += bar.value;
                }
                Y += barheight;
            }
            Y += bargutter;
        }
        Y = y + bargutter;
        if (!opts.stacked) {
            for (var i = 0; i < len; i++) {
                for (var j = 0; j < multi; j++) {
                    covers.push(this.rect(x, Y, width, barheight).attr({stroke: "none", fill: "#000", opacity: 0}));
                    Y += barheight;
                }
                Y += bargutter;
            }
        }
        chart.label = function (labels, isRight) {
            labels = labels || [];
            this.labels = paper.set();
            for (var i = 0; i < len; i++) {
                for (var j = 0; j < multi; j++) {
                    var  label = paper.g.labelise(multi ? labels[j] && labels[j][i] : labels[i], multi ? values[j][i] : values[i], total);
                    var X = isRight ? bars[i * (multi || 1) + j].x - barheight / 2 + 3 : x + 5,
                        A = isRight ? "end" : "start",
                        L;
                    this.labels.push(L = paper.g.text(X, bars[i * (multi || 1) + j].y, label).attr({"text-anchor": A}).insertBefore(covers[0]));
                    if (L.getBBox().x < x + 5) {
                        L.attr({x: x + 5, "text-anchor": "start"});
                    } else {
                        bars[i * (multi || 1) + j].label = L;
                    }
                }
            }
            return this;
        };
    }
    chart.hover = function (fin, fout) {
        covers2.hide();
        covers.show();
        fout = fout || function () {};
        covers.mouseover(fin).mouseout(fout);
        return this;
    };
    chart.hoverColumn = function (fin, fout) {
        covers.hide();
        covers2.show();
        fout = fout || function () {};
        covers2.mouseover(fin).mouseout(fout);
        return this;
    };
    chart.click = function (f) {
        covers2.hide();
        covers.show();
        covers.click(f);
        return this;
    };
    chart.clickColumn = function (f) {
        covers.hide();
        covers2.show();
        covers2.click(f);
        return this;
    };
    chart.push(bars, covers, covers2);
    chart.bars = bars;
    chart.covers = covers;
    return chart;
};