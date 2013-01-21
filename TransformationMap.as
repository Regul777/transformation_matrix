package {

	import com.bit101.components.NumericStepper;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;

	[SWF(width=600, height=400, frameRate=31)]
	public class TransformationMap extends Sprite {
		[Embed(source="/assets/asset.swf", symbol="Boat")]
		private var BoatAsset:Class;

		private var _numericStepper:NumericStepper;
		private var _boatAsset:MovieClip;
		private var _targetPoint:Point;
		private const MAP_WIDTH:int = 114;
		private var _debugSprite:Sprite;

		public function TransformationMap() {
			// The boat graphic
			_boatAsset = new BoatAsset();
			_boatAsset.alpha = .25;
			addChild(_boatAsset);

			_debugSprite = new Sprite();
			addChild(_debugSprite);

			// Test UI
			_numericStepper = new NumericStepper(this, 200, 20, onNumberStepperChange);
			_numericStepper.value = 1;
			_numericStepper.minimum = 1;
			_numericStepper.maximum = _boatAsset.totalFrames;

			// Any point.
			_targetPoint = new Point(MAP_WIDTH / 2, 0);

			redrawGivenFrame();
		}

		private function onNumberStepperChange(event:Event):void {
			redrawGivenFrame();
		}

		private function redrawGivenFrame():void {
			_boatAsset.gotoAndStop(_numericStepper.value);
			var map:DisplayObject = _boatAsset.getChildByName("map");
			var transformMatrix:Matrix = map.transform.matrix;
			var transformedPoint:Point = transformMatrix.transformPoint(_targetPoint);
			_debugSprite.graphics.clear();
			_debugSprite.graphics.beginFill(0xFF00FF);
			_debugSprite.graphics.drawCircle(transformedPoint.x, transformedPoint.y, 5);
			_debugSprite.graphics.endFill();
		}
	}
}
