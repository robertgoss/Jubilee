package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	import flash.display.*;
	
	public class Person extends Entity
	{
		public static const MALE: String = "male";
		public static const FEMALE: String = "female";
		
		public var marriage: Marriage = null;
		
		public var gender: String = MALE;
		public var age: Number = 0;
		
		public var firstName: String = "James";
		public var surname: String = "Jubileeson";
		
		public function Person()
		{
			gender = Math.random() < 0.5 ? MALE : FEMALE;
			x = Math.random() * 400;
			y = Math.random() * 400;
			setHitbox(-15, -15, 30, 30);
			
			var bitmap: BitmapData = new BitmapData(30, 30, false, 0xFF000000);
			FP.rect.x = 2;
			FP.rect.y = 2;
			FP.rect.width = 26;
			FP.rect.height = 26;
			bitmap.fillRect(FP.rect, gender == MALE ? 0x0000FF : 0xFF00FF);
			
			graphic = new Stamp(bitmap);
			graphic.x = -15;
			graphic.y = -15;
		}
		
		public override function update (): void
		{
			
		}
	}
}
