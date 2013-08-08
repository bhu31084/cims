/*modifyed Date:12-09-2008*/
/* This notice must be untouched at all times.

wz_jsgraphics.js    v. 3.03
The latest version is available at
http://www.walterzorn.com
or http://www.devira.com
or http://www.walterzorn.de

Copyright (c) 2002-2004 Walter Zorn. All rights reserved.
Created 3. 11. 2002 by Walter Zorn (Web: http://www.walterzorn.com )
Last modified: 28. 1. 2008

Performance optimizations for Internet Explorer
by Thomas Frank and John Holdsworth.
fillPolygon method implemented by Matthieu Haller.

High Performance JavaScript Graphics Library.
Provides methods
- to draw lines, rectangles, ellipses, polygons
	with specifiable line thickness,
- to fill rectangles, polygons, ellipses and arcs
- to draw text.
NOTE: Operations, functions and branching have rather been optimized
to efficiency and speed than to shortness of source code.

LICENSE: LGPL

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License (LGPL) as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA,
or see http://www.gnu.org/copyleft/lesser.html
*/


var jg_ok, jg_ie, jg_fast, jg_dom, jg_moz;


function _chkDHTM(x, i)
{
	x = document.body || null;
	jg_ie = x && typeof x.insertAdjacentHTML != "undefined" && document.createElement;
	jg_dom = (x && !jg_ie &&
		typeof x.appendChild != "undefined" &&
		typeof document.createRange != "undefined" &&
		typeof (i = document.createRange()).setStartBefore != "undefined" &&
		typeof i.createContextualFragment != "undefined");
	jg_fast = jg_ie && document.all && !window.opera;
	jg_moz = jg_dom && typeof x.style.MozOpacity != "undefined";
	jg_ok = !!(jg_ie || jg_dom);
}

function _pntCnvDom()
{
	var x = this.wnd.document.createRange();
	x.setStartBefore(this.cnv);
	x = x.createContextualFragment(jg_fast? this._htmRpc() : this.htm);
	if(this.cnv) this.cnv.appendChild(x);
	this.htm = "";
}

function _pntCnvIe()
{
	if(this.cnv) this.cnv.insertAdjacentHTML("BeforeEnd", jg_fast? this._htmRpc() : this.htm);
	this.htm = "";
}

function _pntDoc()
{
	this.wnd.document.write(jg_fast? this._htmRpc() : this.htm);
	this.htm = '';
}

function _pntN()
{
	;
}

function _mkDiv(x, y, w, h)
{
	this.htm += '<div style="position:absolute;'+
		'left:' + x + 'px;'+
		'top:' + y + 'px;'+
		'width:' + w + 'px;'+
		'height:' + h + 'px;'+
		'clip:rect(0,'+w+'px,'+h+'px,0);'+
		'background-color:' + this.color +
		(!jg_moz? ';overflow:hidden' : '')+
		';"><\/div>';
}

function _mkDivIe(x, y, w, h)
{
	this.htm += '%%'+this.color+';'+x+';'+y+';'+w+';'+h+';';
}

function _mkDivPrt(x, y, w, h)
{
	this.htm += '<div style="position:absolute;'+
		'border-left:' + w + 'px solid ' + this.color + ';'+
		'left:' + x + 'px;'+
		'top:' + y + 'px;'+
		'width:0px;'+
		'height:' + h + 'px;'+
		'clip:rect(0,'+w+'px,'+h+'px,0);'+
		'background-color:' + this.color +
		(!jg_moz? ';overflow:hidden' : '')+
		';"><\/div>';
}

var _regex =  /%%([^;]+);([^;]+);([^;]+);([^;]+);([^;]+);/g;
function _htmRpc()
{
	return this.htm.replace(
		_regex,
		'<div style="overflow:hidden;position:absolute;background-color:'+
		'$1;left:$2;top:$3;width:$4;height:$5"></div>\n');
}

function _htmPrtRpc()
{
	return this.htm.replace(
		_regex,
		'<div style="overflow:hidden;position:absolute;background-color:'+
		'$1;left:$2;top:$3;width:$4;height:$5;border-left:$4px solid $1"></div>\n');
}

function _mkLin(x1, y1, x2, y2)
{
	if(x1 > x2)
	{
		var _x2 = x2;
		var _y2 = y2;
		x2 = x1;
		y2 = y1;
		x1 = _x2;
		y1 = _y2;
	}
	var dx = x2-x1, dy = Math.abs(y2-y1),
	x = x1, y = y1,
	yIncr = (y1 > y2)? -1 : 1;

	if(dx >= dy)
	{
		var pr = dy<<1,
		pru = pr - (dx<<1),
		p = pr-dx,
		ox = x;
		while(dx > 0)
		{--dx;
			++x;
			if(p > 0)
			{
				this._mkDiv(ox, y, x-ox, 1);
				y += yIncr;
				p += pru;
				ox = x;
			}
			else p += pr;
		}
		this._mkDiv(ox, y, x2-ox+1, 1);
	}

	else
	{
		var pr = dx<<1,
		pru = pr - (dy<<1),
		p = pr-dy,
		oy = y;
		if(y2 <= y1)
		{
			while(dy > 0)
			{--dy;
				if(p > 0)
				{
					this._mkDiv(x++, y, 1, oy-y+1);
					y += yIncr;
					p += pru;
					oy = y;
				}
				else
				{
					y += yIncr;
					p += pr;
				}
			}
			this._mkDiv(x2, y2, 1, oy-y2+1);
		}
		else
		{
			while(dy > 0)
			{--dy;
				y += yIncr;
				if(p > 0)
				{
					this._mkDiv(x++, oy, 1, y-oy);
					p += pru;
					oy = y;
				}
				else p += pr;
			}
			this._mkDiv(x2, oy, 1, y2-oy+1);
		}
	}
}

function _mkLin2D(x1, y1, x2, y2)
{
	if(x1 > x2)
	{
		var _x2 = x2;
		var _y2 = y2;
		x2 = x1;
		y2 = y1;
		x1 = _x2;
		y1 = _y2;
	}
	var dx = x2-x1, dy = Math.abs(y2-y1),
	x = x1, y = y1,
	yIncr = (y1 > y2)? -1 : 1;

	var s = this.stroke;
	if(dx >= dy)
	{
		if(dx > 0 && s-3 > 0)
		{
			var _s = (s*dx*Math.sqrt(1+dy*dy/(dx*dx))-dx-(s>>1)*dy) / dx;
			_s = (!(s-4)? Math.ceil(_s) : Math.round(_s)) + 1;
		}
		else var _s = s;
		var ad = Math.ceil(s/2);

		var pr = dy<<1,
		pru = pr - (dx<<1),
		p = pr-dx,
		ox = x;
		while(dx > 0)
		{--dx;
			++x;
			if(p > 0)
			{
				this._mkDiv(ox, y, x-ox+ad, _s);
				y += yIncr;
				p += pru;
				ox = x;
			}
			else p += pr;
		}
		this._mkDiv(ox, y, x2-ox+ad+1, _s);
	}

	else
	{
		if(s-3 > 0)
		{
			var _s = (s*dy*Math.sqrt(1+dx*dx/(dy*dy))-(s>>1)*dx-dy) / dy;
			_s = (!(s-4)? Math.ceil(_s) : Math.round(_s)) + 1;
		}
		else var _s = s;
		var ad = Math.round(s/2);

		var pr = dx<<1,
		pru = pr - (dy<<1),
		p = pr-dy,
		oy = y;
		if(y2 <= y1)
		{
			++ad;
			while(dy > 0)
			{--dy;
				if(p > 0)
				{
					this._mkDiv(x++, y, _s, oy-y+ad);
					y += yIncr;
					p += pru;
					oy = y;
				}
				else
				{
					y += yIncr;
					p += pr;
				}
			}
			this._mkDiv(x2, y2, _s, oy-y2+ad);
		}
		else
		{
			while(dy > 0)
			{--dy;
				y += yIncr;
				if(p > 0)
				{
					this._mkDiv(x++, oy, _s, y-oy+ad);
					p += pru;
					oy = y;
				}
				else p += pr;
			}
			this._mkDiv(x2, oy, _s, y2-oy+ad+1);
		}
	}
}

