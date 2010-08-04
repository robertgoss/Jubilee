package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	public class Level extends World
	{
		[Embed(source="assets/church_overview_1.png")]
		public static var bgGfx: Class;
		
		public var yearText: Text;
		
		public var time: Number = 0;
		
		public var nextNewbie: Number = 0.5;
		
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
			
			var marriage: Marriage = new Marriage(a, b);
			
			marriage.children.push(c, d);
			
			add(marriage);
		}
		
		public override function update (): void
		{
			super.update();
			
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

	}
}
