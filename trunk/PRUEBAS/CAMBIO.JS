
function layerWrite(id,nestref,text) {
	if (ns4) {
		if (nestref) var lyr = eval('document.'+nestref+'.document.'+id+'.document')
		else var lyr = document.layers[id].document
		lyr.open()
		lyr.write(text)
		lyr.close()
	}
	else if (ie4) document.all[id].innerHTML = text
}

function linkOver(id,link,text) {
	layerWrite(id,null,'<A CLASS="negro" HREF="'+link+'" target="DER" onMouseOut="linkOut(\''+id+'\',\''+link+'\',\''+text+'\')">'+text+'</A>')
}

function linkOut(id,link,text) {
	layerWrite(id,null,'<A CLASS="blanco" HREF="'+link+'" target="DER" onMouseOver="linkOver(\''+id+'\',\''+link+'\',\''+text+'\')">'+text+'</A>')
}