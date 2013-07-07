package ui {
	
	import flash.display.Sprite;
	
	public class RelaxationMeter extends Sprite {
		
		public var relaxationValue:Number = 0;
		
		public function RelaxationMeter() {
			// constructor code
		}
		
		public function update():void {
			if (relaxationValue > 0) {
				negativeMask.x = 238;
				positiveMask.x = 6 + relaxationValue * 2.33;
			}
			else {
				positiveMask.x = 6;
				negativeMask.x = 238 + relaxationValue * 2.33;
			}
		}
		
		
		
	}
}
