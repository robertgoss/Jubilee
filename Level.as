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
		
		[Embed(source="assets/prayer_club.gif")]
		public static var prayer: Class;
		
		public var yearText: Text;
		
		public var time: Number = 0;
		
		public var nextNewbie: Number = 0.5;
		
		public var pan:Boolean=false;
		
		public var player:Player;
		
		public var selected:Person = null;
		public var hover:Person = null;
		
		public var offset_x:Number = 0;
		public var offset_y:Number = 0;
		
		public static const PAN_AREA: Number = 30;
		public static const MAX_PAN_SPEED: Number = 2;
		
		public var piety:Number = 0.5;
		public var pietySprite:Image; 
		
		
		public function Level()
		{
			addGraphic(new Stamp(bgGfx), 0, -80, -60);
			
			yearText = new Text("1994", 4, 4);
			yearText.scrollX = yearText.scrollY = 0;
			
			pietySprite = new Image(prayer);
			pietySprite.scrollX = pietySprite.scrollY = 0;
			pietySprite.scale = 0.4;
			
			addGraphic(pietySprite, -5, 570, 440);
			
			addGraphic(yearText);
			
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
			if (a == b)
			{
				piety = piety - 0.05;
				return;
			}
			if (a.alive == false || b.alive == false)
			{
				piety = piety - 0.4;
				return;
			}
			if (a.marriage)
			{
				piety = piety - 0.2;
				a.marriage.end_marriage();
			}
			if (b.marriage)
			{
				piety = piety - 0.2;
				b.marriage.end_marriage();
			}
			var marriage:Marriage = new Marriage(a, b);
			piety = piety + 0.01*marriage.piety;
			add(marriage);
		}
		
		public override function update (): void
		{
			super.update();
			
			aweful_control_code();
			
			time += 0.004;
			
			yearText.text = "" + int(1994 + time);
		}
		
		public function aweful_control_code():void
		{
			var last_hover:Person = hover;
			hover = collidePoint("Person", mouseX, mouseY) as Person;
			if (hover)
			{
				hover.hover_over();
			}
			
			if (Input.mousePressed)
			{
				selected = collidePoint("Person", mouseX, mouseY) as Person;
				if (selected)
				{
					selected.select();
				}
			}
			
			if (Input.mouseReleased)
			{
				if (selected)
				{
					if (hover)
					{
						marry(selected, hover)
					}
					selected.unselect();
					selected = null;
				}
			}
			
			var dx: Number, dy: Number;
			
			//Panning
			if (Input.mouseX < PAN_AREA)
			{
				dx = -(1.0 - Input.mouseX / PAN_AREA) * MAX_PAN_SPEED;
				FP.camera.x = Math.max(-80, FP.camera.x + dx);
			}
			
			if (Input.mouseX > 640 - PAN_AREA)
			{
				dx = (1.0 - (640 - Input.mouseX) / PAN_AREA) * MAX_PAN_SPEED;
				FP.camera.x = Math.min(80, FP.camera.x + dx);
			}
			
			if (Input.mouseY < PAN_AREA)
			{
				dy = -(1.0 - Input.mouseY / PAN_AREA) * MAX_PAN_SPEED;
				FP.camera.y = Math.max(-60, FP.camera.y + dy);
			}
			
			if (Input.mouseY > 480 - PAN_AREA)
			{
				dy = (1.0 - (480 - Input.mouseY) / PAN_AREA) * MAX_PAN_SPEED;
				FP.camera.y = Math.min(60, FP.camera.y + dy);
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
			if (piety < 0)
			{
				piety = 0;
			}
			if (piety > 1)
			{
				piety = 1;
			}
			Draw.rect(FP.camera.x + 565, FP.camera.y + 30, 40, 410, 0x000000);
			Draw.rect(FP.camera.x + 570, ((1 - piety) * 400) + FP.camera.y + 35, 30, piety * 400, 0xF5B800);
		}

	}
	

}
