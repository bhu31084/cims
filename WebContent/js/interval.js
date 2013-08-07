/*modifyed Date:12-09-2008*/
var intervalObj = new interval();// Create obj of bastment Class
function interval(){
	try{
		this.startTime = function (){	
			try{								
					var today=new Date();
					var h=today.getHours();
					var m=today.getMinutes();
					var startm =  today.getMinutes();
                    var s=today.getSeconds();
					// add a zero in front of numbers<10
					m=this.checkTime(m);
					s=this.checkTime(s);

                    $('txt').innerHTML= h+":"+m+":"+s;
					$('clock').value = m;		
					t=setTimeout('intervalObj.startTime()',500);					
			
			}catch(err){
				alert(err.description,'BCCI.js.interval.startTime()');
			}
		}
		// add a zero in front of numbers<10
		this.checkTime = function(i){
			try{
				if (i<10){
					i="0" + i;
				}
				return i;
			}catch(err){
				alert(err.description,'BCCI.js.interval.checkTime()');
			}	
		}
		//End of clock function
		//To start the clock on web page.
		
		this.call = function(){
			try{

				$('text').value=$('txt').innerHTML;

			}catch(err){
				alert(err.description,'BCCI.js.interval.call()');
			}
		}

		//To stop the clock.
		this.stopTime = function(){
			try{
				$('txtTime').value=$('txt').innerHTML;
                document.getElementById("txt").style.display = 'none';

            }catch(err){
				alert(err.description,'BCCI.js.interval.stopTime()');
			}
		}

		//To calculate the total time difference.
		this.calculateTotalTime = function() {
			try{
				var t1=$('text').value;
				var t2=$('txtTime').value;
				var arrt1 = t1.split(":");
				var arrt2 = t2.split(":");		
				var sub=(((arrt2[0]*3600)+(arrt2[1]*60)+(arrt2[2])*1)-((arrt1[0]*3600)+(arrt1[1]*60)+(arrt1[2])*1));
				var timeDifference=this.convertTime(sub);		
			return timeDifference;
			}catch(err){
				alert(err.description,'BCCI.js.interval.calculateTotalTime()');
			}	
		}
        this.calculatebatsmanTime = function(t1,t2) {
			try{
			
				var arrt1 = t1.split(":");
				var arrt2 = t2.split(":");
				var sub=(((arrt2[0]*3600)+(arrt2[1]*60)+(arrt2[2])*1)-((arrt1[0]*3600)+(arrt1[1]*60)+(arrt1[2])*1));
				var timeDifference=this.convertTime(sub);
			return timeDifference;
			}catch(err){
				alert(err.description,'BCCI.js.interval.calculateTotalTime()');
			}
		}

        //To Convert time.
		this.convertTime = function(sub){
			try{
				var hrs=parseInt(sub/3600);		
				var rem=(sub%3600);
				var min=parseInt(rem/60);
				var sec=(rem%60);
				min=this.checkTime(min);
				sec=this.checkTime(sec);
				var convertDifference=(hrs+":"+min+":"+sec);
			return convertDifference;
			}catch(err){
				alert(err.description,'BCCI.js.interval.convertTime()');
			}	
		}		
		//To display the time period of interruptions and intervals.
		
		this.DisplayInterval=function(flag){
	
			var MATCH_TIME_ACC=42000;//700min.
			var MATCH_INNING_ACC=21000;//350min.
	
			try{
				if($('text').value=="" && $('txtTime').value==""){
					alert("You Did Not Start Timer");
				}else if(flag==1){		
					alert("Interruption Time is::  "+this.calculateTotalTime());
				}else if(flag==2){	
					//Interval-Injury
					var time=this.calculateTotalTime();
					var arrtime = time.split(":");
					var sec=(arrtime[0]*3600)+(arrtime[1]*60)+(arrtime[2]*1);
					MATCH_TIME_ACC=MATCH_TIME_ACC+sec;//Adding minits in match_time account.
					var matchTime=this.convertTime(MATCH_TIME_ACC);
				
				}else if(flag==3){
						//Interval-Drink
						var time=this.calculateTotalTime();
						var arrtime = time.split(":");
						var sec=(arrtime[0]*3600)+(arrtime[1]*60)+(arrtime[2]*1);
						MATCH_TIME_ACC=MATCH_TIME_ACC+sec;//Adding minits in match_time account.
						var matchTime=this.convertTime(MATCH_TIME_ACC);
						MATCH_INNING_ACC=MATCH_INNING_ACC+sec;//Adding minits in match_inning Account
						var inningTime=this.convertTime(MATCH_INNING_ACC);
				}else if(flag==4){
						//Interval-Lunch/Tea.
						this.calculateTotalTime();
				}
			}catch(err){
				alert(err.description,'BCCI.js.interval.DisplayInterval()');
			}	
		}	
		
	}catch(err){
				alert(err.description,'BCCI.js.interval()');
	}		
}	

