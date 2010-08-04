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
		
		public const SPEED:Number = 0.4;
		public const SIZE:Number = 15;
		
		public var marriage: Marriage = null;
		
		public var gender: String = MALE;
		public var age: Number = 0;
		
		public var alive: Boolean = true;
		
		public var firstName: String = "James";
		public var surname: String = "Jubileeson";
		
		public var direction_x: Number;
		public var direction_y: Number;
		public var change_direction_time: Number;
		
		public function Person()
		{
			gender = Math.random() < 0.5 ? MALE : FEMALE;
			x = Math.random() * 400+20;
			y = Math.random() * 400+20;
			setHitbox(-SIZE, -SIZE, SIZE*2, SIZE*2);
			
			var bitmap: BitmapData = new BitmapData(SIZE*2, SIZE*2, false, 0xFF000000);
			FP.rect.x = 2;
			FP.rect.y = 2;
			FP.rect.width = SIZE*2 - 4;
			FP.rect.height = SIZE*2 - 4;
			bitmap.fillRect(FP.rect, gender == MALE ? 0x0000FF : 0xFF00FF);
			
			graphic = new Stamp(bitmap);
			graphic.x = -SIZE;
			graphic.y = -SIZE;
			
			change_direction_time = 2;
			change_direction()
		}
		
		public function change_direction():void
		{
			var angle:Number = Math.random() * 2 * Math.PI;
			direction_x = Math.cos(angle);
			direction_y = Math.sin(angle);
		}
		
		public function avoid_walls(new_x:Number,new_y:Number):Boolean
		{
			if (new_x<SIZE || new_x>(800-SIZE))
			{
				change_direction()
				return false;
			}
			if (new_y<SIZE || new_y>(600-SIZE))
			{
				change_direction()
				return false;
			}
			return true;
		}
		
		public override function update (): void
		{
			//Timing
			age += 0.01;
			change_direction_time -= 0.01;
			if (change_direction_time < 0)
			{
				change_direction_time = 1 + Math.random();
				change_direction()
			}
			
			//Movement
			var new_x:Number = x + (direction_x * SPEED);
			var new_y:Number = y + (direction_y * SPEED);
			
			//Collision
			if(avoid_walls(new_x, new_y)==true)
			{
				x = new_x;
				y = new_y;
			}
		}
	}
}
