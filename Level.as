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
		
		public function Level()
		{
			add(new Entity(-80, -60, new Stamp(bgGfx)));
			
			var a: Person = new Person();
			var b: Person = new Person();
			var c: Person = new Person();
			var d: Person = new Person();
			
			add(a);
			add(b);
			add(c);
			add(d);
			
			var marriage: Marriage = new Marriage(a, b);
			
			a.marriage = marriage;
			b.marriage = marriage;
			
			marriage.children.push(c, d);
			
			add(marriage);
		}
		
	}
}
