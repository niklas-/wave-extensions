// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// -> extensions/new.erb.html
//---------------------------------------------------------------------------------
function addValue(ref){

    if (ref.className == "notlink") {
        tmp = document.getElementById("extension_tag_list").value;
        tmp = tmp.replace(ref.innerHTML, '');
        document.getElementById("extension_tag_list").value = tmp;
        ref.className = "fakelink";
    }
    else 
        if (ref.className == "fakelink") {
            document.getElementById("extension_tag_list").value = document.getElementById("extension_tag_list").value + ref.innerHTML + " ";
            ref.className = "notlink";
        }
}

function clearValue(ref){

    document.getElementById("extension_tag_list").value = " ";
    
	clearNext(ref);
}

function clearNext(ref){
	
	if (ref==null){
		return
	}
	ref = get_nextsibling(ref);
	ref.className = "fakelink";
	clearNext(ref);
}
function get_nextsibling(n)
{
	var x=n.nextSibling;
	while (x.nodeType!=1)
	{
		x=x.nextSibling;
	}
	return x;
}
// extensions/new.erb.html <-
//---------------------------------------------------------------------------------


w = "/images/gre1.png";
b = "/images/blu1.png";
r = "/images/lit1.png";

var a = new Array();
var old = new Array();

/* initialize voting allowed array */
for(var i = 0; i < 100; i++)
{
	a[i] = "true";
}

/* initialize old state array */
for(var i = 0; i < 5; i++)
{
	old[i] = false;
}

function clickingAllowed(ref)
{
	var parentdiv = ref.parentNode;
	var i = parentdiv.id.lastIndexOf("_") + 1;
	var c = parentdiv.id.substr(i,parentdiv.id.length);
	
	return a[c];
}

/* save previous star rating */
function saveOldState(ref)
{
	var target = ref;
	var parent = ref.parentNode;
	var j = 0;
		
	for(var i = 0; i < parent.childNodes.length; i++)
	{
		var cur = parent.childNodes[i];
		
		
		if( cur.nodeType == 1)
		{
			if( cur.tagName == "IMG")
			{
				if (cur.name == "grey") {
					old[j] = false;
				} else {
					old[j] = true;	
				}
				j++;				
			}
		}
		
	}		
}

/* restore old state if no click has occured */
function restoreOldState(ref)
{
	var target = ref;
	var parent = ref.parentNode;
	var j = 0;
		
		
	for(var i = 0; i < parent.childNodes.length; i++)
	{
		var cur = parent.childNodes[i];
		//alert(parent.innerHMTL);
		
		if( cur.nodeType == 1)
		{
			if( cur.tagName == "IMG")
			{
				if (old[j] == false) {
					cur.name = "grey";
					cur.src = w;
				}
				else
				{
					cur.name = "gold";
					cur.src = r;
				}
				j++;				
			}
		}
		
	}		


}

function over(ref)
{

	if(!clickingAllowed(ref)) return;
	
	saveOldState(ref);

	var target = ref;
	var parent = ref.parentNode;
	
	allWhite(parent);
	
	var cur = target;

	for (var i = 0; i < target.alt; i++)
	{
		if(cur.tagName == "IMG")
		{
			cur.src = b;
			if(cur.alt != 1)
			{
				cur = get_previoussibling(cur);
			}
		}
	}

	setText(target);
}


function allWhite(ref)
{
	restoreOldState(ref);
	return;
	
	/*
	for(var i = 0; i < ref.childNodes.length; i++)
	{
		var cur = ref.childNodes[i];
		
		
		if( cur.nodeType == 1)
		{
			if( cur.tagName == "IMG")
			{
				if (cur.name == "grey") {
					cur.src = w;
				} else {
				    cur.src = r; 	
				}
				
			}
		}
	}
	*/
	
	
}

function MePreWhite(cur)
{
	
		if( cur.nodeType == 1)
		{
			if( cur.tagName == "IMG")
			{
				if (cur.name == "grey") {
					cur.src = w;
				} else {
				    cur.src = r; 	
				}
				
			}
		}
		cur = get_nextsibling(cur)
		if ( cur == null ){
			MePreWhite(cur)
		} else {
			return
		}
}

function setText(ref)
{
	//alert(ref);
	if(ref.alt == 1)
	{
		var tnode = findTextNode(ref);
		tnode.innerHTML = "1 Star";
	}
	else
	{
		var tnode = findTextNode(ref);
		tnode.innerHTML = ref.alt+" Stars";
	}
}

/* auslassen von text-nodes */
function get_previoussibling(n)
{
	var x=n.previousSibling;
	while (x.nodeType!=1)
	{
		x=x.previousSibling;
	}
	return x;
}

/* auslassen von text-nodes */
function get_nextsibling(n)
{
	var x=n.nextSibling;
	while (x.nodeType!=1)
	{
		x=x.nextSibling;
	}
	return x;
}

function findTextNode(ref)
{
	while(ref.tagName != "SPAN")
	{
		//alert(ref.tagName);
		ref = get_nextsibling(ref);
	}
	
	return ref;
}

function click(ref)
{
	var parentdiv = ref.parentNode;
	var i = parentdiv.id.lastIndexOf("_") + 1;
	var c = parentdiv.id.substr(i,parentdiv.id.length);
	
	a[c] = false;
	
	 /* dynamischer link */
	//var gotolink = "ratings/add/"+c+"?rating="+ref.alt;
	var gotolink = "rate/"+c+"?rating="+ref.alt;
	//alert(gotolink);
	window.location.pathname = gotolink;
}