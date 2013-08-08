/*modifyed Date:12-09-2008*/
// Check to see if this is a Navigator brower


// Declare global variables

// Set the layer and style variables.

// Take the state passed in, andchange it.
function showState(id) {
 /*  eval("document" + layer + "['" + layerRef + "']" + style +
         ".visibility = '" + state + "'");    */
    document.getElementById(id).style.display='';

}
function hideState(id){
    document.getElementById(id).style.display='none';    
}