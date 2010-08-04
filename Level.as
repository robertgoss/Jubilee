package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	import Player;
	
	public class Level extends World
	{
		[Embed(source="assets/church_overview_2.png")]
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
		
		public var piety:Number = 0.5;
		
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
				selected = collidePoint("Person", mouseX, mouseY) as Person;
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
				hover = collidePoint("Person", mouseX, mouseY) as Person;
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
				var other:Person = collidePoint("Person", mouseX, mouseY) as Person;
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
			if (Input.mouseX < 10 && FP.camera.x>-80)
			{
				FP.camera.x = FP.camera.x-1;
			}
			
			if (Input.mouseX > 630 && FP.camera.x<80)
			{
				FP.camera.x = FP.camera.x+1;
			}
			if (Input.mouseY < 10  && FP.camera.y>-60)
			{
				FP.camera.y = FP.camera.y-1;
			}
			
			if (Input.mouseY > 470 && FP.camera.y<60)
			{
				FP.camera.y = FP.camera.y+1;
			}
			
			time += 0.002;
			
			yearText.text = "" + int(1994 + time);
			
			nextNewbie -= 0.002;
			
			if (nextNewbie < 0) {
				nextNewbie = 0.25 + Math.random()*0.5;
				
				var person: Person = new Person();
				
				person.age = Math.random()*40 + 18;
				
				person.x = 280 + Math.random() * 120 ;
				person.y = 455 + Math.random() * 30;
				
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
					Draw.linePlus(mouseX, mouseY, selected.x, selected.y, 0x000000);
				}
			}
			
			//Draw piety bar
			Draw.rect(FP.camera.x+570, ((1-piety)*400)+ FP.camera.y+40, 30, piety*400,0xF5B800);
		}

	}
	

}
