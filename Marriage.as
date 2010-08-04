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
		
		public var age: Number = 0;
		
		public var nextBaby: Number = 4;
		
		public function Marriage (a: Person, b: Person)
		{
			husband = a;
			wife = b;
			husband.marriage = this;
			wife.marriage = this;
			
			layer = -1;
		}
		
		public override function update (): void
		{
			age += 0.01;
			nextBaby -= 0.01;
			
			if (nextBaby < 0) {
				nextBaby = 1.5;
				
				var child: Person = new Person();
				
				child.x = wife.x + Math.random() * 16 - 8;
				child.y = wife.y + Math.random() * 16 - 8;
				
				children.push(child);
				
				FP.world.add(child);
			}
			
		}
		
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
