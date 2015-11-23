package initializers {
	import flash.display.Stage;
	
	import AA.Bg_StateAA;
	import AA.Hotspot_StateAA;
	import AA.Res_StateAA;
	import AA.Screenshot_StateAA;
	
	import d2armor.Armor;
	import d2armor.core.Adapter;
	import d2armor.core.IInitializer;
	import d2armor.display.AAFacade;
	import d2armor.display.RootAA;
	import d2armor.events.AEvent;
	import d2armor.resource.ResMachine;
	import d2armor.resource.converters.AtlasAssetConvert;
	import d2armor.resource.converters.SwfClassAssetConverter;
	
	import util.CameraUtil;
	

	public class Initializer151117_A implements IInitializer {
		
		private var _adapter:Adapter;
		private var _rootAA:RootAA;
		
		public function onInit( stage:Stage ) : void {
			//stage.quality = StageQuality.LOW;
			//stage.quality = StageQuality.MEDIUM
			//stage.quality = StageQuality.HIGH;
			
			this._adapter = Armor.createAdapter(stage, false);
			
			ResMachine.activate(SwfClassAssetConverter);
			ResMachine.activate(AtlasAssetConvert);
			
			AAFacade.registerView("res",        Res_StateAA);
			AAFacade.registerView("bg",         Bg_StateAA);
			AAFacade.registerView("hotspot",    Hotspot_StateAA);
			AAFacade.registerView("screenshot", Screenshot_StateAA);

			_rootAA = AAFacade.createRoot(this._adapter, 0x0, true);
			_rootAA.addEventListener(AEvent.START, onStart);
		}
		
		private function onStart(e:AEvent):void {	
			_rootAA.removeEventListener(AEvent.START, onStart);
			
			_rootAA.getView("res").activate([["bg", "hotspot"]]);
			//_rootAA.getView("res").activate([["bg", "screenshot"]]);
			
//			_rootAA.getNode().doubleClickEnabled = true;
//			_rootAA.getNode().addEventListener(ATouchEvent.DOUBLE_CLICK, function(e:ATouchEvent):void{
//				_rootAA.getView("screenSplit").activate();
//			});
		}
	}
}