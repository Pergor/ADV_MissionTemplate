/*
 * Author: Belbo
 *
 * Add group names of player groups you want to start the mission with specific radio channels (Currently TFAR-only).
 *
 */
 
//add group names according to their predefined channels here:

//Short Range Channels:
//SR channel 1 (default channel):
_sr_channel_1 = [
	//command groups:
	"JUPITER","NATTER","LUCHS","MILAN"
	//pilot groups:
	,"APOLLO","DRACHE","ORCA","FALKE"
	//support groups:
	,"MERKUR","GEPARD","ELSTER"
	//recon/sniper groups:
	,"DIANA","JAGUAR","VIPER","HABICHT"
	//vehicle groups:
	,"SATURN","OZELOT","GREIF"
	//game master groups:
	,"ZEUS"
];
//SR channel 2:
_sr_channel_2 = ["MARS","ANAKONDA","LÖWE","ADLER"];
//SR channel 3:
_sr_channel_3 = ["DEIMOS","BOA","TIGER","BUSSARD"];
//SR channel 4:
_sr_channel_4 = ["PHOBOS","COBRA","PANTHER","CONDOR"];
//SR channel 5:
_sr_channel_5 = ["VULKAN","LEOPARD","DROSSEL"];
//SR channel 6:
_sr_channel_6 = [];
//SR channel 7:
_sr_channel_7 = [];
//SR channel 8:
_sr_channel_8 = [];
 
//Long Range Channels:
//LR channel 1 is reserved for vehicles!
//LR channel 2 (combat/default channel):
_lr_channel_2 = [
	"JUPITER","NATTER","LUCHS","MILAN"
	,"MARS","ANAKONDA","LÖWE","ADLER"
];
//LR channel 3 (combat channel):
_lr_channel_3 = [];
//LR channel 4 (combat channel):
_lr_channel_4 = [];
//LR channel 4 (combat channel):
_lr_channel_4 = [];
//LR channel 5 (combat channel):
_lr_channel_5 = [];
//LR channel 6 (combat channel):
_lr_channel_6 = [];
//LR channel 7 (combat support):
_lr_channel_7 = [
	//pilot groups:
	"APOLLO","DRACHE","ORCA","FALKE"
	//recon/sniper groups:
	,"DIANA","JAGUAR","VIPER","HABICHT"
];
//LR channel 8 (logistical support):
_lr_channel_8 = [
	//logistical support groups:
	"MERKUR","GEPARD","ELSTER"
	//medical support groups:
	,"AESKULAP"
];
//LR channel 9 (Admin/Game Master):
_lr_channel_9 = [
	"ZEUS"
];

	///// DON'T edit below this line /////
	
private _return = [
	_sr_channel_1,_sr_channel_2,_sr_channel_3,_sr_channel_4,_sr_channel_5,_sr_channel_6,_sr_channel_7,_sr_channel_8
	,_lr_channel_2,_lr_channel_3,_lr_channel_4,_lr_channel_5,_lr_channel_6,_lr_channel_7,_lr_channel_8,_lr_channel_9
];

_return