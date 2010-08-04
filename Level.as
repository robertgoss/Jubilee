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
		
		public var player:Player;
		
		public var selected:Person = null;
		public var hover:Person = null;
		
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
			var marriage:Marriage = new Marriage(a, b);
			add(marriage);
		}
		
		public override function update (): void
		{
			super.update();
			
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
					selected.unselect();
					selected = null;
					hover.unselect();
					hover = null;
				}
			}
			
			time += 0.002;
			
			yearText.text = "" + int(1994 + time);
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
