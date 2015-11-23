package {
	import flash.display.Sprite;
	import flash.ui.Multitouch;
	
	import d2armor.Armor;
	import d2armor.core.DesktopPlatform;
	import d2armor.core.MobilePlatform;
	import d2armor.logging.DebugLogger;
	import d2armor.logging.FlashTextLogger;
	import d2armor.logging.ILogger;
	
	import initializers.Initializer151117_A;
	
	[SWF(width = "450", height = "800", backgroundColor = "0x0", frameRate = "60")]
public class Main extends Sprite {
	
	public function Main() {
		var logger:ILogger;
		
//		stage.addChild(new Stats(0, 0));

		logger = new DebugLogger();
	
		//logger = new FlashTextLogger(stage, true, 300, 330, 330, true);
		//logger.visible = true;
		
		Armor.getLog().logger = logger;

		if(Multitouch.maxTouchPoints == 0){
			Armor.startup(1080, 1920, new DesktopPlatform, stage, Initializer151117_A);
			//			Security.allowDomain("*");
		}
		else{
			Armor.startup(1080, 1920, new MobilePlatform(false), stage, Initializer151117_A);
		}
	}
}
}