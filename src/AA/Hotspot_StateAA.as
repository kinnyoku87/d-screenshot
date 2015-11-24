package AA
{
	import configs.ViewConfig;
	
	import d2armor.Armor;
	import d2armor.animate.DelayMachine;
	import d2armor.display.AAFacade;
	import d2armor.display.ImageAA;
	import d2armor.display.StateAA;
	import d2armor.events.ATouchEvent;
	import d2armor.media.SfxManager;
	
	import util.ResUtil;

	public class Hotspot_StateAA extends StateAA
	{
		
		public function readyToReset() : void {
			_hotspotImgA.kill();
			_hotspotImgA = null;
			_hotspotImgAA.kill();
			_hotspotImgAA = null;
			
			_hotspotImgB = this.doCreateBlockB();
			//_hotspotImgB.y = 80;
		}
		
		override public function onEnter() : void {
			this.doInitHotspot();
			
		}
		
		
		private var _multiTouch:Boolean = true;
//		private var _multiTouch:Boolean;
		
		private var _hotspotImgA:ImageAA;
		private var _hotspotImgAA:ImageAA;
		private var _hotspotImgB:ImageAA;
		private var _launchDelayID:int = -1;
		
		private var _hotspotCount:int;
		
		
		
		private function doInitHotspot() : void {
			
			
			_hotspotImgAA = this.doCreateBlockA();
			_hotspotImgAA.y = this.getRoot().getAdapter().rootHeight - _hotspotImgAA.sourceHeight * ViewConfig.HOTSPOT_SCALE - 50;
			_hotspotImgA = this.doCreateBlockA();
			_hotspotImgA.x = this.getRoot().getAdapter().rootWidth - _hotspotImgA.sourceWidth * ViewConfig.HOTSPOT_SCALE;
			_hotspotImgA.y = this.getRoot().getAdapter().rootHeight / 2 - 200;
			
			
		}
		
		
		
		private function doCreateBlockA(): ImageAA {
			var block:ImageAA;
			
			block = new ImageAA;
			block.textureId = ResUtil.getTemp("block");
			this.getFusion().addNode(block);
			block.scaleX = block.scaleY = ViewConfig.HOTSPOT_SCALE;
			block.addEventListener(ATouchEvent.PRESS,     onPressBlock);
			block.addEventListener(ATouchEvent.UNBINDING, onUnbindingBlock);
			return block;
		}
		
		private function doCreateBlockB(): ImageAA {
			var block:ImageAA;
			
			block = new ImageAA;
			block.textureId = ResUtil.getTemp("block");
			this.getFusion().addNode(block);
			block.scaleX = block.scaleY = ViewConfig.HOTSPOT_SCALE;
			block.addEventListener(ATouchEvent.CLICK, function():void{
				getRoot().closeAllViews();
				getRoot().getView("bg").activate();
				getRoot().getView("hotspot").activate()
			});
			return block;
		}
		
		private function onPressBlock(e:ATouchEvent):void {
			if(_multiTouch){
				if(++_hotspotCount >= 2){
					_launchDelayID = DelayMachine.getInstance().delayedCall(ViewConfig.LAUNCH_DELAY, doShowScreenshot);
				}
			}
			else {
				if(_launchDelayID <= -1){
					_launchDelayID = DelayMachine.getInstance().delayedCall(ViewConfig.LAUNCH_DELAY, doShowScreenshot)
				}
			}
		}
		
		private function doShowScreenshot() : void {
			_launchDelayID = -1;
			this.getRoot().getView("screenshot").activate(null, 1);
			
			//SfxManager.getInstance().loadAndPlay("common/audio/4072.mp3");
		}
		
		private function onUnbindingBlock(e:ATouchEvent) : void{
			if(_multiTouch){
				if(_hotspotCount-- == 2){
					if(_launchDelayID >= 0){
						DelayMachine.getInstance().killDelayedCall(_launchDelayID);
						_launchDelayID = -1;
					}
					else {
						(this.getRoot().getView("screenshot").getState() as Screenshot_StateAA).interrupt();
						
						SfxManager.getInstance().loadAndPlay("common/audio/4072.mp3");
					}
				}
			}
			else {
				if(_launchDelayID >= 0){
					DelayMachine.getInstance().killDelayedCall(_launchDelayID);
					_launchDelayID = -1;
				}
				else {
					(this.getRoot().getView("screenshot").getState() as Screenshot_StateAA).interrupt();
					
					SfxManager.getInstance().loadAndPlay("common/audio/4072.mp3");
				}
			}
		}
		
	}
}