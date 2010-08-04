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
		
		public static const MALE_SELECTED:uint = 0x8080FF;
		public static const FEMALE_SELECTED:uint = 0xFF80FF;
		
		public static const MALE_UNSELECTED:uint = 0x0000FF;
		public static const FEMALE_UNSELECTED:uint = 0xFF00FF;
		
		public static const DEAD:uint = 0xEEEEEE;
		
		public const SPEED:Number = 0.2;
		public const SIZE:Number = 10;
		
		public var marriage: Marriage = null;
		public var parent_marriage:Marriage;
		
		public var gender: String = MALE;
		public var age: Number = 30;
		
		public var alive: Boolean = true;
		
		public var firstName: String = "James";
		public var surname: String = "Jubileeson";
		
		public var direction_x: Number;
		public var direction_y: Number;
		public var change_direction_time: Number;
		
		public var bitmap: BitmapData;
		public var selected:Boolean=false;
		public var over:Boolean=false;
		
		public function Person(parent:Marriage=null)
		{
			parent_marriage = parent;
			
			gender = Math.random() < 0.5 ? MALE : FEMALE;
			x = Math.random() * 400+20;
			y = Math.random() * 400+20;
			
			setHitbox(SIZE * 2, SIZE * 2,SIZE,SIZE);
			type = "Person";
			
			bitmap = new BitmapData(SIZE*2, SIZE*2, false, 0xFF000000);
			FP.rect.x = 2;
			FP.rect.y = 2;
			FP.rect.width = SIZE*2 - 4;
			FP.rect.height = SIZE*2 - 4;
			bitmap.fillRect(FP.rect, 0xFFFFFFFF);
			
			graphic = new Image(bitmap);
			graphic.x = -SIZE;
			graphic.y = -SIZE;
			
			var image:Image = graphic as Image;
			image.color = (gender == MALE ? MALE_UNSELECTED : FEMALE_UNSELECTED);
			
			change_direction_time = 2;
			change_direction()
			
			layer = -2;
		}
		
		public function select():void
		{
			selected = true;
		}
		
		public function unselect():void
		{
			selected = false;
		}
		
		public function hover_over():void
		{
			over = true;
		}
		
		public function change_direction():void
		{
			var angle:Number = Math.random() * 2 * Math.PI;
			direction_x = Math.cos(angle);
			direction_y = Math.sin(angle);
			
			if (marriage || parent_marriage)
			{
				var target_x:Number = 0;
				var target_y:Number = 0;
				var strength:Number = 1;
				if (marriage)
				{
					target_x = marriage.other(this).x;
					target_y = marriage.other(this).y;
					strength = 1.2
				}else {
					target_x = (parent_marriage.husband.x + parent_marriage.wife.x) * 0.5;
					target_y = (parent_marriage.husband.y + parent_marriage.wife.y) * 0.5;
					strength = 0.7
				}
				var diff_x:Number = target_x-x;
				var diff_y:Number = target_y-y;
				var diff_length:Number = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
				if (diff_length < 15) //If too close force apart.
				{
					diff_length = -diff_length;
				}
				diff_x = strength* diff_x / diff_length;
				diff_y = strength* diff_y / diff_length;
				direction_x = direction_x + diff_x;
				direction_y = direction_y + diff_y;
				var direction_length:Number = Math.sqrt(direction_x * direction_x + direction_y * direction_y);
				if (direction_length < 0.03)
				{
					direction_x = 1;
					direction_y = 0;
				}else
				{
					direction_x = direction_x / direction_length;
					direction_y = direction_y / direction_length;
				}
			}
			if (isNaN(direction_x) || isNaN(direction_y))
			{
				direction_x = 1;
				direction_y = 0;
			}
		}
		
		public function avoid_walls(new_x:Number,new_y:Number):Boolean
		{
			if (new_x<SIZE-40 || new_x>(675-SIZE))
			{
				change_direction()
				return false;
			}
			if (new_y<SIZE-23 || new_y>(500-SIZE))
			{
				change_direction()
				return false;
			}
			return true;

		}
		
		public override function update (): void
		{
			//Selection
			var image:Image = graphic as Image;
			image.color = (gender == MALE ? MALE_UNSELECTED : FEMALE_UNSELECTED);
			if (selected)
			{
				image.color = (gender == MALE ? MALE_SELECTED : FEMALE_SELECTED);
			}
			if (over)
			{
				image.color = (gender == MALE ? MALE_SELECTED : FEMALE_SELECTED);
				over = false;
			}
			if (alive == false)
			{
				image.color = DEAD;
			}
			//Timing
			age += 0.004;
			change_direction_time -= 0.01;
			if (change_direction_time < 0)
			{
				change_direction_time = 1 + Math.random();
				change_direction()
			}

			if (age > 70 && int(Math.random() * 600) == 1)
			{
				die();
			}
			
			//Movement
			var new_x:Number = x + (direction_x * SPEED);
			var new_y:Number = y + (direction_y * SPEED);
			
			if (alive)
			{
				avoid_walls(new_x, new_y);
			}
			
			x = new_x;
			y = new_y;
		}
		
		public function die():void 
		{
			if (marriage)
			{
				marriage.end_marriage();
			}
			var image:Image = graphic as Image;
			image.alpha = 0.4;
			layer = -3;
			type = "Corpse";
			
			alive = false;
		}
	}
}
