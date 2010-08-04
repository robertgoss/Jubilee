package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	public class Level extends World
	{
		public function Level()
		{
			var a: Person = new Person();
			var b: Person = new Person();
			var c: Person = new Person();
			var d: Person = new Person();
			
			add(a);
			add(b);
			add(c);
			add(d);
			
			var marriage: Marriage = new Marriage();
			
			a.marriage = marriage;
			b.marriage = marriage;
			
			marriage.husband = a;
			marriage.wife = b;
			marriage.children.push(c, d);
			
			add(marriage);
		}
		
	}
}
