package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	public class Marriage extends Entity
	{
		public var husband: Person = null;
		public var wife: Person = null;
		public var children: Vector.<Person> = new Vector.<Person>();
		
		public override function render (): void
		{
			Draw.linePlus(husband.x, husband.y, wife.x, wife.y, 0xFF0000);
			
			var midx: Number = (husband.x + wife.x) * 0.5;
			var midy: Number = (husband.y + wife.y) * 0.5;
			
			for each (var child: Person in children) {
				Draw.linePlus(midx, midy, child.x, child.y, 0x000000);
			}
		}
	}
}
