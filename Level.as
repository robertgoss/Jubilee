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
		}
	}
}