function _mkLinDott(x1, y1, x2, y2)
{
	if(x1 > x2)
	{
		var _x2 = x2;
		var _y2 = y2;
		x2 = x1;
		y2 = y1;
		x1 = _x2;
		y1 = _y2;
	}
	var dx = x2-x1, dy = Math.abs(y2-y1),
	x = x1, y = y1,
	yIncr = (y1 > y2)? -1 : 1,
	drw = true;
	if(dx >= dy)
	{
		var pr = dy<<1,
		pru = pr - (dx<<1),
		p = pr-dx;
		while(dx > 0)
		{--dx;
			if(drw) this._mkDiv(x, y, 1, 1);
			drw = !drw;
			if(p > 0)
			{
				y += yIncr;
				p += pru;
			}
			else p += pr;
			++x;
		}
	}
	else
	{
		var pr = dx<<1,
		pru = pr - (dy<<1),
		p = pr-dy;
		while(dy > 0)
		{--dy;
			if(drw) this._mkDiv(x, y, 1, 1);
			drw = !drw;
			y += yIncr;
			if(p > 0)
			{
				++x;
				p += pru;
			}
			else p += pr;
		}
	}
	if(drw) this._mkDiv(x, y, 1, 1);
}

function _mkOv(left, top, width, height)
{
	var a = (++width)>>1, b = (++height)>>1,
	wod = width&1, hod = height&1,
	cx = left+a, cy = top+b,
	x = 0, y = b,
	ox = 0, oy = b,
	aa2 = (a*a)<<1, aa4 = aa2<<1, bb2 = (b*b)<<1, bb4 = bb2<<1,
	st = (aa2>>1)*(1-(b<<1)) + bb2,
	tt = (bb2>>1) - aa2*((b<<1)-1),
	w, h;
	while(y > 0)
	{
		if(st < 0)
		{
			st += bb2*((x<<1)+3);
			tt += bb4*(++x);
		}
		else if(tt < 0)
		{
			st += bb2*((x<<1)+3) - aa4*(y-1);
			tt += bb4*(++x) - aa2*(((y--)<<1)-3);
			w = x-ox;
			h = oy-y;
			if((w&2) && (h&2))
			{
				this._mkOvQds(cx, cy, x-2, y+2, 1, 1, wod, hod);
				this._mkOvQds(cx, cy, x-1, y+1, 1, 1, wod, hod);
			}
			else this._mkOvQds(cx, cy, x-1, oy, w, h, wod, hod);
			ox = x;
			oy = y;
		}
		else
		{
			tt -= aa2*((y<<1)-3);
			st -= aa4*(--y);
		}
	}
	w = a-ox+1;
	h = (oy<<1)+hod;
	y = cy-oy;
	this._mkDiv(cx-a, y, w, h);
	this._mkDiv(cx+ox+wod-1, y, w, h);
}

function _mkOv2D(left, top, width, height)
{
	var s = this.stroke;
	width += s+1;
	height += s+1;
	var a = width>>1, b = height>>1,
	wod = width&1, hod = height&1,
	cx = left+a, cy = top+b,
	x = 0, y = b,
	aa2 = (a*a)<<1, aa4 = aa2<<1, bb2 = (b*b)<<1, bb4 = bb2<<1,
	st = (aa2>>1)*(1-(b<<1)) + bb2,
	tt = (bb2>>1) - aa2*((b<<1)-1);

	if(s-4 < 0 && (!(s-2) || width-51 > 0 && height-51 > 0))
	{
		var ox = 0, oy = b,
		w, h,
		pxw;
		while(y > 0)
		{
			if(st < 0)
			{
				st += bb2*((x<<1)+3);
				tt += bb4*(++x);
			}
			else if(tt < 0)
			{
				st += bb2*((x<<1)+3) - aa4*(y-1);
				tt += bb4*(++x) - aa2*(((y--)<<1)-3);
				w = x-ox;
				h = oy-y;

				if(w-1)
				{
					pxw = w+1+(s&1);
					h = s;
				}
				else if(h-1)
				{
					pxw = s;
					h += 1+(s&1);
				}
				else pxw = h = s;
				this._mkOvQds(cx, cy, x-1, oy, pxw, h, wod, hod);
				ox = x;
				oy = y;
			}
			else
			{
				tt -= aa2*((y<<1)-3);
				st -= aa4*(--y);
			}
		}
		this._mkDiv(cx-a, cy-oy, s, (oy<<1)+hod);
		this._mkDiv(cx+a+wod-s, cy-oy, s, (oy<<1)+hod);
	}

	else
	{
		var _a = (width-(s<<1))>>1,
		_b = (height-(s<<1))>>1,
		_x = 0, _y = _b,
		_aa2 = (_a*_a)<<1, _aa4 = _aa2<<1, _bb2 = (_b*_b)<<1, _bb4 = _bb2<<1,
		_st = (_aa2>>1)*(1-(_b<<1)) + _bb2,
		_tt = (_bb2>>1) - _aa2*((_b<<1)-1),

		pxl = new Array(),
		pxt = new Array(),
		_pxb = new Array();
		pxl[0] = 0;
		pxt[0] = b;
		_pxb[0] = _b-1;
		while(y > 0)
		{
			if(st < 0)
			{
				pxl[pxl.length] = x;
				pxt[pxt.length] = y;
				st += bb2*((x<<1)+3);
				tt += bb4*(++x);
			}
			else if(tt < 0)
			{
				pxl[pxl.length] = x;
				st += bb2*((x<<1)+3) - aa4*(y-1);
				tt += bb4*(++x) - aa2*(((y--)<<1)-3);
				pxt[pxt.length] = y;
			}
			else
			{
				tt -= aa2*((y<<1)-3);
				st -= aa4*(--y);
			}

			if(_y > 0)
			{
				if(_st < 0)
				{
					_st += _bb2*((_x<<1)+3);
					_tt += _bb4*(++_x);
					_pxb[_pxb.length] = _y-1;
				}
				else if(_tt < 0)
				{
					_st += _bb2*((_x<<1)+3) - _aa4*(_y-1);
					_tt += _bb4*(++_x) - _aa2*(((_y--)<<1)-3);
					_pxb[_pxb.length] = _y-1;
				}
				else
				{
					_tt -= _aa2*((_y<<1)-3);
					_st -= _aa4*(--_y);
					_pxb[_pxb.length-1]--;
				}
			}
		}

		var ox = -wod, oy = b,
		_oy = _pxb[0],
		l = pxl.length,
		w, h;
		for(var i = 0; i < l; i++)
		{
			if(typeof _pxb[i] != "undefined")
			{
				if(_pxb[i] < _oy || pxt[i] < oy)
				{
					x = pxl[i];
					this._mkOvQds(cx, cy, x, oy, x-ox, oy-_oy, wod, hod);
					ox = x;
					oy = pxt[i];
					_oy = _pxb[i];
				}
			}
			else
			{
				x = pxl[i];
				this._mkDiv(cx-x, cy-oy, 1, (oy<<1)+hod);
				this._mkDiv(cx+ox+wod, cy-oy, 1, (oy<<1)+hod);
				ox = x;
				oy = pxt[i];
			}
		}
		this._mkDiv(cx-a, cy-oy, 1, (oy<<1)+hod);
		this._mkDiv(cx+ox+wod, cy-oy, 1, (oy<<1)+hod);
	}
}

