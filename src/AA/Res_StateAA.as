package AA {
	import d2armor.display.StateAA;
	import d2armor.events.AEvent;
	import d2armor.resource.FilesBundle;
	import d2armor.resource.ResMachine;
	import d2armor.resource.handlers.AtlasAA_BundleHandler;
	import d2armor.resource.handlers.FrameClip_BundleHandler;
	import d2armor.resource.handlers.TextureAA_BundleHandler;
	
public class Res_StateAA extends StateAA {
	
	override public function onEnter() : void {
		var AY:Vector.<String>;
		
		this.resA = new ResMachine("common/");
		
		AY = new <String>
			[
				"temp/bg.png",
				"temp/bottomMenu.png", 
				"temp/head.png", 
				"temp/rightIcon.png", 
				"temp/screens1.png", 
				"temp/screens2.png", 
				"temp/vagueBg.png",
				"temp/loading.png",
				"temp/pen.png",
				
				"temp/alpha_mask.png",
				
				"temp/barA.png",
				"temp/barB.png",
				"temp/barC.png",
				
				"temp/block.png"
			]
		this.resA.addBundle(new FilesBundle(AY), new TextureAA_BundleHandler(1.0, false, false));
		
		
		AY = new <String>
		[
			"atlas/circle.atlas"
		]
		this.resA.addBundle(new FilesBundle(AY), new AtlasAA_BundleHandler(1.0, false, false));
				
		AY = new <String>
		[
			"data/frameClip_A.xml"
		]
		this.resA.addBundle(new FilesBundle(AY), new FrameClip_BundleHandler());
		
		this.resA.addEventListener(AEvent.COMPLETE, onComplete);
	}
	
	public var resA:ResMachine;
	
	private function onComplete(e:AEvent):void {
		var AY:Array;
		var i:int;
		var l:int;
		
		this.resA.removeAllListeners();
		this.getFusion().kill();
		
		AY = this.getArg(0);
		l = AY.length;
		while (i < l) {
			this.getRoot().getView(AY[i++]).activate();
		}
	}
}
}