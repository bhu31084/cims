/*modifyed Date:12-09-2008*/
/*
	Color For Runs
	0 Run: #C0C0C0
	1 Run: #9E9E9E
	2 Run : #FFFF99
	3 Run : #FF9900
	4 Run : #6666FF
	5 Run : #33CCCC
	6 Run : #FF3333

*/

var x;
var y;
var color;
var BtnNumber;
var jg_doc;

function myDrawFunction(){
		var combo = document.getElementById("team").value
		 jg_doc = new jsGraphics("anotherCanvas");
		 jg_doc.clear();
		
		 jg_doc.setColor("#FFFFFF");

		 jg_doc.fillRect(100,90,500,400);	
		 jg_doc.setColor("#3EC810" ); // green
		 jg_doc.fillEllipse(200, 100, 350, 350); // co-ordinates related to the document left,top,width,height
		 jg_doc.setColor("#3ED827"); // green
		 jg_doc.fillEllipse(300, 200, 150, 150);	

		 jg_doc.setColor("#FFFFFF"); // White
		 jg_doc.drawRect(370,260,10,40); //drawRect(X, Y, width, height); 
		 //jg_doc.drawPolyline(new Array(50, 10, 120), new Array(10, 50, 70)); 

	if(combo=="All"){
		
			color="#FF3333";	// 6 run
			jg_doc.setColor(color);
			jg_doc.drawLine(375,260,545,309);
			jg_doc.drawLine(375,260,560,285);
			jg_doc.drawLine(375,260,505,150);  
		
			color="#6666FF";	 // 4 Run
			jg_doc.setColor(color);
			jg_doc.drawLine(375,260,533,202);
			jg_doc.drawLine(375,260,372,450);

			color="#FF9900";	// 3 Run
			jg_doc.setColor(color);
			jg_doc.drawLine(375,260,243,350);
			jg_doc.drawLine(375,260,450,392);

			color="#9E9E9E";	// 1 Run
			jg_doc.setColor(color);
			jg_doc.drawLine(375,260,297,210);
			
			 
	}
	else if(combo=="Sachin"){
			
			color="#FF3333";	// 6 run
			jg_doc.setColor(color);
			jg_doc.drawLine(375,260,545,309);
			
			color="#6666FF";	 // 4 Run
			jg_doc.setColor(color);
			jg_doc.drawLine(375,260,533,202);
			

			
			color="#9E9E9E";	// 1 Run
			jg_doc.setColor(color);
			jg_doc.drawLine(375,260,297,210);
			

	}
	 jg_doc.paint();
}

