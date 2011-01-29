<HTML>
<HEAD>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<TITLE>FDF Puslespil</TITLE>
<style type="text/css" media="screen">
* {
	margin: 0;
	padding: 0;
	background: transparent;
	font: 11px Arial;
}
</style>
</HEAD>
<BODY>

<?php 
if(!isset($_GET['id'])){
	print("<div style='border: 15px solid #666; margin: 30px auto; width: 300px; padding: 30px;'>Der skete en fejl, venligst kontakt brian.hauge@gmail.com hvis fejlen forts&aelig;tter med at v&aelig;re her.</div></body></html>");
	break;
}
switch($_GET['id']){
case('cecilia'):
//Cecilia
$url = "http://two.flash-gear.com/npuz/puz.php?c=f&o=1&id=2803453&k=42013085&s=15&w=495&h=480";
$size = 'WIDTH="645" HEIGHT="630"';
break;
case('pyt'):
//Pyt
$url = "http://three.flash-gear.com/npuz/puz.php?c=f&o=1&id=3672357&k=23231965&s=90&w=450&h=450";
$size = 'WIDTH="600" HEIGHT="600"';
break;
case('assistent'):
//Assistent
$url = "http://two.flash-gear.com/npuz/puz.php?c=f&o=1&id=2803510&k=16643892&s=60&w=540&h=540";
$size = 'WIDTH="690" HEIGHT="690"';
break;
case('pascal'):
//Pascal
$url = "http://five.flash-gear.com/npuz/puz.php?c=f&o=1&id=3843511&k=34020958&s=60&w=600&h=480";
$size = 'WIDTH="750" HEIGHT="630"';
break;
case('william'):
//William
$url = "http://three.flash-gear.com/npuz/puz.php?c=f&o=1&id=3672724&k=89325829&s=30&w=570&h=450";
$size = 'WIDTH="720" HEIGHT="600"';
break;
}

?>

 <OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
 codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
 <?php print($size); ?> id="puz" ALIGN="">
 <PARAM NAME=movie VALUE="<?php print($url); ?>">
 <PARAM NAME="wmode" value="transparent"> 
 <PARAM NAME=quality VALUE=high>
 <PARAM NAME=scale VALUE=noscale>
 <PARAM NAME=salign VALUE=LT>
 <EMBED src="<?php print($url); ?>" quality=high scale=noscale salign=LT wmode="transparent" <?php print($size); ?> NAME="puz" ALIGN=""
 TYPE="application/x-shockwave-flash" PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer">
 </EMBED>
</OBJECT>
 


</BODY>
</HTML>