function _mkOvDott(left, top, width, height)
{
	var a = (++width)>>1, b = (++height)>>1,
	wod = width&1, hod = height&1, hodu = hod^1,
	cx = left+a, cy = top+b,
	x = 0, y = b,
	aa2 = (a*a)<<1, aa4 = aa2<<1, bb2 = (b*b)<<1, bb4 = bb2<<1,
	st = (aa2>>1)*(1-(b<<1)) + bb2,
	tt = (bb2>>1) - aa2*((b<<1)-1),
	drw = true;
	while(y > 0)
	{
		if(st < 0)
		{
			st += bb2*((x<<1)+3);
			tt += bb4*(++x);
		}
		else if(tt < 0)
		{
			st += bb2*((x<<1)+3) - aa4*(y-1);
			tt += bb4*(++x) - aa2*(((y--)<<1)-3);
		}
		else
		{
			tt -= aa2*((y<<1)-3);
			st -= aa4*(--y);
		}
		if(drw && y >= hodu) this._mkOvQds(cx, cy, x, y, 1, 1, wod, hod);
		drw = !drw;
	}
}

function _mkRect(x, y, w, h)
{
	var s = this.stroke;
	this._mkDiv(x, y, w, s);
	this._mkDiv(x+w, y, s, h);
	this._mkDiv(x, y+h, w+s, s);
	this._mkDiv(x, y+s, s, h-s);
}

function _mkRectDott(x, y, w, h)
{
	this.drawLine(x, y, x+w, y);
	this.drawLine(x+w, y, x+w, y+h);
	this.drawLine(x, y+h, x+w, y+h);
	this.drawLine(x, y, x, y+h);
}

function jsgFont()
{
	this.PLAIN = 'font-weight:normal;';
	this.BOLD = 'font-weight:bold;';
	this.ITALIC = 'font-style:italic;';
	this.ITALIC_BOLD = this.ITALIC + this.BOLD;
	this.BOLD_ITALIC = this.ITALIC_BOLD;
}
var Font = new jsgFont();

function jsgStroke()
{
	this.DOTTED = -1;
}
var Stroke = new jsgStroke();

