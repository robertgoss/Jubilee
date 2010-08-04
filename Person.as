package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	public class Person extends Entity
	{
		public static const MALE: String = "male";
		public static const FEMALE: String = "female";
		
		public var marriage: Marriage = null;
		
		public var gender: String = MALE;
		public var age: Number = 0;
		
		public var firstName: String = "James";
		public var surname: String = "Jubileeson";
		
		public function Person()
		{
			
		}
		
		public override function update ()
		{
			
		}
	}
}
