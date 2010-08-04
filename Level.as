package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	import Player;
	
	public class Level extends World
	{
		[Embed(source="assets/church_overview_1.png")]
		public static var bgGfx: Class;
		
		public var yearText: Text;
		
		public var time: Number = 0;
		
		public var nextNewbie: Number = 0.5;
		
		public var pan:Boolean=false;
		
		public var player:Player;
		
		public var selected:Person = null;
		public var hover:Person = null;
		
		public var offset_x:Number = 0;
		public var offset_y:Number = 0;
		
		public function Level()
		{
			add(new Entity(-80, -60, new Stamp(bgGfx)));
			
			yearText = new Text("1994", 4, 4);
			
			add(new Entity(0, 0, yearText));
			
			var a: Person = new Person();
			var b: Person = new Person();
			var c: Person = new Person();
			var d: Person = new Person();
			
			add(a);
			add(b);
			add(c);
			add(d);
			
			player = new Player();
			add(player);
		}
		
		public function marry(a:Person, b:Person):void
		{
			if (a.marriage || b.marriage)
			{
				//They are already married bad karma
				return;
			}
			var marriage:Marriage = new Marriage(a, b);
			add(marriage);
		}
		
		public override function update (): void
		{
			super.update();
			
			aweful_control_code();
			
			time += 0.002;
			
			yearText.text = "" + int(1994 + time);
		}
		
		public function aweful_control_code():void
		{
			if (Input.mousePressed)
			{
				selected = collidePoint("Person", Input.mouseX, Input.mouseY) as Person;
				if (selected)
				{
					selected.select();
				}
			}
			if (Input.mouseDown)
			{
				if (hover)
				{
					hover.unselect()
					hover = null;
				}
				hover = collidePoint("Person", Input.mouseX, Input.mouseY) as Person;
				if (hover)
				{
					if (hover == selected)
					{
						hover = null;
					}else
					{
						hover.select()
					}
				}
				
			}
			if (Input.mouseReleased)
			{
				var other:Person = collidePoint("Person", Input.mouseX, Input.mouseY) as Person;
				if (other && selected)
				{
					marry(other, selected);
				}
				if (selected)
				{
					selected.unselect();
					selected = null;
				}
				if (hover)
				{
					hover.unselect();
					hover = null;
				}
			}
			//Panning
			if (mouseX < 10-offset_x && offset_x > -400)
			{
				offset_x = offset_x - 1;
				FP.screen.x = offset_x;
			}
			
			if (mouseX > 630-offset_x && offset_x < 400)
			{
				offset_x = offset_x + 1;
				FP.screen.x = offset_x;
			}
			if (mouseY < 10-offset_y offset_y > -400)
			{
				offset_y = offset_y - 1;
				FP.screen.y = offset_y;
			}
			
			if (mouseY > 470-offset_y  offset_y < 400)
			{
				offset_y = offset_y + 1;
				FP.screen.y = offset_y;
			}
			
			time += 0.002;
			
			yearText.text = "" + int(1994 + time);
			
			nextNewbie -= 0.002;
			
			if (nextNewbie < 0) {
				nextNewbie = 0.25 + Math.random()*0.5;
				
				var person: Person = new Person();
				
				person.age = Math.random()*40 + 18;
				
				if (Math.random() < 0.5) {
					var dirY: int = (Math.random() < 0.5) ? -1 : 1;
					person.y = 240 - dirY * (240 + person.SIZE);
					person.direction_y = dirY;
				} else {
					var dirX: int = (Math.random() < 0.5) ? -1 : 1;
					person.x = 320 - dirX * (320 + person.SIZE);
					person.direction_x = dirX;
				}
				
				add(person);
			}
		}
		
		public override function render():void
		{
			super.render()
			if (selected)
			{
				if (hover)
				{
					Draw.linePlus(hover.x, hover.y, selected.x, selected.y, 0x000000);
				}else {
					Draw.linePlus(Input.mouseX, Input.mouseY, selected.x, selected.y, 0x000000);
				}
			}
		}

	}
	

}