function jsGraphics(cnv, wnd)
{
	this.setColor = function(x)
	{
		this.color = x.toLowerCase();
	};

	this.setStroke = function(x)
	{
		this.stroke = x;
		if(!(x+1))
		{
			this.drawLine = _mkLinDott;
			this._mkOv = _mkOvDott;
			this.drawRect = _mkRectDott;
		}
		else if(x-1 > 0)
		{
			this.drawLine = _mkLin2D;
			this._mkOv = _mkOv2D;
			this.drawRect = _mkRect;
		}
		else
		{
			this.drawLine = _mkLin;
			this._mkOv = _mkOv;
			this.drawRect = _mkRect;
		}
	};

	this.setPrintable = function(arg)
	{
		this.printable = arg;
		if(jg_fast)
		{
			this._mkDiv = _mkDivIe;
			this._htmRpc = arg? _htmPrtRpc : _htmRpc;
		}
		else this._mkDiv = arg? _mkDivPrt : _mkDiv;
	};

	this.setFont = function(fam, sz, sty)
	{
		this.ftFam = fam;
		this.ftSz = sz;
		this.ftSty = sty || Font.PLAIN;
	};

	this.drawPolyline = this.drawPolyLine = function(x, y)
	{
		for (var i=x.length - 1; i;)
		{--i;
			this.drawLine(x[i], y[i], x[i+1], y[i+1]);
		}
	};

	this.fillRect = function(x, y, w, h)
	{
		this._mkDiv(x, y, w, h);
	};

	this.drawPolygon = function(x, y)
	{
		this.drawPolyline(x, y);
		this.drawLine(x[x.length-1], y[x.length-1], x[0], y[0]);
	};

	this.drawEllipse = this.drawOval = function(x, y, w, h)
	{
		this._mkOv(x, y, w, h);
	};

	this.fillEllipse = this.fillOval = function(left, top, w, h)
	{
		var a = w>>1, b = h>>1,
		wod = w&1, hod = h&1,
		cx = left+a, cy = top+b,
		x = 0, y = b, oy = b,
		aa2 = (a*a)<<1, aa4 = aa2<<1, bb2 = (b*b)<<1, bb4 = bb2<<1,
		st = (aa2>>1)*(1-(b<<1)) + bb2,
		tt = (bb2>>1) - aa2*((b<<1)-1),
		xl, dw, dh;
		if(w) while(y > 0)
		{
			if(st < 0)
			{
				st += bb2*((x<<1)+3);
				tt += bb4*(++x);
			}
			else if(tt < 0)
			{
				st += bb2*((x<<1)+3) - aa4*(y-1);
				xl = cx-x;
				dw = (x<<1)+wod;
				tt += bb4*(++x) - aa2*(((y--)<<1)-3);
				dh = oy-y;
				this._mkDiv(xl, cy-oy, dw, dh);
				this._mkDiv(xl, cy+y+hod, dw, dh);
				oy = y;
			}
			else
			{
				tt -= aa2*((y<<1)-3);
				st -= aa4*(--y);
			}
		}
		this._mkDiv(cx-a, cy-oy, w, (oy<<1)+hod);
	};

	this.fillArc = function(iL, iT, iW, iH, fAngA, fAngZ)
	{
		var a = iW>>1, b = iH>>1,
		iOdds = (iW&1) | ((iH&1) << 16),
		cx = iL+a, cy = iT+b,
		x = 0, y = b, ox = x, oy = y,
		aa2 = (a*a)<<1, aa4 = aa2<<1, bb2 = (b*b)<<1, bb4 = bb2<<1,
		st = (aa2>>1)*(1-(b<<1)) + bb2,
		tt = (bb2>>1) - aa2*((b<<1)-1),
		// Vars for radial boundary lines
		xEndA, yEndA, xEndZ, yEndZ,
		iSects = (1 << (Math.floor((fAngA %= 360.0)/180.0) << 3))
				| (2 << (Math.floor((fAngZ %= 360.0)/180.0) << 3))
				| ((fAngA >= fAngZ) << 16),
		aBndA = new Array(b+1), aBndZ = new Array(b+1);

		// Set up radial boundary lines
		fAngA *= Math.PI/180.0;
		fAngZ *= Math.PI/180.0;
		xEndA = cx+Math.round(a*Math.cos(fAngA));
		yEndA = cy+Math.round(-b*Math.sin(fAngA));
		_mkLinVirt(aBndA, cx, cy, xEndA, yEndA);
		xEndZ = cx+Math.round(a*Math.cos(fAngZ));
		yEndZ = cy+Math.round(-b*Math.sin(fAngZ));
		_mkLinVirt(aBndZ, cx, cy, xEndZ, yEndZ);

		while(y > 0)
		{
			if(st < 0) // Advance x
			{
				st += bb2*((x<<1)+3);
				tt += bb4*(++x);
			}
			else if(tt < 0) // Advance x and y
			{
				st += bb2*((x<<1)+3) - aa4*(y-1);
				ox = x;
				tt += bb4*(++x) - aa2*(((y--)<<1)-3);
				this._mkArcDiv(ox, y, oy, cx, cy, iOdds, aBndA, aBndZ, iSects);
				oy = y;
			}
			else // Advance y
			{
				tt -= aa2*((y<<1)-3);
				st -= aa4*(--y);
				if(y && (aBndA[y] != aBndA[y-1] || aBndZ[y] != aBndZ[y-1]))
				{
					this._mkArcDiv(x, y, oy, cx, cy, iOdds, aBndA, aBndZ, iSects);
					ox = x;
					oy = y;
				}
			}
		}
		this._mkArcDiv(x, 0, oy, cx, cy, iOdds, aBndA, aBndZ, iSects);
		if(iOdds >> 16) // Odd height
		{
			if(iSects >> 16) // Start-angle > end-angle
			{
				var xl = (yEndA <= cy || yEndZ > cy)? (cx - x) : cx;
				this._mkDiv(xl, cy, x + cx - xl + (iOdds & 0xffff), 1);
			}
			else if((iSects & 0x01) && yEndZ > cy)
				this._mkDiv(cx - x, cy, x, 1);
		}
	};

/* fillPolygon method, implemented by Matthieu Haller.
This javascript function is an adaptation of the gdImageFilledPolygon for Walter Zorn lib.
C source of GD 1.8.4 found at http://www.boutell.com/gd/

THANKS to Kirsten Schulz for the polygon fixes!

The intersection finding technique of this code could be improved
by remembering the previous intertersection, and by using the slope.
That could help to adjust intersections to produce a nice
interior_extrema. */
	this.fillPolygon = function(array_x, array_y)
	{
		var i;
		var y;
		var miny, maxy;
		var x1, y1;
		var x2, y2;
		var ind1, ind2;
		var ints;

		var n = array_x.length;
		if(!n) return;

		miny = array_y[0];
		maxy = array_y[0];
		for(i = 1; i < n; i++)
		{
			if(array_y[i] < miny)
				miny = array_y[i];

			if(array_y[i] > maxy)
				maxy = array_y[i];
		}
		for(y = miny; y <= maxy; y++)
		{
			var polyInts = new Array();
			ints = 0;
			for(i = 0; i < n; i++)
			{
				if(!i)
				{
					ind1 = n-1;
					ind2 = 0;
				}
				else
				{
					ind1 = i-1;
					ind2 = i;
				}
				y1 = array_y[ind1];
				y2 = array_y[ind2];
				if(y1 < y2)
				{
					x1 = array_x[ind1];
					x2 = array_x[ind2];
				}
				else if(y1 > y2)
				{
					y2 = array_y[ind1];
					y1 = array_y[ind2];
					x2 = array_x[ind1];
					x1 = array_x[ind2];
				}
				else continue;

				 //  Modified 11. 2. 2004 Walter Zorn
				if((y >= y1) && (y < y2))
					polyInts[ints++] = Math.round((y-y1) * (x2-x1) / (y2-y1) + x1);

				else if((y == maxy) && (y > y1) && (y <= y2))
					polyInts[ints++] = Math.round((y-y1) * (x2-x1) / (y2-y1) + x1);
			}
			polyInts.sort(_CompInt);
			for(i = 0; i < ints; i+=2)
				this._mkDiv(polyInts[i], y, polyInts[i+1]-polyInts[i]+1, 1);
		}
	};

	this.drawString = function(txt, x, y)
	{
		this.htm += '<div style="position:absolute;white-space:nowrap;'+
			'left:' + x + 'px;'+
			'top:' + y + 'px;'+
			'font-family:' +  this.ftFam + ';'+
			'font-size:' + this.ftSz + ';'+
			'color:' + this.color + ';' + this.ftSty + '">'+
			txt +
			'<\/div>';
	};

/* drawStringRect() added by Rick Blommers.
Allows to specify the size of the text rectangle and to align the
text both horizontally (e.g. right) and vertically within that rectangle */
	this.drawStringRect = function(txt, x, y, width, halign)
	{
		this.htm += '<div style="position:absolute;overflow:hidden;'+
			'left:' + x + 'px;'+
			'top:' + y + 'px;'+
			'width:'+width +'px;'+
			'text-align:'+halign+';'+
			'font-family:' +  this.ftFam + ';'+
			'font-size:' + this.ftSz + ';'+
			'color:' + this.color + ';' + this.ftSty + '">'+
			txt +
			'<\/div>';
	};

	this.drawImage = function(imgSrc, x, y, w, h, a)
	{
		this.htm += '<div style="position:absolute;'+
			'left:' + x + 'px;'+
			'top:' + y + 'px;'+
			// w (width) and h (height) arguments are now optional.
			// Added by Mahmut Keygubatli, 14.1.2008
			(w? ('width:' +  w + 'px;') : '') +
			(h? ('height:' + h + 'px;'):'')+'">'+
			'<img src="' + imgSrc +'"'+ (w ? (' width="' + w + '"'):'')+ (h ? (' height="' + h + '"'):'') + (a? (' '+a) : '') + '>'+
			'<\/div>';
	};

	this.clear = function(flag)
	{
		this.htm = "";
		if(this.cnv){
            if(flag=="1"){
            	var pitch_id = document.getElementById("pitch_id").src;
              document.getElementById("pitchCanvas").innerHTML ="";
              document.getElementById("pitchCanvas").innerHTML= '<img src="'+pitch_id+'" width="139" id="pitch_id" height="237" border="0" usemap="#pitch" onclick="showCir(event)" />'+
                                                                 '<map name="pitch" >'+
                                                                 '<area shape="rect" coords="20,37,30,47"  onclick="callFun.addPitch(1)" />'+
																 '<area shape="rect" coords="30,37,40,47"  onclick="callFun.addPitch(2)" />'+
																 '<area shape="rect" coords="40,37,50,47"  onclick="callFun.addPitch(3)" />'+
																 '<area shape="rect" coords="50,37,60,47"  onclick="callFun.addPitch(4)" />'+
																 '<area shape="rect" coords="60,37,70,47"  onclick="callFun.addPitch(5)" />'+
																 '<area shape="rect" coords="70,37,80,47"  onclick="callFun.addPitch(6)" />'+
																 '<area shape="rect" coords="80,37,90,47"  onclick="callFun.addPitch(7)" />'+
																 '<area shape="rect" coords="90,37,100,47"  onclick="callFun.addPitch(8)" />'+
																 '<area shape="rect" coords="100,37,110,47"  onclick="callFun.addPitch(9)" />'+
																 '<area shape="rect" coords="110,37,120,47"  onclick="callFun.addPitch(10)" />'+
																 '<area shape="rect" coords="20,47,30,57"  onclick="callFun.addPitch(11)" />'+
																 '<area shape="rect" coords="30,47,40,57"  onclick="callFun.addPitch(12)" />'+
																 '<area shape="rect" coords="40,47,50,57"  onclick="callFun.addPitch(13)" />'+
																 '<area shape="rect" coords="50,47,60,57"  onclick="callFun.addPitch(14)" />'+
																 '<area shape="rect" coords="60,47,70,57"  onclick="callFun.addPitch(15)" />'+
																 '<area shape="rect" coords="70,47,80,57"  onclick="callFun.addPitch(16)" />'+
																 '<area shape="rect" coords="80,47,90,57"  onclick="callFun.addPitch(17)" />'+
																 '<area shape="rect" coords="90,47,100,57"  onclick="callFun.addPitch(18)" />'+
																 '<area shape="rect" coords="100,47,110,57"  onclick="callFun.addPitch(19)" />'+
																 '<area shape="rect" coords="110,47,120,57"  onclick="callFun.addPitch(20)" />'+
																 '<area shape="rect" coords="20,57,30,67"  onclick="callFun.addPitch(21)" />'+
																 '<area shape="rect" coords="30,57,40,67"  onclick="callFun.addPitch(22)" />'+
																 '<area shape="rect" coords="40,57,50,67"  onclick="callFun.addPitch(23)" />'+
																 '<area shape="rect" coords="50,57,60,67"  onclick="callFun.addPitch(24)" />'+
																 '<area shape="rect" coords="60,57,70,67"  onclick="callFun.addPitch(25)" />'+
																 '<area shape="rect" coords="70,57,80,67"  onclick="callFun.addPitch(26)" />'+
															 	 '<area shape="rect" coords="80,57,90,67"  onclick="callFun.addPitch(27)" />'+
																 '<area shape="rect" coords="90,57,100,67"  onclick="callFun.addPitch(28)" />'+
															 	 '<area shape="rect" coords="100,57,110,67"  onclick="callFun.addPitch(29)" />'+
																 '<area shape="rect" coords="110,57,120,67"  onclick="callFun.addPitch(30)" />'+
																 '<area shape="rect" coords="20,67,30,77"  onclick="callFun.addPitch(31)" />'+
																 '<area shape="rect" coords="30,67,40,77"  onclick="callFun.addPitch(32)" />'+
																 '<area shape="rect" coords="40,67,50,77"  onclick="callFun.addPitch(33)" />'+
																 '<area shape="rect" coords="50,67,60,77"  onclick="callFun.addPitch(34)" />'+
																 '<area shape="rect" coords="60,67,70,77"  onclick="callFun.addPitch(35)" />'+
																 '<area shape="rect" coords="70,67,80,77"  onclick="callFun.addPitch(36)" />'+
																 '<area shape="rect" coords="80,67,90,77"  onclick="callFun.addPitch(37)" />'+
																 '<area shape="rect" coords="90,67,100,77"  onclick="callFun.addPitch(38)" />'+
																 '<area shape="rect" coords="100,67,110,77"  onclick="callFun.addPitch(39)" />'+
																 '<area shape="rect" coords="110,67,120,77"  onclick="callFun.addPitch(40)" />'+
																 '<area shape="rect" coords="20,77,30,87"  onclick="callFun.addPitch(41)" />'+
																 '<area shape="rect" coords="30,77,40,87"  onclick="callFun.addPitch(42)" />'+
																 '<area shape="rect" coords="40,77,50,87"  onclick="callFun.addPitch(43)" />'+
																 '<area shape="rect" coords="50,77,60,87"  onclick="callFun.addPitch(44)" />'+
																 '<area shape="rect" coords="60,77,70,87"  onclick="callFun.addPitch(45)" />'+
																 '<area shape="rect" coords="70,77,80,87"  onclick="callFun.addPitch(46)" />'+
																 '<area shape="rect" coords="80,77,90,87"  onclick="callFun.addPitch(47)" />'+
																 '<area shape="rect" coords="90,77,100,87"  onclick="callFun.addPitch(48)" />'+
																 '<area shape="rect" coords="100,77,110,87"  onclick="callFun.addPitch(49)" />'+
																 '<area shape="rect" coords="110,77,120,87"  onclick="callFun.addPitch(50)" />'+
																 '<area shape="rect" coords="20,87,30,97"  onclick="callFun.addPitch(51)" />'+
																 '<area shape="rect" coords="30,87,40,97"  onclick="callFun.addPitch(52)" />'+
																 '<area shape="rect" coords="40,87,50,97"  onclick="callFun.addPitch(53)" />'+
																 '<area shape="rect" coords="50,87,60,97"  onclick="callFun.addPitch(54)" />'+
																 '<area shape="rect" coords="60,87,70,97"  onclick="callFun.addPitch(55)" />'+
																 '<area shape="rect" coords="70,87,80,97"  onclick="callFun.addPitch(56)" />'+
																 '<area shape="rect" coords="80,87,90,97"  onclick="callFun.addPitch(57)" />'+
																 '<area shape="rect" coords="90,87,100,97"  onclick="callFun.addPitch(58)" />'+
																 '<area shape="rect" coords="100,87,110,97"  onclick="callFun.addPitch(59)" />'+
																 '<area shape="rect" coords="110,87,120,97"  onclick="callFun.addPitch(60)" />'+
																 '<area shape="rect" coords="20,97,30,107"  onclick="callFun.addPitch(61)" />'+
																 '<area shape="rect" coords="30,97,40,107"  onclick="callFun.addPitch(62)" />'+
																 '<area shape="rect" coords="40,97,50,107"  onclick="callFun.addPitch(63)" />'+
																 '<area shape="rect" coords="50,97,60,107"  onclick="callFun.addPitch(64)" />'+
																 '<area shape="rect" coords="60,97,70,107"  onclick="callFun.addPitch(65)" />'+
																 '<area shape="rect" coords="70,97,80,107"  onclick="callFun.addPitch(66)" />'+
																 '<area shape="rect" coords="80,97,90,107"  onclick="callFun.addPitch(67)" />'+
																 '<area shape="rect" coords="90,97,100,107"  onclick="callFun.addPitch(68)" />'+
																 '<area shape="rect" coords="100,97,110,107"  onclick="callFun.addPitch(69)" />'+
																 '<area shape="rect" coords="110,97,120,107"  onclick="callFun.addPitch(70)" />'+
																'<area shape="rect" coords="20,107,30,117"  onclick="callFun.addPitch(71)" />'+
																'<area shape="rect" coords="30,107,40,117"  onclick="callFun.addPitch(72)" />'+
																'<area shape="rect" coords="40,107,50,117"  onclick="callFun.addPitch(73)" />'+
																'<area shape="rect" coords="50,107,60,117"  onclick="callFun.addPitch(74)" />'+
																'<area shape="rect" coords="60,107,70,117"  onclick="callFun.addPitch(75)" />'+
																'<area shape="rect" coords="70,107,80,117"  onclick="callFun.addPitch(76)" />'+
																'<area shape="rect" coords="80,107,90,117"  onclick="callFun.addPitch(77)" />'+
																'<area shape="rect" coords="90,107,100,117"  onclick="callFun.addPitch(78)" />'+
																'<area shape="rect" coords="100,107,110,117"  onclick="callFun.addPitch(79)" />'+
																'<area shape="rect" coords="110,107,120,117"  onclick="callFun.addPitch(80)" />'+
																'<area shape="rect" coords="20,117,30,127"  onclick="callFun.addPitch(81)" />'+
																'<area shape="rect" coords="30,117,40,127"  onclick="callFun.addPitch(82)" />'+
																'<area shape="rect" coords="40,117,50,127"  onclick="callFun.addPitch(83)" />'+
																'<area shape="rect" coords="50,117,60,127"  onclick="callFun.addPitch(84)" />'+
																'<area shape="rect" coords="60,117,70,127"  onclick="callFun.addPitch(85)" />'+
																'<area shape="rect" coords="70,117,80,127"  onclick="callFun.addPitch(86)" />'+
																'<area shape="rect" coords="80,117,90,127"  onclick="callFun.addPitch(87)" />'+
																'<area shape="rect" coords="90,117,100,127"  onclick="callFun.addPitch(88)" />'+
																'<area shape="rect" coords="100,117,110,127"  onclick="callFun.addPitch(89)" />'+
																'<area shape="rect" coords="110,117,120,127"  onclick="callFun.addPitch(90)" />'+
																'<area shape="rect" coords="20,127,30,137"  onclick="callFun.addPitch(91)" />'+
																'<area shape="rect" coords="30,127,40,137"  onclick="callFun.addPitch(92)" />'+
																'<area shape="rect" coords="40,127,50,137"  onclick="callFun.addPitch(93)" />'+
																'<area shape="rect" coords="50,127,60,137"  onclick="callFun.addPitch(94)" />'+
																'<area shape="rect" coords="60,127,70,137"  onclick="callFun.addPitch(95)" />'+
																'<area shape="rect" coords="70,127,80,137"  onclick="callFun.addPitch(96)" />'+
																'<area shape="rect" coords="80,127,90,137"  onclick="callFun.addPitch(97)" />'+
																'<area shape="rect" coords="90,127,100,137"  onclick="callFun.addPitch(98)" />'+
																'<area shape="rect" coords="100,127,110,137"  onclick="callFun.addPitch(99)" />'+
																'<area shape="rect" coords="110,127,120,137"  onclick="callFun.addPitch(100)" />'+
																'<area shape="rect" coords="20,137,30,147"  onclick="callFun.addPitch(101)" />'+
																'<area shape="rect" coords="30,137,40,147"  onclick="callFun.addPitch(102)" />'+
																'<area shape="rect" coords="40,137,50,147"  onclick="callFun.addPitch(103)" />'+
																'<area shape="rect" coords="50,137,60,147"  onclick="callFun.addPitch(104)" />'+
																'<area shape="rect" coords="60,137,70,147"  onclick="callFun.addPitch(105)" />'+
																'<area shape="rect" coords="70,137,80,147"  onclick="callFun.addPitch(106)" />'+
																'<area shape="rect" coords="80,137,90,147"  onclick="callFun.addPitch(107)" />'+
																'<area shape="rect" coords="90,137,100,147"  onclick="callFun.addPitch(108)" />'+
																'<area shape="rect" coords="100,137,110,147"  onclick="callFun.addPitch(109)" />'+
																'<area shape="rect" coords="110,137,120,147"  onclick="callFun.addPitch(110)" />'+
																'<area shape="rect" coords="20,147,30,157"  onclick="callFun.addPitch(111)" />'+
																'<area shape="rect" coords="30,147,40,157"  onclick="callFun.addPitch(112)" />'+
																'<area shape="rect" coords="40,147,50,157"  onclick="callFun.addPitch(113)" />'+
																'<area shape="rect" coords="50,147,60,157"  onclick="callFun.addPitch(114)" />'+
																'<area shape="rect" coords="60,147,70,157"  onclick="callFun.addPitch(115)" />'+
																'<area shape="rect" coords="70,147,80,157"  onclick="callFun.addPitch(116)" />'+
																'<area shape="rect" coords="80,147,90,157"  onclick="callFun.addPitch(117)" />'+
																'<area shape="rect" coords="90,147,100,157"  onclick="callFun.addPitch(118)" />'+
																'<area shape="rect" coords="100,147,110,157"  onclick="callFun.addPitch(119)" />'+
																'<area shape="rect" coords="110,147,120,157"  onclick="callFun.addPitch(120)" />'+
																'<area shape="rect" coords="20,157,30,167"  onclick="callFun.addPitch(121)" />'+
																'<area shape="rect" coords="30,157,40,167"  onclick="callFun.addPitch(122)" />'+
																'<area shape="rect" coords="40,157,50,167"  onclick="callFun.addPitch(123)" />'+
																'<area shape="rect" coords="50,157,60,167"  onclick="callFun.addPitch(124)" />'+
																'<area shape="rect" coords="60,157,70,167"  onclick="callFun.addPitch(125)" />'+
																'<area shape="rect" coords="70,157,80,167"  onclick="callFun.addPitch(126)" />'+
																'<area shape="rect" coords="80,157,90,167"  onclick="callFun.addPitch(127)" />'+
																'<area shape="rect" coords="90,157,100,167"  onclick="callFun.addPitch(128)" />'+
																'<area shape="rect" coords="100,157,110,167"  onclick="callFun.addPitch(129)" />'+
																'<area shape="rect" coords="110,157,120,167"  onclick="callFun.addPitch(130)" />'+
																'<area shape="rect" coords="20,167,30,177"  onclick="callFun.addPitch(131)" />'+
																'<area shape="rect" coords="30,167,40,177"  onclick="callFun.addPitch(132)" />'+
																'<area shape="rect" coords="40,167,50,177"  onclick="callFun.addPitch(133)" />'+
																'<area shape="rect" coords="50,167,60,177"  onclick="callFun.addPitch(134)" />'+
																'<area shape="rect" coords="60,167,70,177"  onclick="callFun.addPitch(135)" />'+
																'<area shape="rect" coords="70,167,80,177"  onclick="callFun.addPitch(136)" />'+
																'<area shape="rect" coords="80,167,90,177"  onclick="callFun.addPitch(137)" />'+
																'<area shape="rect" coords="90,167,100,177"  onclick="callFun.addPitch(138)" />'+
																'<area shape="rect" coords="100,167,110,177"  onclick="callFun.addPitch(139)" />'+
																'<area shape="rect" coords="110,167,120,177"  onclick="callFun.addPitch(140)" />'+
																'<area shape="rect" coords="20,177,30,187"  onclick="callFun.addPitch(141)" />'+
																'<area shape="rect" coords="30,177,40,187"  onclick="callFun.addPitch(142)" />'+
																'<area shape="rect" coords="40,177,50,187"  onclick="callFun.addPitch(143)" />'+
																'<area shape="rect" coords="50,177,60,187"  onclick="callFun.addPitch(144)" />'+
																'<area shape="rect" coords="60,177,70,187"  onclick="callFun.addPitch(145)" />'+
																'<area shape="rect" coords="70,177,80,187"  onclick="callFun.addPitch(146)" />'+
																'<area shape="rect" coords="80,177,90,187"  onclick="callFun.addPitch(147)" />'+
																'<area shape="rect" coords="90,177,100,187"  onclick="callFun.addPitch(148)" />'+
																'<area shape="rect" coords="100,177,110,187"  onclick="callFun.addPitch(149)" />'+
																'<area shape="rect" coords="110,177,120,187"  onclick="callFun.addPitch(150)" />'+
																'<area shape="rect" coords="20,187,30,197"  onclick="callFun.addPitch(151)" />'+
																'<area shape="rect" coords="30,187,40,197"  onclick="callFun.addPitch(152)" />'+
																'<area shape="rect" coords="40,187,50,197"  onclick="callFun.addPitch(153)" />'+
																'<area shape="rect" coords="50,187,60,197"  onclick="callFun.addPitch(154)" />'+
																'<area shape="rect" coords="60,187,70,197"  onclick="callFun.addPitch(155)" />'+
																'<area shape="rect" coords="70,187,80,197"  onclick="callFun.addPitch(156)" />'+
																'<area shape="rect" coords="80,187,90,197"  onclick="callFun.addPitch(157)" />'+
																'<area shape="rect" coords="90,187,100,197"  onclick="callFun.addPitch(158)" />'+
																'<area shape="rect" coords="100,187,110,197"  onclick="callFun.addPitch(159)" />'+
																'<area shape="rect" coords="110,187,120,197"  onclick="callFun.addPitch(160)" />'+
																'<area shape="rect" coords="20,197,30,207"  onclick="callFun.addPitch(161)" />'+
																'<area shape="rect" coords="30,197,40,207"  onclick="callFun.addPitch(162)" />'+
																'<area shape="rect" coords="40,197,50,207"  onclick="callFun.addPitch(163)" />'+
																'<area shape="rect" coords="50,197,60,207"  onclick="callFun.addPitch(164)" />'+
																'<area shape="rect" coords="60,197,70,207"  onclick="callFun.addPitch(165)" />'+
																'<area shape="rect" coords="70,197,80,207"  onclick="callFun.addPitch(166)" />'+
																'<area shape="rect" coords="80,197,90,207"  onclick="callFun.addPitch(167)" />'+
																'<area shape="rect" coords="90,197,100,207"  onclick="callFun.addPitch(168)" />'+
																'<area shape="rect" coords="100,197,110,207"  onclick="callFun.addPitch(169)" />'+
																'<area shape="rect" coords="110,197,120,207"  onclick="callFun.addPitch(170)" />'+
																'<area shape="rect" coords="20,207,30,217"  onclick="callFun.addPitch(171)" />'+
																'<area shape="rect" coords="30,207,40,217"  onclick="callFun.addPitch(172)" />'+
																'<area shape="rect" coords="40,207,50,217"  onclick="callFun.addPitch(173)" />'+
																'<area shape="rect" coords="50,207,60,217"  onclick="callFun.addPitch(174)" />'+
																'<area shape="rect" coords="60,207,70,217"  onclick="callFun.addPitch(175)" />'+
																'<area shape="rect" coords="70,207,80,217"  onclick="callFun.addPitch(176)" />'+
																'<area shape="rect" coords="80,207,90,217"  onclick="callFun.addPitch(177)" />'+
																'<area shape="rect" coords="90,207,100,217"  onclick="callFun.addPitch(178)" />'+
																'<area shape="rect" coords="100,207,110,217"  onclick="callFun.addPitch(179)" />'+
																'<area shape="rect" coords="110,207,120,217"  onclick="callFun.addPitch(180)" />'+
                                                                 '</map>';
            }else if(flag=="2"){
              var image_path  = document.getElementById("wagon_wheel_id").src;
              document.getElementById("groundCanvas").innerHTML ="";
              document.getElementById("groundCanvas").innerHTML='<img src="'+ image_path+'"  width="228" height="348" id="wagon_wheel_id" border="0" usemap="#wagonwheelmap"/>'+
											                    '<map name="wagonwheelmap">'+
																'<area shape="poly" coords="96,225,96,274,128,274,128,225" alt="Bowler" onclick="callFun.addGround(1)"  />'+
																'<area shape="poly" coords="95,253,93,336,49,321,28,302,66,232,77,246" alt="Long Off" onclick="callFun.addGround(2)"  />'+
																'<area shape="poly" coords="11,207,60,183,62,222,66,234,28,302,14,277,11,252" alt="Deep Mid Off" onclick="callFun.addGround(3)"  />'+
																'<area shape="poly" coords="59,182,60,132,65,120,14,86,12,101,12,207" alt="Deep Cover" onclick="callFun.addGround(4)"  />'+
																'<area shape="poly" coords="167,144,217,144,217,97,213,82,159,114,165,124" alt="Deep Square Leg" onclick="callFun.addGround(5)"  />'+
																'<area shape="poly" coords="128,260,153,245,166,223,193,253,172,281,127,301" alt="Deep Mid On" onclick="callFun.addGround(6)"  />'+
																'<area shape="poly" coords="166,221,141,176,127,181,128,227,129,258,154,245" alt="Mid On" onclick="callFun.addGround(7)"  />'+
																'<area shape="poly" coords="142,174,126,148,128,180" alt="Silly Mid On" onclick="callFun.addGround(8)"  />'+
																'<area shape="poly" coords="126,148,168,147,167,226" alt="Mid Wicket" onclick="callFun.addGround(9)"  />'+
																'<area shape="poly" coords="217,144,217,262,215,276,167,224,168,143" alt="Deep Mid Wicket" onclick="callFun.addGround(10)"  />'+
																'<area shape="poly" coords="127,133,143,125,146,130,148,147,127,147" alt="Short Leg" onclick="callFun.addGround(11)"  />'+
																'<area shape="poly" coords="127,97,127,120,127,133,159,113,148,102" alt="Leg Sleep" onclick="callFun.addGround(12)"  />'+
																'<area shape="poly" coords="60,182,80,169,88,186,97,191,96,221,95,253,78,245,66,230,62,216" alt="Mid Off" onclick="callFun.addGround(13)"  />'+
																'<area shape="poly" coords="80,171,97,144,97,196,89,189" alt="Silly Mid Off" onclick="callFun.addGround(14)"  />'+
																'<area shape="poly" coords="65,123,83,129,82,144,60,148,59,135" alt="Point(Square Cover)" onclick="callFun.addGround(15)"  />'+
																'<area shape="poly" coords="82,144,80,156,60,168,60,148" alt="Silly Mid Off" onclick="callFun.addGround(16)"  />'+
																'<area shape="poly" coords="84,131,97,133,97,146,80,171,80,148" alt="Silly Point" onclick="callFun.addGround(17)"  />'+
																'<area shape="rect" coords="96,131,128,225" alt="Pitch" onclick="callFun.addGround(18)"  />'+
																'<area shape="poly" coords="95,275,128,275,128,335,93,335" alt="Straight Long" onclick="callFun.addGround(19)"  />'+
																'<area shape="poly" coords="62,123,74,107,96,99,96,111,86,117,76,128" alt="Slips" onclick="callFun.addGround(20)"  />'+
																'<area shape="poly" coords="79,124,87,115,97,112,96,131,84,130,78,128" alt="Gully" onclick="callFun.addGround(21)"  />'+
																'<area shape="poly" coords="60,166,59,184,81,168,80,155" alt="Extra Cover" onclick="callFun.addGround(22)"  />'+
																'<area shape="poly" coords="146,134,165,128,167,144,146,146" alt="Square Leg" onclick="callFun.addGround(23)"  />'+
																'<area shape="poly" coords="143,123,158,114,165,122,167,129,148,133" alt="Backward Square" onclick="callFun.addGround(24)"  />'+
																'<area shape="poly" coords="217,145,217,95,212,83,227,72,227,147" alt="Deep Square Leg Boundry" onclick="callFun.addGround(25)"  />'+
																'<area shape="poly" coords="129,335,93,335,94,347,129,347" alt="Straight Boundry" onclick="callFun.addGround(26)"  />'+
																'<area shape="poly" coords="97,346,96,336,81,333,53,322,31,301,0,348,5,346" alt="Long Off Boundry" onclick="callFun.addGround(27)"  />'+
																'<area shape="poly" coords="0,347,0,214,11,207,11,269,21,294,29,301" alt="Deep Mid Off Boundry" onclick="callFun.addGround(28)"  />'+
																'<area shape="poly" coords="0,213,0,77,14,84,13,99,13,205" alt="Deep Cover Boundry" onclick="callFun.addGround(29)"  />'+
																'<area shape="rect" coords="97,82,127,132" alt="Wicket Keeper" onclick="callFun.addGround(30)"  />'+
																'<area shape="rect" coords="97,22,127,82" alt="Long Stop" onclick="callFun.addGround(31)"  />'+
																'<area shape="rect" coords="97,0,128,22" alt="Long Stop Boundry" onclick="callFun.addGround(32)"  />'+
																'<area shape="poly" coords="226,72,226,0,128,0,128,21,151,23,175,33,190,47,206,65,214,80" alt="Deep Fine Leg Boundry" onclick="callFun.addGround(33)"  />'+
																'<area shape="poly" coords="128,22,127,97,148,102,154,107,159,114,214,80,208,67,183,40,175,33,148,24" alt="Deep fine leg" onclick="callFun.addGround(34)"  />'+
																'<area shape="poly" coords="14,84,65,121,75,106,89,100,98,98,98,21,80,23,59,32,41,43,23,65" alt="Third Man" onclick="callFun.addGround(35)"  />'+
																'<area shape="poly" coords="0,76,0,0,97,0,97,23,77,23,41,41,17,75,15,86" alt="Third man boundry" onclick="callFun.addGround(36)"  />'+
																'<area shape="poly" coords="216,143,226,144,226,287,214,275,216,264" alt="Deep Mid Wicket Boundry" onclick="callFun.addGround(37)"  />'+
																'<area shape="poly" coords="128,301,128,337,157,332,182,320,200,301,215,275,194,253,173,281" alt="Long On" onclick="callFun.addGround(38)"  />'+
																'<area shape="poly" coords="129,346,227,346,227,288,215,275,202,299,181,322,157,332,129,336" alt="Long On Boundry" onclick="callFun.addGround(39)"  />'+
											                    '</map>';
   			}

           // this.cnv.innerHTML = "";
        }
	};

	this._mkOvQds = function(cx, cy, x, y, w, h, wod, hod)
	{
		var xl = cx - x, xr = cx + x + wod - w, yt = cy - y, yb = cy + y + hod - h;
		if(xr > xl+w)
		{
			this._mkDiv(xr, yt, w, h);
			this._mkDiv(xr, yb, w, h);
		}
		else
			w = xr - xl + w;
		this._mkDiv(xl, yt, w, h);
		this._mkDiv(xl, yb, w, h);
	};

	this._mkArcDiv = function(x, y, oy, cx, cy, iOdds, aBndA, aBndZ, iSects)
	{
		var xrDef = cx + x + (iOdds & 0xffff), y2, h = oy - y, xl, xr, w;

		if(!h) h = 1;
		x = cx - x;

		if(iSects & 0xff0000) // Start-angle > end-angle
		{
			y2 = cy - y - h;
			if(iSects & 0x00ff)
			{
				if(iSects & 0x02)
				{
					xl = Math.max(x, aBndZ[y]);
					w = xrDef - xl;
					if(w > 0) this._mkDiv(xl, y2, w, h);
				}
				if(iSects & 0x01)
				{
					xr = Math.min(xrDef, aBndA[y]);
					w = xr - x;
					if(w > 0) this._mkDiv(x, y2, w, h);
				}
			}
			else
				this._mkDiv(x, y2, xrDef - x, h);
			y2 = cy + y + (iOdds >> 16);
			if(iSects & 0xff00)
			{
				if(iSects & 0x0100)
				{
					xl = Math.max(x, aBndA[y]);
					w = xrDef - xl;
					if(w > 0) this._mkDiv(xl, y2, w, h);
				}
				if(iSects & 0x0200)
				{
					xr = Math.min(xrDef, aBndZ[y]);
					w = xr - x;
					if(w > 0) this._mkDiv(x, y2, w, h);
				}
			}
			else
				this._mkDiv(x, y2, xrDef - x, h);
		}
		else
		{
			if(iSects & 0x00ff)
			{
				if(iSects & 0x02)
					xl = Math.max(x, aBndZ[y]);
				else
					xl = x;
				if(iSects & 0x01)
					xr = Math.min(xrDef, aBndA[y]);
				else
					xr = xrDef;
				y2 = cy - y - h;
				w = xr - xl;
				if(w > 0) this._mkDiv(xl, y2, w, h);
			}
			if(iSects & 0xff00)
			{
				if(iSects & 0x0100)
					xl = Math.max(x, aBndA[y]);
				else
					xl = x;
				if(iSects & 0x0200)
					xr = Math.min(xrDef, aBndZ[y]);
				else
					xr = xrDef;
				y2 = cy + y + (iOdds >> 16);
				w = xr - xl;
				if(w > 0) this._mkDiv(xl, y2, w, h);
			}
		}
	};

	this.setStroke(1);
	this.setFont("verdana,geneva,helvetica,sans-serif", "12px", Font.PLAIN);
	this.color = "#000000";
	this.htm = "";
	this.wnd = wnd || window;

	if(!jg_ok) _chkDHTM();
	if(jg_ok)
	{
		if(cnv)
		{
			if(typeof(cnv) == "string")
				this.cont = document.all? (this.wnd.document.all[cnv] || null)
					: document.getElementById? (this.wnd.document.getElementById(cnv) || null)
					: null;
			else if(cnv == window.document)
				this.cont = document.getElementsByTagName("body")[0];
			// If cnv is a direct reference to a canvas DOM node
			// (option suggested by Andreas Luleich)
			else this.cont = cnv;
			// Create new canvas inside container DIV. Thus the drawing and clearing
			// methods won't interfere with the container's inner html.
			// Solution suggested by Vladimir.
			this.cnv = this.wnd.document.createElement("div");
			this.cnv.style.fontSize=0;
			this.cont.appendChild(this.cnv);
			this.paint = jg_dom? _pntCnvDom : _pntCnvIe;
		}
		else
			this.paint = _pntDoc;
	}
	else
		this.paint = _pntN;

	this.setPrintable(false);
}

function _mkLinVirt(aLin, x1, y1, x2, y2)
{
	var dx = Math.abs(x2-x1), dy = Math.abs(y2-y1),
	x = x1, y = y1,
	xIncr = (x1 > x2)? -1 : 1,
	yIncr = (y1 > y2)? -1 : 1,
	p,
	i = 0;
	if(dx >= dy)
	{
		var pr = dy<<1,
		pru = pr - (dx<<1);
		p = pr-dx;
		while(dx > 0)
		{--dx;
			if(p > 0)    //  Increment y
			{
				aLin[i++] = x;
				y += yIncr;
				p += pru;
			}
			else p += pr;
			x += xIncr;
		}
	}
	else
	{
		var pr = dx<<1,
		pru = pr - (dy<<1);
		p = pr-dy;
		while(dy > 0)
		{--dy;
			y += yIncr;
			aLin[i++] = x;
			if(p > 0)    //  Increment x
			{
				x += xIncr;
				p += pru;
			}
			else p += pr;
		}
	}
	for(var len = aLin.length, i = len-i; i;)
		aLin[len-(i--)] = x;
};

function _CompInt(x, y)
{
	return(x - y);
}

