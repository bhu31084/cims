/*modifyed Date:12-09-2008*/
var x;
var y;
var color;
var BtnNumber;
var jg_doc;
var flag = false;
function myDrawFunction() {
    var jg_doc = new jsGraphics("roundCanvas");
    var screenW = screen.width;
    var screenH = screen.height;
    var imgW = (22 / 100) * screenW
    var imgH = (35 / 100) * screenH
    var spaceTop = (45 / 100) * screenH
    var spaceLeft = (1 / 100) * screenW
    var origX = 0;
    var origY = 0;
    var startX = origX + spaceLeft;
    var startY = origY + spaceTop;
    var endX = startX + imgW;
    var endY = imgH;
    // jg_doc.paint();
    jg_doc.drawRect((Math.round(startX)), (Math.round(startY)), (Math.round(endX)), (Math.round(endY)));
    jg_doc.setColor("#3EC810");
    jg_doc.fillRect((Math.round(startX)), (Math.round(startY)), (Math.round(endX)), (Math.round(endY)));
    //outer rect
    //jg_doc.paint();

}


function myDrawRectangle() {
    var jg_doc = new jsGraphics("anotherCanvas");
    var screenW = screen.width;
    var screenH = screen.height;
    var imgW = (19 / 100) * screenW
    var imgH = (30 / 100) * screenH
    var spaceTop = (9 / 100) * screenH
    var spaceLeft = (0 / 100) * screenW
    var origX = 0;
    var origY = 0;
    var startX = origX + spaceLeft;
    var startY = origY + spaceTop;
    var endX = startX + imgW;
    var endY = startY + imgH;

    jg_doc.drawRect((Math.round(startX)), (Math.round(startY)), (Math.round(endX)), (Math.round(endY)));
    jg_doc.setColor("#006D37");
    jg_doc.fillRect((Math.round(startX)), (Math.round(startY)), (Math.round(endX)), (Math.round(endY)));
    //outer rect


    jg_doc.setColor("#CDB97A");
    // green
    var mp = Math.round((startX + endX) / 2)
    jg_doc.fillRect((mp - 35), (startY + ((5 / 100) * screenH)), 70, (endY - ((10 / 100) * screenH)));
    jg_doc.paint();

}
function myshow_coords(event) {

    var i = document.getElementById('ground');
    i.src = "Ground.BMP";


    //myDrawRectangle();
    //myDrawFunction();
    showLine(event)
}

function showLine(event, type) {
   var x = (window.event) ? window.event.x : event.clientX;
   var y = (window.event) ? window.event.y : event.clientY;
	if(jg_doc){
       //jg_doc.clear(); // 2 is set for ground img
		jg_doc.clear("2");
    }
	 //jg_doc = new jsGraphics("groundCanvas");
	 //jg_doc.clear();
   	 //var image = document.getElementById( 'wagon_wheel_id' );
   	 if(flag==false){// this logic when page is refresh than y pos will be 186
   	 	//jg_doc.drawLine(125,183,x , y );
   		 //Create jsGraphics object
   	     jg_doc = new jsGraphics(document.getElementById('groundCanvas'));
   	     //jg_doc.clear(); 
   	     //Create jsColor object
   	     var col = new jsColor("red");
   	     //Create jsPen object
   	     var pen = new jsPen(col,1);
   	     //Draw a Line between 2 points
   	     var pt1 = new jsPoint(125,183);
   	     var pt2 = new jsPoint(x,y);
   	     jg_doc.drawLine(pen,pt1,pt2);
   	 }else{
   	 	flag = true;
   	 	jg_doc.drawLine(112+findPosX(image),140 + findPosY(image) , x , y );
	 }
   
   	 //jg_doc.paint();
}
function showCir(event) {
   var x = (window.event) ? window.event.x : event.clientX;
   var y = (window.event) ? window.event.y : event.clientY;
    if(jg_doc){
       jg_doc.clear("1");  // 1 is set for pitch img
 	}
    jg_doc = new jsGraphics(document.getElementById('pitchCanvas'));
    //jg_doc.fillEllipse(x,y, 3, 3);
    var col = new jsColor("red");
    var pen = new jsPen(col,1);
    var pt2 = new jsPoint(x,y);
	jg_doc.fillEllipse(col,pt2,3,3);
	     
    //vertical line 1
   // jg_doc.paint();
    
    /*if((event.x >=10 && event.x <=184) &&(event.y >=400 && event.y <=800) ){

         }*/
}


function show_coords(event) {
    if ((event.x >= 189 && event.x <= 661) && (event.y >= 95 && event.y <= 500)) {
        var jg_doc = new jsGraphics("anotherCanvas");
        jg_doc.setColor("#FFFFFF");
        jg_doc.drawRect(100, 90, 500, 400);
        jg_doc.setColor("#3EC810");
        // green
        jg_doc.fillEllipse(200, 100, 350, 350);
        // co-ordinates related to the document left,top,width,height
        jg_doc.setColor("#3ED827");
        // green
        jg_doc.fillEllipse(300, 200, 150, 150);
        jg_doc.setColor("#FFFFFF");
        // White
        jg_doc.drawRect(370, 260, 10, 40);
        //drawRect(X, Y, width, height);
        //jg_doc.drawPolyline(new Array(50, 10, 120), new Array(10, 50, 70));
        x = event.x;
        y = event.y;
        if (BtnNumber == null) {
            alert("Please Click on Button");
            return false;

        }
        if (BtnNumber == "0") {
            color = "#C0C0C0"
        } else if (BtnNumber == "1") { // 1 Run
            color = "#9E9E9E"
        } else if (BtnNumber == "2") { // 2 Run
            color = "#FFFF99"
        } else if (BtnNumber == "3") { // 3 Run
            color = "#FF9900"
        } else if (BtnNumber == "4") { // 4 Run
            color = "#6666FF"
        } else if (BtnNumber == "5") { // 5 Run
            color = "#33CCCC"
        } else if (BtnNumber == "6") { // 6 Run
            color = "#FF3333"
        } else if (BtnNumber == "1Byes") { // 1 Bye
            color = "#9E9E9E"
        }

        jg_doc.setColor(color);
        jg_doc.drawLine(375, 260, x, y);
        if (BtnNumber == "1Byes") { // 1 Bye
            jg_doc.setColor(color);
            //		jg_doc.drawPolyline(new Array(50, 40, 60,50), new Array(10, 50, 10,10));
            jg_doc.drawPolyline(new Array(x - 10, x + 10, x + 10, x - 10), new Array(y + 10, y - 10, y, y + 10));
        }
        //jg_doc.paint();
    }
}
function groundChart(btnNo) {
    BtnNumber = btnNo;
}

function findPosX(obj)// use for find x position for object
  {
    var curleft = 0;
    if(obj.offsetParent)
        while(1) 
        {
          curleft += obj.offsetLeft;
          if(!obj.offsetParent)
            break;
          obj = obj.offsetParent;
        }
    else if(obj.x)
        curleft += obj.x;
    return curleft;
  }

  function findPosY(obj) // use for find y position for object
  {
    var curtop = 0;
    if(obj.offsetParent)
        while(1)
        {
          curtop += obj.offsetTop;
          if(!obj.offsetParent)
            break;
          obj = obj.offsetParent;
        }
    else if(obj.y)
        curtop += obj.y;
    return curtop;
  }
