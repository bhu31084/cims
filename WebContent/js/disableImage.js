/*created date 22/09/08*/
function Disable( doDisable )
{
	showHide( 'dotBallDiv' );
	showHide( 'oneRunDiv' );
	showHide( 'twoRunsDiv' );
	showHide( 'threeRunsDiv' );
	showHide( 'fourRunsDiv' );
	showHide( 'sixRunsDiv' );
	showHide( 'wideDiv' );
	showHide( 'noBallDiv' );
	showHide( 'noBallBatDiv' );
	showHide( 'byesDiv' );
	showHide( 'legByesDiv' );
	showHide( 'penaltyDiv' );
	showHide( 'dismissalDiv' );
	showHide( 'retiresDiv' );
	showHide( 'forceEndDiv' );
	showHide( 'pauseInnDiv' );
	showHide( 'endInnDiv' );
	showHide( 'switchBatDiv' );
	showHide( 'changeBwlrDiv' );
	showHide( 'newBallDiv' );
	showHide( 'pwrPlayDiv' );
	showHide( 'extraDiv' );
	
}
	
function showHide( itemId ){
	var element= document.getElementById( itemId );
	var bgEle = document.getElementById( itemId + 'Bag' );
	var startElement = document.getElementById('StartDiv');

	if( element.style.display == 'none' ){
		element.style.display = 'block'
		bgEle.style.display = 'none'
		startElement.style.display = 'none'
		
	}
}