/*modifyed Date:12-09-2008*/
function chkRule(){
					try{
				
						if($$('selRule')=='1'){
							bastmenObj.penailtyUpdate(5,1); // Batsman Run And Ball
							scoreObj.penailtyUpdate(5); // Add Run in scoreCard 
						}
						else if($$('selRule')=='2'){
							bastmenObj.penailtyUpdate(-5,1); // Batsman Run And Ball
							ballObj.updateRun(0);
							scoreObj.extraUpdate(-5); // Add Run in scoreCard 
						}
						else if($$('selRule')=='3'){
							bastmenObj.penailtyUpdate(-5,1); // Batsman Run And Ball
							ballObj.updateRun(0);
							scoreObj.extraUpdate(-5); // Add Run in scoreCard 
						}
						else if($$('selRule')=='4'){
							bastmenObj.penailtyUpdate(5,1); // Batsman Run And Ball
							ballObj.updateOverCell( row,COL_BALL_OVER,'1' )
							scoreObj.penailtyUpdate(5); // Add Run in scoreCard 
						
						}
						closePopup('BackgroundDiv','PopupDiv');
					}catch(err){
						alert(err.description,'Penailty.jsp.chkRule()');
					}
							
	}